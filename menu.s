cat << 'EOF' > menu.s
.section .data
msg_header: .string "\n==========================\n"
msg_title:  .string "      MY CUSTOM OS        \n"
msg_opt1:   .string "  1. Start System         \n"
msg_opt2:   .string "  2. Memory Test          \n"
msg_opt3:   .string "  3. Shutdown             \n"
msg_footer: .string "==========================\n\n"

.section .text
.global _start

_start:
    # --- Print Header ---
    li a0, 1              # File descriptor 1 (stdout)
    la a1, msg_header     # Load address of string
    li a2, 28             # Length
    li a7, 64             # Syscall: Write
    ecall

    # --- Print Title ---
    li a0, 1
    la a1, msg_title
    li a2, 28
    li a7, 64
    ecall

    # --- Print Option 1 ---
    li a0, 1
    la a1, msg_opt1
    li a2, 28
    li a7, 64
    ecall

    # --- Print Option 2 ---
    li a0, 1
    la a1, msg_opt2
    li a2, 28
    li a7, 64
    ecall

    # --- Print Option 3 ---
    li a0, 1
    la a1, msg_opt3
    li a2, 28
    li a7, 64
    ecall

    # --- Print Footer ---
    li a0, 1
    la a1, msg_footer
    li a2, 28
    li a7, 64
    ecall

    # --- Exit Program ---
    li a0, 0
    li a7, 93             # Syscall: Exit
    ecall
EOF