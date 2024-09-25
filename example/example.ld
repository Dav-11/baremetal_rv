SECTIONS
{
    /* QEMU default load address to run "bios" */
    . = 0x80000000;

    /* Define an output section ".text". */
    .text : {
        /* Ensure _start is placed first */
        KEEP(*(.text._start));

        /* Pull in all symbols in input sections named .text */
        *(.text)

        /* Do the same for sections starting with .text., such as .text.foo */
        *(.text.*)
    } ALIGN(4);  /* Align text section to 4 bytes */

    /* Uninitialized data (BSS) section */
    .bss : {
        *(.bss)
        *(.bss.*)
    } ALIGN(4);

    /* Initialized data section */
    .data : {
        *(.data)
        *(.data.*)
    } ALIGN(4);

    /* Place read-only data (strings, constants) immediately after .text */
    .rodata : {
        *(.rodata)
        *(.rodata.*)
    } ALIGN(4);  /* Align rodata section to 4 bytes */

    /* Allocate space for stack (if necessary) */
    . = ALIGN(4);
    __stack_top = .;
    . = . + 0x4000;  /* 16KB stack */
    __stack_bottom = .;
}
