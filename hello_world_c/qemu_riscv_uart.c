#include "qemu_riscv_uart.h"

void uart_putc(char c) {
    while (!UART0_FF_THR_EMPTY);            // Wait until the FIFO holding register is empty
    UART0_DR = c;                           // Write character to transmitter register
}

void uart_puts(const char *str) {
    while (*str) {                          // Loop until value at string pointer is zero
        uart_putc(*str++);                    // Write the character and increment pointer
    }
}