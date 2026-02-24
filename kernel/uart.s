.global uart_init
.type uart_init, @function
uart_init:
    mov $0x3f8, %dx
    add $1, %dx
    mov $0x00, %al
    outb %al, %dx
    
    mov $0x3f8, %dx
    add $3, %dx
    mov $0x80, %al
    outb %al, %dx
    
    mov $0x3f8, %dx
    mov $0x03, %al
    outb %al, %dx
    
    mov $0x3f8, %dx
    add $1, %dx
    mov $0x00, %al
    outb %al, %dx
    
    mov $0x3f8, %dx
    add $3, %dx
    mov $0x03, %al
    outb %al, %dx
    
    mov $0x3f8, %dx
    add $2, %dx
    mov $0xC7, %al
    outb %al, %dx
    
    mov $0x3f8, %dx
    add $4, %dx
    mov $0x0B, %al
    outb %al, %dx
    
    ret

.global uart_write_char
.type uart_write_char, @function
uart_write_char:
    mov 4(%esp), %cl
1:
    mov $0x3f8, %dx
    add $5, %dx
    inb %dx, %al
    test $0x20, %al
    jz 1b
    
    mov $0x3f8, %dx
    mov %cl, %al
    outb %al, %dx
    
    ret
