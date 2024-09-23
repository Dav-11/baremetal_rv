# Baremetal RiscV Examples

## Requirements
- `qemu-system-riscv64`
- `riscv64-unknown-elf-*`

### MacOS
```shell
# qemu
brew install qemu

# gcc toolchain
brew tap riscv-software-src/riscv
brew install riscv-tools
```

## Get Info from qemu
```shell
qemu-system-riscv64 -nographic -serial mon:stdio -machine virt
```
You can find the base address here:
```
Firmware Base             : 0x80000000
[...]
Domain0 Region04          : 0x0000000080000000-0x000000008003ffff M: (R,X) S/U: () # <---- See here has execution perm (X)
```