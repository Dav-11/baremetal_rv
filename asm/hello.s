.equ UART_BASE, 0x10000000

.section .text
    la a0, hello_world  # load address of hello_world string in register a0
    li a1, UART_BASE    # load address UART_BASE in register a1
    call puts

loop: j loop            # infinite loop, prevents from executing the data section

puts:
    # a0 - String address
    # a1 - UART base address
1:                      # while string byte is not null
    lb t0, 0(a0)        # get byte at current string pos
    beq zero, t0, 2f    # if t0 == 0 then j 2f
    sb t0, 0(a1)        # write byte to UART
    addi a0, a0, 1      # a0++ (next char)
    j 1b                # jump to 1b

2:                      # str byte is null
    ret    
    



.section .data
hello_world: .string "Hello World!"
    
