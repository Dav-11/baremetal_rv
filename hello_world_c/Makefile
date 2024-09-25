all: hello.elf

# -mcmodel=medany
#           Generate code for the medium-any code model. The program and
#           its statically defined symbols must be within any single 2
#           GiB address range. Programs can be statically or dynamically
#           linked.
#
# If not used -> /hello_world_c/hello.c:5:(.text+0x20): relocation truncated to fit: R_RISCV_HI20 against `.LC0'

hello.o: hello.c qemu_riscv_uart.c qemu_riscv_uart.h
	riscv64-unknown-elf-gcc -c -g -O0 -ffreestanding -mcmodel=medany -march=rv64g -mabi=lp64 -o "$@" hello.c

start.o: start.s
	riscv64-unknown-elf-as -march=rv64g -mabi=lp64 -o "$@" start.s

qemu_riscv_uart.o: qemu_riscv_uart.c qemu_riscv_uart.h
	riscv64-unknown-elf-gcc -c -g -O0 -ffreestanding -mcmodel=medany -march=rv64g -mabi=lp64 -o "$@" qemu_riscv_uart.c

hello.elf: hello.o start.o qemu_riscv_uart.o baremetal.ld
	riscv64-unknown-elf-ld -T baremetal.ld -m elf64lriscv -o "$@" hello.o start.o qemu_riscv_uart.o

run: hello.elf
	@echo "Ctrl-A C for QEMU console, then quit to exit"
	qemu-system-riscv64 -nographic -serial mon:stdio -machine virt -bios hello.elf

clean:
	rm -f hello.o start.o hello.elf qemu_riscv_uart.o
