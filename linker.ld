/* linker.ld */
OUTPUT_ARCH( "riscv" )
ENTRY( _start )

SECTIONS
{
  /* QEMU starts execution at 0x80000000 */
  . = 0x80000000;

  .text : {
    *(.text.init)   /* Put the boot code first */
    *(.text)        /* Then the rest of the code */
  }

  .rodata : {
    *(.rodata)      /* Read-only data (strings) */
  }

  .data : {
    *(.data)        /* Read-write variables */
  }

  .bss : {
    *(.bss)         /* Uninitialized variables */
  }

  /* Allocate 4KB for the Stack */
  . = ALIGN(16);
  . += 0x1000;      /* Move counter forward by 4096 bytes */
  stack_top = .;    /* Mark the top of the stack here */
}