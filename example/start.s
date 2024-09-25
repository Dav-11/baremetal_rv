    .section .text._start
    .globl _start
_start:
    /* Load the address of the stack top into the stack pointer (sp) */
    la sp, __stack_top     /* Load address of __stack_top into sp */

    /* Call the C main function */
    la a0, main            /* Load address of the main function */
    jalr a0                /* Jump to main */

loop:  j loopb                   /* Infinite loop to prevent exiting */
