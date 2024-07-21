# Makefile

CLANG = clang
BPFTOOL = bpftool
KERNEL_HEADERS = /usr/src/linux-headers-$(shell uname -r)
CFLAGS = -I$(KERNEL_HEADERS)/include

BPF_PROG = bpf_prog_load_kprobe
BPF_PROG_SRC = $(BPF_PROG).c
BPF_PROG_OBJ = $(BPF_PROG).o

.PHONY: all clean load

all: $(BPF_PROG_OBJ)

$(BPF_PROG_OBJ): $(BPF_PROG_SRC)
	$(CLANG) -O2 -target bpf $(CFLAGS) -c $(BPF_PROG_SRC) -o $(BPF_PROG_OBJ)

load: $(BPF_PROG_OBJ)
	sudo $(BPFTOOL) prog load $(BPF_PROG_OBJ) /sys/fs/bpf/$(BPF_PROG)
	sudo $(BPFTOOL) prog attach /sys/fs/bpf/$(BPF_PROG) kprobe bpf_prog_load

clean:
	rm -f $(BPF_PROG_OBJ)
	sudo rm -f /sys/fs/bpf/$(BPF_PROG)
