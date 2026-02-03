.section .rodata

    .macro ESC seq
        .string "\x1b[\seq\()m"
    .endm

col_hdr:    ESC 1;34
col_opt:    ESC 1;33
col_rst:    ESC 0

hdr_top:    .string "\n\xE2\x95\x94\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x94\n"
hdr_bot:    .string "\xE2\x95\x9A\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x90\xE2\x95\x9B\n"

title:      .string "   MY CUSTOM OS   "
opt1:       .string "1. Start System"
opt2:       .string "2. Memory Test"
opt3:       .string "3. Shutdown"
blank:      .string "\n"

    .set col_hdr_len, 7
    .set col_opt_len, 7
    .set col_rst_len, 4

    .set hdr_top_len, hdr_top_bot - hdr_top
    .set hdr_bot_len, hdr_bot_end - hdr_bot
    .set title_len,   title_end - title
    .set opt1_len,    opt1_end - opt1
    .set opt2_len,    opt2_end - opt2
    .set opt3_len,    opt3_end - opt3
    .set blank_len,   blank_end - blank

hdr_top_bot: .skip 0
hdr_bot_end: .skip 0
title_end:   .skip 0
opt1_end:    .skip 0
opt2_end:    .skip 0
opt3_end:    .skip 0
blank_end:   .skip 0

menu_table:
    .quad col_hdr
    .quad col_hdr_len
    .quad hdr_top
    .quad hdr_top_len
    .quad col_rst
    .quad col_rst_len
    .quad col_opt
    .quad col_opt_len
    .quad title
    .quad title_len
    .quad col_rst
    .quad col_rst_len
    .quad blank
    .quad blank_len
    .quad opt1
    .quad opt1_len
    .quad blank
    .quad blank_len
    .quad opt2
    .quad opt2_len
    .quad blank
    .quad blank_len
    .quad opt3
    .quad opt3_len
    .quad blank
    .quad blank_len
    .quad hdr_bot
    .quad hdr_bot_len
    .quad col_rst
    .quad col_rst_len

    .equ MENU_ITEMS, ( ( . - menu_table ) / 16 )

    .section .text
    .global kernel_main

kernel_main:
    la   s0, menu_table
    li   t0, MENU_ITEMS

print_loop:
    beqz t0, done

    ld   a1, 0(s0)
    ld   a2, 8(s0)
    
    call uart_write

    addi s0, s0, 16
    addi t0, t0, -1
    j    print_loop

done:
    ret

uart_write:
    li   t3, 0x10000000

write_char_loop:
    beqz a2, write_finished
    lb   t4, 0(a1)
    sb   t4, 0(t3)
    addi a1, a1, 1
    addi a2, a2, -1
    j    write_char_loop

write_finished:
    ret