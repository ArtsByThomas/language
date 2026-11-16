#!/bin/bash
# Prelozi ukazkove jadro pro ARM64 a spusti ho v QEMU (stroj "virt").
# Potrebuje: aarch64-linux-gnu-as/ld (nebo aarch64-none-elf-*) a qemu-system-aarch64
set -e
cd "$(dirname "$0")"
PRAMEN=${PRAMEN:-../Kompilery/pramen-linux}
"$PRAMEN" jadro_arm.pra jadro --cil=kernel-arm
qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -kernel jadro.elf
