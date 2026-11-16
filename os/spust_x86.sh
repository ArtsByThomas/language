#!/bin/bash
# Prelozi ukazkove jadro pro x86-64 a spusti ho v QEMU.
# Zavadec start32.asm prepne procesor z 32bitoveho rezimu Multiboot do 64bitoveho.
# Potrebuje: nasm, ld, objcopy (binutils) a qemu-system-x86_64
set -e
cd "$(dirname "$0")"
PRAMEN=${PRAMEN:-../Kompilery/pramen-linux}
"$PRAMEN" jadro_x86.pra jadro_x86 --cil=kernel --jen-asm
nasm -f elf64 jadro_x86.asm -o jadro_x86.o
nasm -f elf64 start32.asm -o start32.o
ld -n -z noexecstack --no-warn-rwx-segments -T jadro_x86.ld -o jadro_x86.elf start32.o jadro_x86.o
objcopy -O binary jadro_x86.elf jadro_x86.bin
# isa-debug-exit: jadro muze QEMU ukoncit zapisem na port 0xF4
qemu-system-x86_64 -kernel jadro_x86.bin -serial stdio -display none -device isa-debug-exit,iobase=0xf4,iosize=0x04 || true
