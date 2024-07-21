#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("kprobe/bpf_prog_load")
int bpf_prog_load_hook(struct pt_regs *ctx) {
    bpf_printk("bpf_prog_load called\n");
    return 0;
}

char LICENSE[] SEC("license") = "GPL";
