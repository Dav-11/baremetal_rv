all: hello.elf

main.o: main.c qemu_rv_uart.h
	riscv64-unknown-elf-gcc -c -g -O0 -ffreestanding -mcmodel=medany -march=rv64g -mabi=lp64 -o "$@" main.c

start.o: start.S
	riscv64-unknown-elf-as -march=rv64g -mabi=lp64 -o "$@" start.S

qemu_rv_uart.o: qemu_rv_uart.c qemu_rv_uart.h
	riscv64-unknown-elf-gcc -c -g -O0 -ffreestanding -mcmodel=medany -march=rv64g -mabi=lp64 -o "$@" qemu_rv_uart.c

bpf_helpers.o: bpf_helpers.c bpf_helpers.h
	riscv64-unknown-elf-gcc -c -g -O0 -ffreestanding -mcmodel=medany -march=rv64g -mabi=lp64 -o "$@" bpf_helpers.c

hello.elf: main.o start.o qemu_rv_uart.o bpf_helpers.o baremetal.ld
	riscv64-unknown-elf-ld -T baremetal.ld -m elf64lriscv -o "$@" main.o start.o qemu_rv_uart.o bpf_helpers.o

run: hello.elf
	@echo "Ctrl-A C for QEMU console, then quit to exit"
	qemu-system-riscv64 -nographic -serial mon:stdio -machine virt -bios hello.elf

clean:
	rm -f main.o start.o hello.elf qemu_rv_uart.o
