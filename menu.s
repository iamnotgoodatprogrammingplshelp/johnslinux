    .section .rodata
esc_blue:   .string "\x1b[1;34m"
.set esc_blue_len, . - esc_blue - 1
esc_yellow: .string "\x1b[1;33m"
.set esc_yellow_len, . - esc_yellow - 1
esc_reset:  .string "\x1b[0m"
.set esc_reset_len, . - esc_reset - 1
hdr_top:    .string "\n┌───────────────────────┐\n"
.set hdr_top_len, . - hdr_top - 1
hdr_bot:    .string "└───────────────────────┘\n"
.set hdr_bot_len, . - hdr_bot - 1
title:      .string "   MY CUSTOM OS   "
.set title_len, . - title - 1
opt1:       .string "1. Start System"
.set opt1_len, . - opt1 - 1
opt2:       .string "2. Memory Test"
.set opt2_len, . - opt2 - 1
opt3:       .string "3. Shutdown"
.set opt3_len, . - opt3 - 1
nl:         .string "\n"
.set nl_len, . - nl - 1
menu_table:
    .quad esc_blue
    .quad esc_blue_len
    .quad hdr_top
    .quad hdr_top_len
    .quad esc_reset
    .quad esc_reset_len
    .quad esc_yellow
    .quad esc_yellow_len
    .quad title
    .quad title_len
    .quad esc_reset
    .quad esc_reset_len
    .quad nl
    .quad nl_len
    .quad opt1
    .quad opt1_len
    .quad nl
    .quad nl_len
    .quad opt2
    .quad opt2_len
    .quad nl
    .quad nl_len
    .quad opt3
    .quad opt3_len
    .quad nl
    .quad nl_len
    .quad hdr_bot
    .quad hdr_bot_len
    .quad esc_reset
    .quad esc_reset_len
.equ MENU_ITEMS, ( . - menu_table ) / 16
.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.equ STDOUT, 1
    .section .text
    .global _start
_start:
    la s0, menu_table
    li t0, MENU_ITEMS
print_loop:
    beqz t0, exit
    ld a1, 0(s0)
    ld a2, 8(s0)
    li a0, STDOUT
    li a7, SYS_WRITE
    ecall
    addi s0, s0, 16
    addi t0, t0, -1
    j print_loop
exit:
    li a0, 0
    li a7, SYS_EXIT
    ecall
