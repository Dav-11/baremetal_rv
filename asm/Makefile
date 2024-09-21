default: hello

hello: hello.o baremetal.ld
	riscv64-unknown-elf-gcc -T baremetal.ld -march=rv64g -mabi=lp64 -nostdlib -static -o hello hello.o

hello.o: hello.s
	riscv64-unknown-elf-as -march=rv64g -mabi=lp64 hello.s -o hello.o

run: hello
	@echo "Ctrl-A C for QEMU console, then quit to exit"
	qemu-system-riscv64 -nographic -serial mon:stdio -machine virt -bios hello