from bcc import BPF

# BPF program
bpf_program = """
int trace_bpf_prog_load(struct pt_regs *ctx) {
    bpf_trace_printk("bpf_prog_load called\\n");
    return 0;
}
"""

# Load BPF program
b = BPF(text=bpf_program)

# Attach kprobe to bpf_prog_load
b.attach_kprobe(event="bpf_prog_load", fn_name="trace_bpf_prog_load")

print("Tracing bpf_prog_load... Ctrl+C to exit.")

# Print trace output
b.trace_print()
