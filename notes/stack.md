In bare-metal environments, the **stack** is typically initialized manually during the early stages of program execution, often within the startup assembly code (e.g., `start.s`). The stack allocation in the **linker script** reserves memory for the stack and provides symbolic addresses (like `__stack_top` and `__stack_bottom`) that can be referenced in the assembly code.

### How Stack Allocation Works in the Linker Script

1. **Reserve Memory for the Stack**:
   In the linker script, you explicitly reserve a block of memory for the stack. This does not "initialize" the stack but simply sets aside an address range where the stack will grow. The typical convention is for the stack to grow downward (from higher addresses to lower addresses).

2. **Define Stack Symbols**:
   You define symbols like `__stack_top` and `__stack_bottom` that represent the start (top) and end (bottom) of the stack. These symbols are placeholders that the startup code uses to set the initial stack pointer.

Here’s an example of the relevant part of the linker script:

```ld
SECTIONS
{
    . = ALIGN(4);
    __stack_top = .;        /* Symbol representing the top of the stack */
    . = . + 0x4000;         /* Reserve 16 KB of stack memory */
    __stack_bottom = .;     /* Symbol representing the bottom of the stack */
}
```

### Steps for Stack Initialization in `start.s` Assembly

1. **Set the Stack Pointer (SP)**:
   In your startup assembly code (`start.s`), you need to load the address of `__stack_top` into the stack pointer (`sp` register). The stack pointer points to the top of the stack, which is where the stack will begin, and it will grow downward as functions are called.

Here’s an example of how you can initialize the stack in `start.s`:

```assembly
    .section .text._start
    .globl _start
_start:
    /* Load the address of the stack top into the stack pointer (sp) */
    la sp, __stack_top     /* Load address of __stack_top into sp */

    /* Call the C main function */
    la a0, main            /* Load address of the main function */
    jalr a0                /* Jump to main */

1:  j 1b                   /* Infinite loop to prevent exiting */
```

### Breakdown of What Happens

1. **Memory Reservation in the Linker Script**:
   The linker script reserves a block of memory for the stack and defines `__stack_top` and `__stack_bottom` symbols. For example, if the stack is 16 KB, the `__stack_top` points to the highest address of the reserved memory, and `__stack_bottom` points to the lowest address of the reserved memory.

2. **Stack Pointer Initialization in Assembly**:
   The assembly code (`start.s`) uses the `la sp, __stack_top` instruction to load the stack pointer with the value of `__stack_top`. This sets the starting point for the stack.

3. **C Function Calls**:
   After the stack is initialized, you can safely call C functions like `main()` because the C runtime environment expects the stack to be ready for pushing and popping data.

### Important Notes:
- **Stack Growth**: In RISC-V (as in most architectures), the stack grows downward. When new data is pushed onto the stack, the `sp` (stack pointer) decreases.
- **No Automatic Initialization**: Simply reserving memory for the stack in the linker script does not initialize the stack. You must explicitly set the stack pointer in your assembly code.
- **Stack Size**: The size of the stack is determined by how much memory you reserve in the linker script (e.g., `0x4000` for 16 KB in the example). If you need more or less stack space, you can adjust this value.

By following this approach, you ensure that your bare-metal program has a correctly initialized stack, which is essential for calling functions, handling local variables, and other stack-related operations.
