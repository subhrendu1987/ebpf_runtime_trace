from bcc import BPF

# BPF program to trace the read system call
bpf_program = """
#include <linux/sched.h>
#include <linux/uio.h>

int trace_read(struct pt_regs *ctx, unsigned int fd, char __user *buf, size_t count) {
    bpf_trace_printk("Read system call: fd = %d, count = %lu\\n", fd, count);
    return 0;
}
"""

# Initialize BPF
b = BPF(text=bpf_program)

# Attach BPF program to the read system call
b.attach_kprobe(event="sys_read", fn_name="trace_read")

print("Tracing read system call... Ctrl+C to exit.")

# Print trace output
b.trace_print()
