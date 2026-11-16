/* Linkovaci skript pro jadro Pramenu na x86-64 */
ENTRY(start32)
SECTIONS {
    . = 0x100000;
    .text : { *(.multiboot) *(.text*) }
    .rodata : { *(.rodata*) }
    .data : { *(.data*) }
    _konec_dat = .;
    .bss : { *(.bss*) *(COMMON) }
    _konec_bss = .;
}
