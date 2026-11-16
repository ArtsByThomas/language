; ============================================================================
; Zavadec pro jadro Pramenu na x86-64 (Multiboot 1, napr. QEMU -kernel nebo GRUB)
; Prepne procesor z 32bitoveho rezimu do 64bitoveho a skoci na _start z Pramenu.
; ============================================================================
bits 32
section .multiboot
align 4
mb_hlavicka:
    dd 0x1BADB002                       ; magicke cislo Multiboot
    dd 0x00010003                       ; zarovnani + pamet + adresy v hlavicce
    dd -(0x1BADB002 + 0x00010003)       ; kontrolni soucet
    dd mb_hlavicka                      ; header_addr
    dd 0x100000                         ; load_addr
    dd _konec_dat                       ; load_end_addr
    dd _konec_bss                       ; bss_end_addr
    dd start32                          ; entry_addr

section .text
extern _start
extern _konec_dat
extern _konec_bss
global start32
start32:
    cli
    mov esp, zasobnik32_vrchol
    ; Strankovani: identicke mapovani prvniho 1 GiB po 2 MiB strankach
    mov eax, pdpt
    or eax, 3
    mov [pml4], eax
    mov eax, pd
    or eax, 3
    mov [pdpt], eax
    mov ecx, 0
.dalsi:
    mov eax, 0x200000
    mul ecx
    or eax, 0x83                        ; pritomna, zapisovatelna, velka stranka
    mov [pd + ecx*8], eax
    inc ecx
    cmp ecx, 512
    jne .dalsi
    mov eax, pml4
    mov cr3, eax
    mov eax, cr4
    or eax, 1 << 5                      ; PAE
    mov cr4, eax
    mov ecx, 0xC0000080                 ; EFER
    rdmsr
    or eax, 1 << 8                      ; Long Mode Enable
    wrmsr
    mov eax, cr0
    or eax, (1 << 31) | 1               ; strankovani + chraneny rezim
    mov cr0, eax
    lgdt [gdt_popis]
    jmp 0x08:start64

bits 64
start64:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax
    jmp _start                          ; vstupni bod vygenerovany Pramenem

section .data
align 8
gdt:
    dq 0
    dq 0x00AF9A000000FFFF               ; 64bitovy kodovy segment
    dq 0x00CF92000000FFFF               ; datovy segment
gdt_popis:
    dw gdt_popis - gdt - 1
    dq gdt

section .bss
align 4096
pml4: resb 4096
pdpt: resb 4096
pd:   resb 4096
zasobnik32: resb 4096
zasobnik32_vrchol:
section .note.GNU-stack noalloc noexec nowrite progbits
