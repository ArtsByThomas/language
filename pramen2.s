.data
    fmt_int: .asciz "%d\n"
    fmt_flt: .asciz "%f\n"
    fmt_str: .asciz "%s\n"
    fmt_str_concat: .asciz "%s%s"
    .align 3
    gvar_sys_argc: .quad 0
    .align 3
    gvar_sys_argv: .quad 0
    .align 3
    gvar_kapacita_tokenu: .quad 50000
    .align 3
    gvar_kapacita_symbolu: .quad 2000
    .align 3
    gvar_pamet_defer: .quad 0
    .align 3
    gvar_pocet_defer: .quad 0
    .align 3
    gvar_pamet_ir: .quad 0
    .align 3
    gvar_pocet_ir: .quad 0
    .align 3
    gvar_kapacita_ir: .quad 10000
    .align 3
    gvar_pamet_intervalu: .quad 0
    .align 3
    gvar_pocet_intervalu: .quad 0
    .align 3
    gvar_kapacita_intervalu: .quad 5000
    .align 3
    gvar_citac_temp_reg: .quad 1
    .align 3
    gvar_hash_tabulka: .quad 0
    .align 3
    gvar_kontrola_aktualni_typ_metody: .quad 0
    .align 3
    gvar_citac_navesti: .quad 0
    .align 3
    gvar_pamet_symbolu: .quad 0
    .align 3
    gvar_pocet_symbolu: .quad 0
    .align 3
    gvar_current_local_offset: .quad 0
    .align 3
    gvar_pamet_tokenu: .quad 0
    .align 3
    gvar_pocet_tokenu: .quad 0
    .align 3
    gvar_globalni_str_id: .quad 0
    .align 3
    gvar_aktualni_token_idx: .quad 0
    .align 3
    gvar_loop_label_stack: .quad 0
    .align 3
    gvar_loop_stack_depth: .quad 0
    .align 3
    gvar_codegen_sym_start: .quad 0
    .align 3
    gvar_codegen_sym_end: .quad 0
    .align 3
    gvar_codegen_scoped: .quad 0
    .align 3
    gvar_cekam_na_zahrn: .quad 0
    .align 3
    gvar_globalni_float_id: .quad 0
    .align 3
    gvar_pamet_struktur_clenove: .quad 0
    .align 3
    gvar_pocet_struktur_clenu: .quad 0
    .align 3
    gvar_pamet_struktur_def: .quad 0
    .align 3
    gvar_pocet_struktur_def: .quad 0
    .align 3
    gvar_parse_sym_start: .quad 0
    .align 3
    gvar_aktualni_hloubka_bloku: .quad 0
    .align 3
    gvar_cilova_platforma: .quad 0
    .align 3
    gvar_pamet_externu: .quad 0
    .align 3
    gvar_pocet_externu: .quad 0
    .align 3
    gvar_loop_continue_stack: .quad 0
    .align 3
    gvar_pamet_bloku: .quad 0
    .align 3
    gvar_pocet_bloku: .quad 0

.text
.global _main
.extern _printf
.extern _exit

_main:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    bl _Hlavni
    bl _exit

EmitujRawASM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_0
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_ir
    str x0, [x8]
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_ir
    str x0, [x8]
.L_else_0:
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_ir
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

NastavBit:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    bne .L_true_4
    str x0, [sp, -16]!
    ldr x0, =7999
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    bne .L_true_4
    mov x0, #0
    b .L_end_4
.L_true_4:
    mov x0, #1
.L_end_4:
    cmp x0, #0
    beq .L_else_2
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    asr x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    sdiv x2, x0, x1
    msub x0, x2, x1, x0
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x0, =1
    ldr x0, =0
.L_start_5:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_6
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_5
.L_end_6:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

CtiBit:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    bne .L_true_9
    str x0, [sp, -16]!
    ldr x0, =7999
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    bne .L_true_9
    mov x0, #0
    b .L_end_9
.L_true_9:
    mov x0, #1
.L_end_9:
    cmp x0, #0
    beq .L_else_7
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_7:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    asr x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    sdiv x2, x0, x1
    msub x0, x2, x1, x0
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x0, =1
    ldr x0, =0
.L_start_10:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_11
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_10
.L_end_11:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    and x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_12
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_12:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

VytvorZakladniBlok:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_14
    ldr x0, =48
    str x0, [sp, -16]!
    ldr x0, =500
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_bloku
    str x0, [x8]
.L_else_14:
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, =1000
    str x0, [sp, -16]!
    ldr x0, =4
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pocet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_bloku
    str x0, [x8]
    ldr x8, =gvar_pocet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

BudujCFG:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #80
    ldr x0, =0
    ldr x8, =gvar_pocet_bloku
    str x0, [x8]
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_16
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_16:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl VytvorZakladniBlok
    ldr x0, =0
.L_start_18:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_19
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_23
    str x0, [sp, -16]!
    ldr x0, =9
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_23
    mov x0, #0
    b .L_end_23
.L_true_23:
    mov x0, #1
.L_end_23:
    cmp x0, #0
    bne .L_true_22
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_22
    mov x0, #0
    b .L_end_22
.L_true_22:
    mov x0, #1
.L_end_22:
    cmp x0, #0
    beq .L_else_20
    ldr x0, =1
.L_else_20:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_24
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =9
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_28
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_28
    mov x0, #0
    b .L_end_28
.L_true_28:
    mov x0, #1
.L_end_28:
    cmp x0, #0
    beq .L_else_26
.L_else_26:
    str x0, [sp, -16]!
    ldr x0, =9
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_29
.L_else_29:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_31
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl VytvorZakladniBlok
.L_else_31:
    b .L_end_25
.L_else_24:
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_35
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_35
    mov x0, #1
    b .L_end_35
.L_false_35:
    mov x0, #0
.L_end_35:
    cmp x0, #0
    beq .L_else_33
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_36
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl VytvorZakladniBlok
.L_else_36:
    b .L_end_34
.L_else_33:
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_end_34:
.L_end_25:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_18
.L_end_19:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

SpocitejLiveness:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #224
    ldr x8, =gvar_pocet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_38
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_38:
    ldr x0, =0
.L_start_40:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_bloku
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_41
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
.L_start_42:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_end_43
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =24
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =40
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_46
    str x0, [sp, -16]!
    ldr x0, =99
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_false_46
    mov x0, #1
    b .L_end_46
.L_false_46:
    mov x0, #0
.L_end_46:
    cmp x0, #0
    beq .L_else_44
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_49
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_49
    mov x0, #1
    b .L_end_49
.L_false_49:
    mov x0, #0
.L_end_49:
    cmp x0, #0
    beq .L_else_47
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1000
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl CtiBit
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_50
.L_else_50:
.L_else_47:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_54
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_54
    mov x0, #1
    b .L_end_54
.L_false_54:
    mov x0, #0
.L_end_54:
    cmp x0, #0
    beq .L_else_52
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1000
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl CtiBit
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_55
.L_else_55:
.L_else_52:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_61
    str x0, [sp, -16]!
    ldr x0, =9
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_61
    mov x0, #1
    b .L_end_61
.L_false_61:
    mov x0, #0
.L_end_61:
    cmp x0, #0
    beq .L_false_60
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_60
    mov x0, #1
    b .L_end_60
.L_false_60:
    mov x0, #0
.L_end_60:
    cmp x0, #0
    beq .L_false_59
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_59
    mov x0, #1
    b .L_end_59
.L_false_59:
    mov x0, #0
.L_end_59:
    cmp x0, #0
    beq .L_else_57
.L_else_57:
.L_else_44:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_42
.L_end_43:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_40
.L_end_41:
    ldr x0, =1
    ldr x0, =0
    ldr x0, =0
.L_start_62:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_64
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_false_64
    mov x0, #1
    b .L_end_64
.L_false_64:
    mov x0, #0
.L_end_64:
    cmp x0, #0
    beq .L_end_63
    ldr x8, =gvar_pocet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_65:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_66
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =24
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    ldr x0, =1
    ldr x8, =gvar_citac_temp_reg
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =7999
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_67
    ldr x0, =7999
.L_else_67:
.L_start_69:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_end_70
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =-1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_71
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_73
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =2000
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl CtiBit
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_75
    ldr x0, =1
.L_else_75:
.L_else_73:
.L_else_71:
    str x0, [sp, -16]!
    ldr x0, =-1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_77
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_79
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =2000
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl CtiBit
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_81
    ldr x0, =1
.L_else_81:
.L_else_79:
.L_else_77:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_83
.L_else_83:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl CtiBit
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_87
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1000
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl CtiBit
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_87
    mov x0, #1
    b .L_end_87
.L_false_87:
    mov x0, #0
.L_end_87:
    cmp x0, #0
    beq .L_else_85
    ldr x0, =1
.L_else_85:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_90
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =2000
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl CtiBit
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_90
    mov x0, #1
    b .L_end_90
.L_false_90:
    mov x0, #0
.L_end_90:
    cmp x0, #0
    beq .L_else_88
    ldr x0, =1
.L_else_88:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_93
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_93
    mov x0, #0
    b .L_end_93
.L_true_93:
    mov x0, #1
.L_end_93:
    cmp x0, #0
    beq .L_else_91
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_94
.L_else_94:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_96
.L_else_96:
.L_else_91:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_69
.L_end_70:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_65
.L_end_66:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_62
.L_end_63:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujPeephole:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    ldr x0, =0
    ldr x0, =0
.L_start_98:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_99
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_100
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_104
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_104
    mov x0, #0
    b .L_end_104
.L_true_104:
    mov x0, #1
.L_end_104:
    cmp x0, #0
    beq .L_else_102
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_107
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_107
    mov x0, #1
    b .L_end_107
.L_false_107:
    mov x0, #0
.L_end_107:
    cmp x0, #0
    beq .L_else_105
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_105:
.L_else_102:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_110
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_110
    mov x0, #0
    b .L_end_110
.L_true_110:
    mov x0, #1
.L_end_110:
    cmp x0, #0
    beq .L_else_108
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_113
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_113
    mov x0, #1
    b .L_end_113
.L_false_113:
    mov x0, #0
.L_end_113:
    cmp x0, #0
    beq .L_else_111
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_111:
.L_else_108:
.L_else_100:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_98
.L_end_99:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_114
.L_else_114:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

NahradKonstanty:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_116
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_116:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_118
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_120
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    sdiv x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_122
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
.L_else_122:
.L_else_120:
.L_else_118:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

CistiGCP:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
.L_start_124:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_125
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_124
.L_end_125:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ProvedGCP:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #64
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_126
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_126:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_131
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_131
    mov x0, #0
    b .L_end_131
.L_true_131:
    mov x0, #1
.L_end_131:
    cmp x0, #0
    bne .L_true_130
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_130
    mov x0, #0
    b .L_end_130
.L_true_130:
    mov x0, #1
.L_end_130:
    cmp x0, #0
    beq .L_else_128
    ldr x0, =0
.L_start_132:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_133
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_134
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_138
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_138
    mov x0, #0
    b .L_end_138
.L_true_138:
    mov x0, #1
.L_end_138:
    cmp x0, #0
    beq .L_else_136
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_139
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    sdiv x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_143
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_143
    mov x0, #1
    b .L_end_143
.L_false_143:
    mov x0, #0
.L_end_143:
    cmp x0, #0
    beq .L_else_141
    b .L_end_142
.L_else_141:
.L_end_142:
.L_else_139:
    b .L_end_137
.L_else_136:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_147
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_147
    mov x0, #0
    b .L_end_147
.L_true_147:
    mov x0, #1
.L_end_147:
    cmp x0, #0
    bne .L_true_146
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_146
    mov x0, #0
    b .L_end_146
.L_true_146:
    mov x0, #1
.L_end_146:
    cmp x0, #0
    beq .L_else_144
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_148
.L_else_148:
    b .L_end_145
.L_else_144:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_152
    str x0, [sp, -16]!
    ldr x0, =25
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_152
    mov x0, #0
    b .L_end_152
.L_true_152:
    mov x0, #1
.L_end_152:
    cmp x0, #0
    beq .L_else_150
    ldr x0, =0
.L_start_153:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_154
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_153
.L_end_154:
    str x0, [sp, -16]!
    ldr x0, =25
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_155
.L_else_155:
    b .L_end_151
.L_else_150:
.L_end_151:
.L_end_145:
.L_end_137:
.L_else_134:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_132
.L_end_133:
.L_else_128:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujGCP:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

VycistiSymbol:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
.L_start_157:
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_158
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_157
.L_end_158:
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujLICM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #112
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_159
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_159:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_161
    ldr x0, =0
.L_start_163:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_164
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_163
.L_end_164:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_161:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_165
    ldr x0, =0
.L_start_167:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_168
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_169
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_173
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_173
    mov x0, #0
    b .L_end_173
.L_true_173:
    mov x0, #1
.L_end_173:
    cmp x0, #0
    beq .L_else_171
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_174
.L_else_174:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_176
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
.L_else_176:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_178
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_180
    ldr x0, =0
.L_start_182:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_183
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_184
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_186
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeCisteKonstantniVyraz
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_188
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_193
    str x0, [sp, -16]!
    ldr x0, =98
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_193
    mov x0, #1
    b .L_end_193
.L_false_193:
    mov x0, #0
.L_end_193:
    cmp x0, #0
    beq .L_false_192
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_192
    mov x0, #1
    b .L_end_192
.L_false_192:
    mov x0, #0
.L_end_192:
    cmp x0, #0
    beq .L_else_190
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl KopirujUzel
.L_else_190:
.L_else_188:
.L_else_186:
.L_else_184:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_182
.L_end_183:
.L_else_180:
.L_else_178:
.L_else_171:
.L_else_169:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_167
.L_end_168:
.L_else_165:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_194
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_196
.L_else_196:
.L_else_194:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_200
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_200
    mov x0, #0
    b .L_end_200
.L_true_200:
    mov x0, #1
.L_end_200:
    cmp x0, #0
    beq .L_else_198
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_201
.L_else_201:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_203
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_205
.L_else_205:
.L_else_203:
.L_else_198:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_207
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_209
.L_else_209:
.L_else_207:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

JeCisteKonstantniVyraz:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_211
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_211:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_213
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_213:
    str x0, [sp, -16]!
    ldr x0, =98
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_215
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_215:
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_217
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_217:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_219
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_219:
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_221
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeCisteKonstantniVyraz
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeCisteKonstantniVyraz
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_225
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_225
    mov x0, #1
    b .L_end_225
.L_false_225:
    mov x0, #0
.L_end_225:
    cmp x0, #0
    beq .L_else_223
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_223:
.L_else_221:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujDCE:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_226
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_226:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_230
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_230
    mov x0, #0
    b .L_end_230
.L_true_230:
    mov x0, #1
.L_end_230:
    cmp x0, #0
    beq .L_else_228
    ldr x0, =0
    ldr x0, =0
.L_start_231:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_232
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_233
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_233:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_235
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_237
    ldr x0, =1
.L_else_237:
    str x0, [sp, -16]!
    ldr x0, =22
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_239
    ldr x0, =1
.L_else_239:
.L_else_235:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_231
.L_end_232:
.L_else_228:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_241
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_243
.L_else_243:
.L_else_241:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_247
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_247
    mov x0, #0
    b .L_end_247
.L_true_247:
    mov x0, #1
.L_end_247:
    cmp x0, #0
    beq .L_else_245
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_248
.L_else_248:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_250
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_252
.L_else_252:
.L_else_250:
.L_else_245:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_254
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_256
.L_else_256:
.L_else_254:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujBezpecnyInlining:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #64
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_258
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_258:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_262
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_262
    mov x0, #0
    b .L_end_262
.L_true_262:
    mov x0, #1
.L_end_262:
    cmp x0, #0
    beq .L_else_260
    ldr x0, =0
.L_start_263:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_264
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_265
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_267
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_271
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_271
    mov x0, #1
    b .L_end_271
.L_false_271:
    mov x0, #0
.L_end_271:
    cmp x0, #0
    beq .L_else_269
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_274
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_274
    mov x0, #1
    b .L_end_274
.L_false_274:
    mov x0, #0
.L_end_274:
    cmp x0, #0
    beq .L_else_272
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl KopirujUzel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_275
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_277
.L_else_277:
.L_else_275:
.L_else_272:
.L_else_269:
    b .L_end_268
.L_else_267:
.L_end_268:
.L_else_265:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_263
.L_end_264:
.L_else_260:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_279
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_281
.L_else_281:
.L_else_279:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_285
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_285
    mov x0, #0
    b .L_end_285
.L_true_285:
    mov x0, #1
.L_end_285:
    cmp x0, #0
    beq .L_else_283
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_286
.L_else_286:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_288
.L_else_288:
.L_else_283:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_290
.L_else_290:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujCSE:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #96
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_292
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_292:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_294
    ldr x0, =0
.L_start_296:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_297
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_296
.L_end_297:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_294:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_298
    ldr x0, =0
.L_start_300:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_301
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_306
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_306
    mov x0, #1
    b .L_end_306
.L_false_306:
    mov x0, #0
.L_end_306:
    cmp x0, #0
    beq .L_false_305
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_305
    mov x0, #1
    b .L_end_305
.L_false_305:
    mov x0, #0
.L_end_305:
    cmp x0, #0
    beq .L_false_304
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_304
    mov x0, #1
    b .L_end_304
.L_false_304:
    mov x0, #0
.L_end_304:
    cmp x0, #0
    beq .L_else_302
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_312
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_312
    mov x0, #1
    b .L_end_312
.L_false_312:
    mov x0, #0
.L_end_312:
    cmp x0, #0
    beq .L_false_311
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_311
    mov x0, #1
    b .L_end_311
.L_false_311:
    mov x0, #0
.L_end_311:
    cmp x0, #0
    beq .L_false_310
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_310
    mov x0, #1
    b .L_end_310
.L_false_310:
    mov x0, #0
.L_end_310:
    cmp x0, #0
    beq .L_false_309
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_309
    mov x0, #1
    b .L_end_309
.L_false_309:
    mov x0, #0
.L_end_309:
    cmp x0, #0
    beq .L_else_307
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_317
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_317
    mov x0, #1
    b .L_end_317
.L_false_317:
    mov x0, #0
.L_end_317:
    cmp x0, #0
    beq .L_false_316
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_316
    mov x0, #1
    b .L_end_316
.L_false_316:
    mov x0, #0
.L_end_316:
    cmp x0, #0
    beq .L_false_315
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_315
    mov x0, #1
    b .L_end_315
.L_false_315:
    mov x0, #0
.L_end_315:
    cmp x0, #0
    beq .L_else_313
.L_else_313:
.L_else_307:
.L_else_302:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_300
.L_end_301:
.L_else_298:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_318
.L_else_318:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_322
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_322
    mov x0, #0
    b .L_end_322
.L_true_322:
    mov x0, #1
.L_end_322:
    cmp x0, #0
    beq .L_else_320
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_323
.L_else_323:
.L_else_320:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujInlining:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_325
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_325:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_329
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_329
    mov x0, #0
    b .L_end_329
.L_true_329:
    mov x0, #1
.L_end_329:
    cmp x0, #0
    beq .L_else_327
    ldr x0, =0
.L_start_330:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_331
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_332
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_334
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_338
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_338
    mov x0, #1
    b .L_end_338
.L_false_338:
    mov x0, #0
.L_end_338:
    cmp x0, #0
    beq .L_else_336
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_339
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl KopirujUzel
.L_else_339:
.L_else_336:
    b .L_end_335
.L_else_334:
.L_end_335:
.L_else_332:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_330
.L_end_331:
.L_else_327:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_341
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_343
.L_else_343:
.L_else_341:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_347
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_347
    mov x0, #0
    b .L_end_347
.L_true_347:
    mov x0, #1
.L_end_347:
    cmp x0, #0
    beq .L_else_345
.L_else_345:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_348
.L_else_348:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

KopirujUzel:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_350
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_350:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_352
    ldr x0, =0
.L_start_354:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_355
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl KopirujUzel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_354
.L_end_355:
.L_else_352:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujSCEV:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #224
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_356
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_356:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_360
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_360
    mov x0, #0
    b .L_end_360
.L_true_360:
    mov x0, #1
.L_end_360:
    cmp x0, #0
    beq .L_else_358
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_358:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_363
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_363
    mov x0, #0
    b .L_end_363
.L_true_363:
    mov x0, #1
.L_end_363:
    cmp x0, #0
    beq .L_else_361
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_361:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_364
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_364:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_368
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_368
    mov x0, #0
    b .L_end_368
.L_true_368:
    mov x0, #1
.L_end_368:
    cmp x0, #0
    beq .L_else_366
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_366:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_371
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    bne .L_true_371
    mov x0, #0
    b .L_end_371
.L_true_371:
    mov x0, #1
.L_end_371:
    cmp x0, #0
    beq .L_else_369
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_369:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_372
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_372:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_374
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_374:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_378
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_378
    mov x0, #0
    b .L_end_378
.L_true_378:
    mov x0, #1
.L_end_378:
    cmp x0, #0
    beq .L_else_376
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_376:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_381
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_381
    mov x0, #0
    b .L_end_381
.L_true_381:
    mov x0, #1
.L_end_381:
    cmp x0, #0
    beq .L_else_379
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_379:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_384
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_384
    mov x0, #0
    b .L_end_384
.L_true_384:
    mov x0, #1
.L_end_384:
    cmp x0, #0
    beq .L_else_382
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_382:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_385
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_385:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_387
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_387:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_389
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_389:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_391
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_393
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_397
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_397
    mov x0, #1
    b .L_end_397
.L_false_397:
    mov x0, #0
.L_end_397:
    cmp x0, #0
    beq .L_else_395
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_403
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_403
    mov x0, #1
    b .L_end_403
.L_false_403:
    mov x0, #0
.L_end_403:
    cmp x0, #0
    beq .L_false_402
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_402
    mov x0, #1
    b .L_end_402
.L_false_402:
    mov x0, #0
.L_end_402:
    cmp x0, #0
    beq .L_false_401
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_401
    mov x0, #1
    b .L_end_401
.L_false_401:
    mov x0, #0
.L_end_401:
    cmp x0, #0
    beq .L_false_400
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_400
    mov x0, #1
    b .L_end_400
.L_false_400:
    mov x0, #0
.L_end_400:
    cmp x0, #0
    beq .L_else_398
    str x0, [sp, -16]!
    ldr x0, =4
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =4
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_398:
.L_else_395:
.L_else_393:
.L_else_391:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujRozbaleniOpakuj:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #192
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_404
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_404:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_408
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_408
    mov x0, #0
    b .L_end_408
.L_true_408:
    mov x0, #1
.L_end_408:
    cmp x0, #0
    beq .L_else_406
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_406:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_411
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_411
    mov x0, #0
    b .L_end_411
.L_true_411:
    mov x0, #1
.L_end_411:
    cmp x0, #0
    beq .L_else_409
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_409:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_414
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_414
    mov x0, #0
    b .L_end_414
.L_true_414:
    mov x0, #1
.L_end_414:
    cmp x0, #0
    beq .L_else_412
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_412:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_417
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_417
    mov x0, #0
    b .L_end_417
.L_true_417:
    mov x0, #1
.L_end_417:
    cmp x0, #0
    beq .L_else_415
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_415:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_420
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_420
    mov x0, #0
    b .L_end_420
.L_true_420:
    mov x0, #1
.L_end_420:
    cmp x0, #0
    beq .L_else_418
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_418:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_421
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_421:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_425
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_425
    mov x0, #0
    b .L_end_425
.L_true_425:
    mov x0, #1
.L_end_425:
    cmp x0, #0
    beq .L_else_423
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_423:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_426
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_426:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_430
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_430
    mov x0, #0
    b .L_end_430
.L_true_430:
    mov x0, #1
.L_end_430:
    cmp x0, #0
    beq .L_else_428
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_428:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_433
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_433
    mov x0, #0
    b .L_end_433
.L_true_433:
    mov x0, #1
.L_end_433:
    cmp x0, #0
    beq .L_else_431
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_431:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_434
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_434:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_438
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_438
    mov x0, #1
    b .L_end_438
.L_false_438:
    mov x0, #0
.L_end_438:
    cmp x0, #0
    beq .L_else_436
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_439
.L_else_439:
    ldr x0, =1
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, =8
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, =0
.L_start_441:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_442
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_443
    ldr x0, =0
.L_start_445:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_446
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl KopirujUzel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_445
.L_end_446:
    b .L_end_444
.L_else_443:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl KopirujUzel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_end_444:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl KopirujUzel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_441
.L_end_442:
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_436:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZkontrolujKapacituSymbolu:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_447
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_symbolu
    str x0, [x8]
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_symbolu
    str x0, [x8]
.L_else_447:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZkontrolujKapacituIR:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_449
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_ir
    str x0, [x8]
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_ir
    str x0, [x8]
.L_else_449:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

NovyTempRegistr:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_citac_temp_reg
    ldr x0, [x8]
    ldr x8, =gvar_citac_temp_reg
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_temp_reg
    str x0, [x8]
    ldr x8, =gvar_pocet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_451
    ldr x8, =gvar_kapacita_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_intervalu
    str x0, [x8]
    ldr x8, =gvar_kapacita_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_intervalu
    str x0, [x8]
.L_else_451:
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_intervalu
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

EmitujIR:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_453
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_ir
    str x0, [x8]
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_ir
    str x0, [x8]
.L_else_453:
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, =0
.L_start_455:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_intervalu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_456
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_459
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_459
    mov x0, #1
    b .L_end_459
.L_false_459:
    mov x0, #0
.L_end_459:
    cmp x0, #0
    beq .L_else_457
.L_else_457:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_462
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_462
    mov x0, #1
    b .L_end_462
.L_false_462:
    mov x0, #0
.L_end_462:
    cmp x0, #0
    beq .L_else_460
.L_else_460:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_455
.L_end_456:
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_ir
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GenerujIR_Vyraz:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #176
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_463
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_463:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_465
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_465:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_467
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_467:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_469
    bl NovyTempRegistr
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_469:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_471
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    cmp x0, #0
    bne .L_true_476
    cmp x0, #0
    bne .L_true_476
    mov x0, #0
    b .L_end_476
.L_true_476:
    mov x0, #1
.L_end_476:
    cmp x0, #0
    bne .L_true_475
    cmp x0, #0
    bne .L_true_475
    mov x0, #0
    b .L_end_475
.L_true_475:
    mov x0, #1
.L_end_475:
    cmp x0, #0
    beq .L_else_473
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_473:
    bl NovyTempRegistr
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_471:
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_492
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_492
    mov x0, #0
    b .L_end_492
.L_true_492:
    mov x0, #1
.L_end_492:
    cmp x0, #0
    bne .L_true_491
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_491
    mov x0, #0
    b .L_end_491
.L_true_491:
    mov x0, #1
.L_end_491:
    cmp x0, #0
    bne .L_true_490
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_490
    mov x0, #0
    b .L_end_490
.L_true_490:
    mov x0, #1
.L_end_490:
    cmp x0, #0
    bne .L_true_489
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_489
    mov x0, #0
    b .L_end_489
.L_true_489:
    mov x0, #1
.L_end_489:
    cmp x0, #0
    bne .L_true_488
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_488
    mov x0, #0
    b .L_end_488
.L_true_488:
    mov x0, #1
.L_end_488:
    cmp x0, #0
    bne .L_true_487
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_487
    mov x0, #0
    b .L_end_487
.L_true_487:
    mov x0, #1
.L_end_487:
    cmp x0, #0
    bne .L_true_486
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_486
    mov x0, #0
    b .L_end_486
.L_true_486:
    mov x0, #1
.L_end_486:
    cmp x0, #0
    bne .L_true_485
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_485
    mov x0, #0
    b .L_end_485
.L_true_485:
    mov x0, #1
.L_end_485:
    cmp x0, #0
    bne .L_true_484
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_484
    mov x0, #0
    b .L_end_484
.L_true_484:
    mov x0, #1
.L_end_484:
    cmp x0, #0
    bne .L_true_483
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_483
    mov x0, #0
    b .L_end_483
.L_true_483:
    mov x0, #1
.L_end_483:
    cmp x0, #0
    bne .L_true_482
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_482
    mov x0, #0
    b .L_end_482
.L_true_482:
    mov x0, #1
.L_end_482:
    cmp x0, #0
    bne .L_true_481
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_481
    mov x0, #0
    b .L_end_481
.L_true_481:
    mov x0, #1
.L_end_481:
    cmp x0, #0
    bne .L_true_480
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_480
    mov x0, #0
    b .L_end_480
.L_true_480:
    mov x0, #1
.L_end_480:
    cmp x0, #0
    bne .L_true_479
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_479
    mov x0, #0
    b .L_end_479
.L_true_479:
    mov x0, #1
.L_end_479:
    cmp x0, #0
    beq .L_else_477
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl GenerujIR_Vyraz
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_493
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_493:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_495
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_497
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_499
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_501
    b .L_end_502
.L_else_501:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_503
    b .L_end_504
.L_else_503:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_505
    b .L_end_506
.L_else_505:
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_507
.L_else_507:
.L_end_506:
.L_end_504:
.L_end_502:
    b .L_end_500
.L_else_499:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_509
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_511
    b .L_end_512
.L_else_511:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_513
    b .L_end_514
.L_else_513:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_515
    b .L_end_516
.L_else_515:
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_517
.L_else_517:
.L_end_516:
.L_end_514:
.L_end_512:
.L_else_509:
.L_end_500:
.L_else_497:
.L_else_495:
    ldr x0, =0
    ldr x0, =0
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_519
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_521
    ldr x0, =1
.L_else_521:
.L_else_519:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_523
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    ldr x0, =1
    b .L_end_524
.L_else_523:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl GenerujIR_Vyraz
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_525
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_525:
.L_end_524:
    bl NovyTempRegistr
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_527
    ldr x0, =4
.L_else_527:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_529
    ldr x0, =5
.L_else_529:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_531
    ldr x0, =6
.L_else_531:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_533
    ldr x0, =7
.L_else_533:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_535
    ldr x0, =12
.L_else_535:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_537
    ldr x0, =13
.L_else_537:
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_539
    ldr x0, =14
.L_else_539:
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_541
    ldr x0, =15
.L_else_541:
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_543
    ldr x0, =16
.L_else_543:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_545
    ldr x0, =17
.L_else_545:
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_547
    ldr x0, =18
.L_else_547:
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_549
    ldr x0, =19
.L_else_549:
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_551
    ldr x0, =20
.L_else_551:
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_553
    ldr x0, =21
.L_else_553:
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_555
    ldr x0, =22
.L_else_555:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_477:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_557
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_else_559
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
    ldr x0, =0
    ldr x0, =0
.L_start_561:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_562
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl GenerujIR_Vyraz
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_563
    ldr x0, =1
.L_else_563:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_561
.L_end_562:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_565
    ldr x0, =0
.L_start_567:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_568
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_567
.L_end_568:
    bl NovyTempRegistr
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_565:
.L_else_559:
.L_else_557:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

EmitujASM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_569
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_ir
    str x0, [x8]
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_ir
    str x0, [x8]
.L_else_569:
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_ir
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

EmitujASM_1:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

EmitujASM_2:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

EmitujASM_3:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

CistiCFG:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
.L_start_571:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_bloku
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_572
    ldr x8, =gvar_pamet_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_571
.L_end_572:
    ldr x0, =0
    ldr x8, =gvar_pocet_bloku
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

PrelozIRDoASM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #160
    ldr x0, =0
.L_start_573:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_574
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_575
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_575:
    str x0, [sp, -16]!
    ldr x0, =99
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_577
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_577:
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_579
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_579:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_581
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_581:
    str x0, [sp, -16]!
    ldr x0, =9
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_583
    str x0, [sp, -16]!
    ldr x0, =-1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_585
    b .L_end_586
.L_else_585:
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_587
.L_else_587:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_589
.L_else_589:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_591
.L_else_591:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_593
.L_else_593:
.L_end_586:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_583:
    str x0, [sp, -16]!
    ldr x0, =25
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_595
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_597
.L_else_597:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_599
.L_else_599:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_601
.L_else_601:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_603
.L_else_603:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_595:
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, =0
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_605
.L_else_605:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_607
.L_else_607:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_609
.L_else_609:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_611
    ldr x0, =1
    ldr x0, =0
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_else_611:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_613
.L_else_613:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_615
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_617
    b .L_end_618
.L_else_617:
.L_end_618:
.L_else_615:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_621
    str x0, [sp, -16]!
    ldr x0, =22
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_621
    mov x0, #1
    b .L_end_621
.L_false_621:
    mov x0, #0
.L_end_621:
    cmp x0, #0
    beq .L_else_619
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_622
.L_else_622:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_624
.L_else_624:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_626
.L_else_626:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_628
.L_else_628:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_630
    b .L_end_631
.L_else_630:
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =12
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_632
.L_else_632:
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_634
.L_else_634:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_636
.L_else_636:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_638
.L_else_638:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_640
.L_else_640:
.L_end_631:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_642
.L_else_642:
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_644
.L_else_644:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_646
.L_else_646:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_648
.L_else_648:
    str x0, [sp, -16]!
    ldr x0, =12
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_652
    str x0, [sp, -16]!
    ldr x0, =17
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_652
    mov x0, #1
    b .L_end_652
.L_false_652:
    mov x0, #0
.L_end_652:
    cmp x0, #0
    beq .L_else_650
    str x0, [sp, -16]!
    ldr x0, =12
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_653
.L_else_653:
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_655
.L_else_655:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_657
.L_else_657:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_659
.L_else_659:
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_661
.L_else_661:
    str x0, [sp, -16]!
    ldr x0, =17
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_663
.L_else_663:
.L_else_650:
    str x0, [sp, -16]!
    ldr x0, =18
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_665
.L_else_665:
    str x0, [sp, -16]!
    ldr x0, =19
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_667
.L_else_667:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_669
.L_else_669:
    str x0, [sp, -16]!
    ldr x0, =21
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_671
.L_else_671:
    str x0, [sp, -16]!
    ldr x0, =22
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_673
.L_else_673:
.L_else_619:
    str x0, [sp, -16]!
    ldr x0, =23
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_675
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_677
.L_else_677:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_679
.L_else_679:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_681
.L_else_681:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_683
.L_else_683:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_685
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_687
.L_else_687:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_689
.L_else_689:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_691
.L_else_691:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_693
.L_else_693:
    b .L_end_686
.L_else_685:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_695
.L_else_695:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_697
.L_else_697:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_699
.L_else_699:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_701
.L_else_701:
.L_end_686:
.L_else_675:
    str x0, [sp, -16]!
    ldr x0, =24
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_703
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_707
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeExterniJmeno
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_707
    mov x0, #1
    b .L_end_707
.L_false_707:
    mov x0, #0
.L_end_707:
    cmp x0, #0
    beq .L_else_705
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NazevSymbolu
.L_else_705:
.L_else_703:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_710
    str x0, [sp, -16]!
    ldr x0, =23
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_false_710
    mov x0, #1
    b .L_end_710
.L_false_710:
    mov x0, #0
.L_end_710:
    cmp x0, #0
    beq .L_else_708
.L_else_708:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_573
.L_end_574:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_711
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_713
.L_else_713:
    str x0, [sp, -16]!
    ldr x0, =14
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_715
.L_else_715:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_717
.L_else_717:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_719
    b .L_end_720
.L_else_719:
.L_end_720:
.L_else_711:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ProvedLinearScan:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #80
    ldr x0, =0
    ldr x0, =0
    ldr x0, =0
    ldr x0, =0
    ldr x0, =128
    ldr x0, =0
.L_start_721:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_intervalu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_722
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_725
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_725
    mov x0, #1
    b .L_end_725
.L_false_725:
    mov x0, #0
.L_end_725:
    cmp x0, #0
    beq .L_else_723
    ldr x0, =0
.L_else_723:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_728
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_728
    mov x0, #1
    b .L_end_728
.L_false_728:
    mov x0, #0
.L_end_728:
    cmp x0, #0
    beq .L_else_726
    ldr x0, =0
.L_else_726:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_731
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_731
    mov x0, #1
    b .L_end_731
.L_false_731:
    mov x0, #0
.L_end_731:
    cmp x0, #0
    beq .L_else_729
    ldr x0, =0
.L_else_729:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_734
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_false_734
    mov x0, #1
    b .L_end_734
.L_false_734:
    mov x0, #0
.L_end_734:
    cmp x0, #0
    beq .L_else_732
    ldr x0, =0
.L_else_732:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_735
    b .L_end_736
.L_else_735:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_737
    b .L_end_738
.L_else_737:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_739
    b .L_end_740
.L_else_739:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_741
    b .L_end_742
.L_else_741:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_end_742:
.L_end_740:
.L_end_738:
.L_end_736:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_721
.L_end_722:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujMrtvyKod:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    ldr x0, =0
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_743:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_744
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_749
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_749
    mov x0, #0
    b .L_end_749
.L_true_749:
    mov x0, #1
.L_end_749:
    cmp x0, #0
    bne .L_true_748
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_748
    mov x0, #0
    b .L_end_748
.L_true_748:
    mov x0, #1
.L_end_748:
    cmp x0, #0
    bne .L_true_747
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_747
    mov x0, #0
    b .L_end_747
.L_true_747:
    mov x0, #1
.L_end_747:
    cmp x0, #0
    beq .L_else_745
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_750
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_750:
.L_else_745:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_743
.L_end_744:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_752
.L_else_752:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

SpocitejHash:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    ldr x0, =5381
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x0, =0
.L_start_754:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_end_755
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =2147483647
    mov x1, x0
    ldr x0, [sp], 16
    and x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_start_754
.L_end_755:
    str x0, [sp, -16]!
    ldr x0, =4096
    mov x1, x0
    ldr x0, [sp], 16
    sdiv x2, x0, x1
    msub x0, x2, x1, x0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZaregistrujDoHashe:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl SpocitejHash
    ldr x8, =gvar_hash_tabulka
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZiskejTypKlicovehoSlova:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
.L_start_756:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_end_757
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_756
.L_end_757:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_758
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_760
    ldr x0, =23
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_760:
    b .L_end_759
.L_else_758:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_762
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_764
    ldr x0, =66
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_764:
    b .L_end_763
.L_else_762:
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_766
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_768
    ldr x0, =21
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_768:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_770
    ldr x0, =7
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_770:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_772
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_772:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_774
    ldr x0, =19
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_774:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_776
    ldr x0, =22
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_776:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_778
    ldr x0, =72
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_778:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_780
    ldr x0, =999
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_780:
    b .L_end_767
.L_else_766:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_782
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_784
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_784:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_786
    ldr x0, =65
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_786:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_788
    ldr x0, =91
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_788:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_790
    ldr x0, =92
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_790:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_792
    ldr x0, =54
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_792:
    b .L_end_783
.L_else_782:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_794
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_796
    ldr x0, =15
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_796:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_798
    ldr x0, =31
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_798:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_800
    ldr x0, =93
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_800:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_802
    ldr x0, =94
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_802:
    b .L_end_795
.L_else_794:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_804
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_806
    ldr x0, =11
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_806:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_808
    ldr x0, =52
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_808:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_810
    ldr x0, =56
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_810:
    b .L_end_805
.L_else_804:
    str x0, [sp, -16]!
    ldr x0, =9
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_812
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_814
    ldr x0, =59
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_814:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_816
    ldr x0, =60
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_816:
    b .L_end_813
.L_else_812:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_818
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_820
    ldr x0, =71
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_820:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_822
    ldr x0, =53
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_822:
    b .L_end_819
.L_else_818:
    str x0, [sp, -16]!
    ldr x0, =12
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_824
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_826
    ldr x0, =73
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_826:
.L_else_824:
.L_end_819:
.L_end_813:
.L_end_805:
.L_end_795:
.L_end_783:
.L_end_767:
.L_end_763:
.L_end_759:
    ldr x0, =35
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZapisByte:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x0, [x29, #16]
    ldr x1, [x29, #24]
    strb w1, [x0]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

CtiByt:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
    ldr x0, [x29, #16]
    ldrb w0, [x0]
    str x0, [x29, #-8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

PridejClenaStruktury:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_pocet_struktur_clenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =499
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_828
.L_else_828:
    ldr x8, =gvar_pamet_struktur_clenove
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_struktur_clenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1032
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_struktur_clenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_struktur_clenu
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZaregistrujStrukturu:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_pocet_struktur_def
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =99
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_830
.L_else_830:
    ldr x8, =gvar_pamet_struktur_def
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_struktur_def
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =520
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_struktur_def
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_struktur_def
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZiskejOffset:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
.L_start_832:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_struktur_clenu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_833
    ldr x8, =gvar_pamet_struktur_clenove
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1032
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_834
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =512
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_836
    str x0, [sp, -16]!
    ldr x0, =1024
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_836:
.L_else_834:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_832
.L_end_833:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZiskejVelikostStruktury:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
.L_start_838:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_struktur_def
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_839
    ldr x8, =gvar_pamet_struktur_def
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =520
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_840
    str x0, [sp, -16]!
    ldr x0, =512
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_840:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_838
.L_end_839:
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

CtiUkazatel:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =0
    ldr x0, [x29, #16]
    ldr x0, [x0]
    str x0, [x29, #-8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZapisUkazatel:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x0, [x29, #16]
    ldr x1, [x29, #24]
    str x1, [x0]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

PridejExterniJmeno:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_pocet_externu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =199
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_842
.L_else_842:
    ldr x8, =gvar_pamet_externu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_externu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =256
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_externu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_externu
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

JeExterniJmeno:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_844
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_844:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_846
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_846:
    ldr x0, =0
.L_start_848:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_externu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_849
    ldr x8, =gvar_pamet_externu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =256
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_850
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_850:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_848
.L_end_849:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

NazevSymbolu:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_852
    ldr x0, =300
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_852:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

VyhodnotKonstantu:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_854
.L_else_854:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_856
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_856:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_858
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_862
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_862
    mov x0, #1
    b .L_end_862
.L_false_862:
    mov x0, #0
.L_end_862:
    cmp x0, #0
    beq .L_else_860
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_860:
.L_else_858:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_866
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_866
    mov x0, #1
    b .L_end_866
.L_false_866:
    mov x0, #0
.L_end_866:
    cmp x0, #0
    beq .L_false_865
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_865
    mov x0, #1
    b .L_end_865
.L_false_865:
    mov x0, #0
.L_end_865:
    cmp x0, #0
    beq .L_else_863
    ldr x0, =0
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl VyhodnotKonstantu
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_863:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

PridejLokalniSymbol:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_867
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_871
    str x0, [sp, -16]!
    ldr x8, =gvar_aktualni_hloubka_bloku
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_871
    mov x0, #1
    b .L_end_871
.L_false_871:
    mov x0, #0
.L_end_871:
    cmp x0, #0
    beq .L_else_869
.L_else_869:
.L_else_867:
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_872
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_symbolu
    str x0, [x8]
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_symbolu
    str x0, [x8]
.L_else_872:
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_current_local_offset
    ldr x0, [x8]
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_current_local_offset
    str x0, [x8]
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

PridejGlobalniSymbol:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_874
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_874:
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_876
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_symbolu
    str x0, [x8]
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_symbolu
    str x0, [x8]
.L_else_876:
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

PridejKonstantu:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_878
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_symbolu
    str x0, [x8]
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_symbolu
    str x0, [x8]
.L_else_878:
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

NajdiSymbol:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl SpocitejHash
    ldr x8, =gvar_hash_tabulka
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
.L_start_880:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_end_881
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_882
    ldr x8, =gvar_codegen_scoped
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_884
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_888
    str x0, [sp, -16]!
    ldr x8, =gvar_codegen_sym_start
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_889
    str x0, [sp, -16]!
    ldr x8, =gvar_codegen_sym_end
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_false_889
    mov x0, #1
    b .L_end_889
.L_false_889:
    mov x0, #0
.L_end_889:
    cmp x0, #0
    bne .L_true_888
    mov x0, #0
    b .L_end_888
.L_true_888:
    mov x0, #1
.L_end_888:
    cmp x0, #0
    beq .L_else_886
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_886:
    b .L_end_885
.L_else_884:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_892
    str x0, [sp, -16]!
    ldr x8, =gvar_parse_sym_start
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_893
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_893
    mov x0, #1
    b .L_end_893
.L_false_893:
    mov x0, #0
.L_end_893:
    cmp x0, #0
    bne .L_true_892
    mov x0, #0
    b .L_end_892
.L_true_892:
    mov x0, #1
.L_end_892:
    cmp x0, #0
    beq .L_else_890
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_890:
.L_end_885:
.L_else_882:
    b .L_start_880
.L_end_881:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

LexerCore:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #112
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl fopen
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_894
.L_else_894:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ftell
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x0, =1
    ldr x0, =0
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x0, =0
.L_start_896:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_end_897
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_898
    ldr x8, =gvar_kapacita_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_tokenu
    str x0, [x8]
    ldr x8, =gvar_kapacita_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2072
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_tokenu
    str x0, [x8]
.L_else_898:
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_903
    str x0, [sp, -16]!
    ldr x0, =9
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_903
    mov x0, #0
    b .L_end_903
.L_true_903:
    mov x0, #1
.L_end_903:
    cmp x0, #0
    bne .L_true_902
    str x0, [sp, -16]!
    ldr x0, =13
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_902
    mov x0, #0
    b .L_end_902
.L_true_902:
    mov x0, #1
.L_end_902:
    cmp x0, #0
    beq .L_else_900
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
.L_else_900:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_904
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
.L_else_904:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_906
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_908
.L_start_910:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_912
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_912
    mov x0, #1
    b .L_end_912
.L_false_912:
    mov x0, #0
.L_end_912:
    cmp x0, #0
    beq .L_end_911
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_start_910
.L_end_911:
    b .L_end_909
.L_else_908:
    ldr x8, =gvar_pamet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2072
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_end_909:
.L_else_906:
    ldr x8, =gvar_pamet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2072
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_915
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_915
    mov x0, #1
    b .L_end_915
.L_false_915:
    mov x0, #0
.L_end_915:
    cmp x0, #0
    beq .L_else_913
    ldr x0, =0
    ldr x0, =0
.L_start_916:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_919
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_919
    mov x0, #1
    b .L_end_919
.L_false_919:
    mov x0, #0
.L_end_919:
    cmp x0, #0
    bne .L_true_918
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_918
    mov x0, #0
    b .L_end_918
.L_true_918:
    mov x0, #1
.L_end_918:
    cmp x0, #0
    beq .L_end_917
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_920
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_922
.L_else_922:
    ldr x0, =1
.L_else_920:
    str x0, [sp, -16]!
    ldr x0, =254
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_924
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_924:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_start_916
.L_end_917:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_913:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_926
    ldr x8, =gvar_globalni_str_id
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_globalni_str_id
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
.L_start_928:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_930
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_930
    mov x0, #1
    b .L_end_930
.L_false_930:
    mov x0, #0
.L_end_930:
    cmp x0, #0
    beq .L_end_929
    str x0, [sp, -16]!
    ldr x0, =92
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_931
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =254
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_933
    str x0, [sp, -16]!
    ldr x0, =110
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_935
    b .L_end_936
.L_else_935:
    str x0, [sp, -16]!
    ldr x0, =116
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_937
    b .L_end_938
.L_else_937:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_939
    b .L_end_940
.L_else_939:
    str x0, [sp, -16]!
    ldr x0, =92
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_941
    b .L_end_942
.L_else_941:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_943
    b .L_end_944
.L_else_943:
.L_end_944:
.L_end_942:
.L_end_940:
.L_end_938:
.L_end_936:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_933:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_932
.L_else_931:
    str x0, [sp, -16]!
    ldr x0, =254
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_945
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_945:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
.L_end_932:
    b .L_start_928
.L_end_929:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_cekam_na_zahrn
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_947
    ldr x0, =0
    ldr x8, =gvar_cekam_na_zahrn
    str x0, [x8]
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
.L_else_947:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_926:
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_949
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_951
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_952
.L_else_951:
.L_end_952:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_949:
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_953
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_955
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_956
.L_else_955:
.L_end_956:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_953:
    str x0, [sp, -16]!
    ldr x0, =60
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_957
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_959
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_960
.L_else_959:
    str x0, [sp, -16]!
    ldr x0, =60
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_961
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_962
.L_else_961:
.L_end_962:
.L_end_960:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_957:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_963
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_965
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_966
.L_else_965:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_967
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_968
.L_else_967:
.L_end_968:
.L_end_966:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_963:
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_969
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_971
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_972
.L_else_971:
.L_end_972:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_969:
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_973
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_975
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_976
.L_else_975:
.L_end_976:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_973:
    str x0, [sp, -16]!
    ldr x0, =94
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_977
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_977:
    str x0, [sp, -16]!
    ldr x0, =37
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_979
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_979:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_981
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_983
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_984
.L_else_983:
.L_end_984:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_981:
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_985
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_987
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_988
.L_else_987:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_989
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_end_990
.L_else_989:
.L_end_990:
.L_end_988:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_985:
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_991
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_991:
    str x0, [sp, -16]!
    ldr x0, =123
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_993
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_993:
    str x0, [sp, -16]!
    ldr x0, =125
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_995
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_995:
    str x0, [sp, -16]!
    ldr x0, =40
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_997
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_997:
    str x0, [sp, -16]!
    ldr x0, =41
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_999
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_999:
    str x0, [sp, -16]!
    ldr x0, =91
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1001
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_1001:
    str x0, [sp, -16]!
    ldr x0, =93
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1003
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_1003:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1005
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_1005:
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1007
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_1007:
    str x0, [sp, -16]!
    ldr x0, =65
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_1013
    str x0, [sp, -16]!
    ldr x0, =90
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_1013
    mov x0, #1
    b .L_end_1013
.L_false_1013:
    mov x0, #0
.L_end_1013:
    cmp x0, #0
    bne .L_true_1012
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_1014
    str x0, [sp, -16]!
    ldr x0, =122
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_1014
    mov x0, #1
    b .L_end_1014
.L_false_1014:
    mov x0, #0
.L_end_1014:
    cmp x0, #0
    bne .L_true_1012
    mov x0, #0
    b .L_end_1012
.L_true_1012:
    mov x0, #1
.L_end_1012:
    cmp x0, #0
    bne .L_true_1011
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1011
    mov x0, #0
    b .L_end_1011
.L_true_1011:
    mov x0, #1
.L_end_1011:
    cmp x0, #0
    beq .L_else_1009
    ldr x0, =0
.L_start_1015:
    str x0, [sp, -16]!
    ldr x0, =65
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_1020
    str x0, [sp, -16]!
    ldr x0, =90
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_1020
    mov x0, #1
    b .L_end_1020
.L_false_1020:
    mov x0, #0
.L_end_1020:
    cmp x0, #0
    bne .L_true_1019
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_1021
    str x0, [sp, -16]!
    ldr x0, =122
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_1021
    mov x0, #1
    b .L_end_1021
.L_false_1021:
    mov x0, #0
.L_end_1021:
    cmp x0, #0
    bne .L_true_1019
    mov x0, #0
    b .L_end_1019
.L_true_1019:
    mov x0, #1
.L_end_1019:
    cmp x0, #0
    bne .L_true_1018
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1018
    mov x0, #0
    b .L_end_1018
.L_true_1018:
    mov x0, #1
.L_end_1018:
    cmp x0, #0
    bne .L_true_1017
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_false_1022
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, le
    cmp x0, #0
    beq .L_false_1022
    mov x0, #1
    b .L_end_1022
.L_false_1022:
    mov x0, #0
.L_end_1022:
    cmp x0, #0
    bne .L_true_1017
    mov x0, #0
    b .L_end_1017
.L_true_1017:
    mov x0, #1
.L_end_1017:
    cmp x0, #0
    beq .L_end_1016
    str x0, [sp, -16]!
    ldr x0, =254
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1023
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_1023:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_start_1015
.L_end_1016:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypKlicovehoSlova
    str x0, [sp, -16]!
    ldr x0, =999
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1025
    ldr x0, =1
    ldr x8, =gvar_cekam_na_zahrn
    str x0, [x8]
    b .L_end_1026
.L_else_1025:
.L_end_1026:
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_tokenu
    str x0, [x8]
.L_else_1009:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    b .L_start_896
.L_end_897:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1027
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_tokenu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_1029
    ldr x8, =gvar_kapacita_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_kapacita_tokenu
    str x0, [x8]
    ldr x8, =gvar_kapacita_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2072
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_tokenu
    str x0, [x8]
.L_else_1029:
    ldr x8, =gvar_pamet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2072
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_1027:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

Lexer:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x0, =0
    ldr x8, =gvar_cekam_na_zahrn
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

VytvorUzel:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    ldr x0, =3176
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZiskejToken:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #16
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1031
    ldr x0, =0
.L_else_1031:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1033
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
.L_else_1033:
    ldr x8, =gvar_pamet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =2072
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

OptimalizujUzel:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #64
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1037
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1037
    mov x0, #1
    b .L_end_1037
.L_false_1037:
    mov x0, #0
.L_end_1037:
    cmp x0, #0
    beq .L_else_1035
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1040
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1040
    mov x0, #1
    b .L_end_1040
.L_false_1040:
    mov x0, #0
.L_end_1040:
    cmp x0, #0
    beq .L_else_1038
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1041
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1046
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1046
    mov x0, #0
    b .L_end_1046
.L_true_1046:
    mov x0, #1
.L_end_1046:
    cmp x0, #0
    bne .L_true_1045
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1045
    mov x0, #0
    b .L_end_1045
.L_true_1045:
    mov x0, #1
.L_end_1045:
    cmp x0, #0
    beq .L_else_1043
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1043:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1050
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1050
    mov x0, #0
    b .L_end_1050
.L_true_1050:
    mov x0, #1
.L_end_1050:
    cmp x0, #0
    bne .L_true_1049
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1049
    mov x0, #0
    b .L_end_1049
.L_true_1049:
    mov x0, #1
.L_end_1049:
    cmp x0, #0
    beq .L_else_1047
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1047:
.L_else_1041:
.L_else_1038:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1053
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1053
    mov x0, #1
    b .L_end_1053
.L_false_1053:
    mov x0, #0
.L_end_1053:
    cmp x0, #0
    beq .L_else_1051
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    ldr x0, =0
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1054
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_end_1055
.L_else_1054:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1056
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_end_1057
.L_else_1056:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1058
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    b .L_end_1059
.L_else_1058:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1060
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1062
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    sdiv x0, x0, x1
    b .L_end_1063
.L_else_1062:
    ldr x0, =0
.L_end_1063:
    b .L_end_1061
.L_else_1060:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1064
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1066
    ldr x0, =1
    b .L_end_1067
.L_else_1066:
    ldr x0, =0
.L_end_1067:
    b .L_end_1065
.L_else_1064:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1068
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1070
    ldr x0, =1
    b .L_end_1071
.L_else_1070:
    ldr x0, =0
.L_end_1071:
    b .L_end_1069
.L_else_1068:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1072
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1076
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1076
    mov x0, #1
    b .L_end_1076
.L_false_1076:
    mov x0, #0
.L_end_1076:
    cmp x0, #0
    beq .L_else_1074
    ldr x0, =1
    b .L_end_1075
.L_else_1074:
    ldr x0, =0
.L_end_1075:
    b .L_end_1073
.L_else_1072:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1077
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_1081
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    bne .L_true_1081
    mov x0, #0
    b .L_end_1081
.L_true_1081:
    mov x0, #1
.L_end_1081:
    cmp x0, #0
    beq .L_else_1079
    ldr x0, =1
    b .L_end_1080
.L_else_1079:
    ldr x0, =0
.L_end_1080:
    b .L_end_1078
.L_else_1077:
    ldr x0, =0
.L_end_1078:
.L_end_1073:
.L_end_1069:
.L_end_1065:
.L_end_1061:
.L_end_1059:
.L_end_1057:
.L_end_1055:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1082
.L_else_1082:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1051:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1084
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1088
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1088
    mov x0, #1
    b .L_end_1088
.L_false_1088:
    mov x0, #0
.L_end_1088:
    cmp x0, #0
    beq .L_else_1086
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1087
.L_else_1086:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1091
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1091
    mov x0, #1
    b .L_end_1091
.L_false_1091:
    mov x0, #0
.L_end_1091:
    cmp x0, #0
    beq .L_else_1089
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1090
.L_else_1089:
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1094
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1094
    mov x0, #1
    b .L_end_1094
.L_false_1094:
    mov x0, #0
.L_end_1094:
    cmp x0, #0
    beq .L_else_1092
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1093
.L_else_1092:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1097
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1097
    mov x0, #1
    b .L_end_1097
.L_false_1097:
    mov x0, #0
.L_end_1097:
    cmp x0, #0
    beq .L_else_1095
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1096
.L_else_1095:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1100
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1100
    mov x0, #1
    b .L_end_1100
.L_false_1100:
    mov x0, #0
.L_end_1100:
    cmp x0, #0
    beq .L_else_1098
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1099
.L_else_1098:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1103
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1103
    mov x0, #1
    b .L_end_1103
.L_false_1103:
    mov x0, #0
.L_end_1103:
    cmp x0, #0
    beq .L_else_1101
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1102
.L_else_1101:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1106
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1106
    mov x0, #1
    b .L_end_1106
.L_false_1106:
    mov x0, #0
.L_end_1106:
    cmp x0, #0
    beq .L_else_1104
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1105
.L_else_1104:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1109
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1109
    mov x0, #1
    b .L_end_1109
.L_false_1109:
    mov x0, #0
.L_end_1109:
    cmp x0, #0
    beq .L_else_1107
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1108
.L_else_1107:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1112
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1112
    mov x0, #1
    b .L_end_1112
.L_false_1112:
    mov x0, #0
.L_end_1112:
    cmp x0, #0
    beq .L_else_1110
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1110:
.L_end_1108:
.L_end_1105:
.L_end_1102:
.L_end_1099:
.L_end_1096:
.L_end_1093:
.L_end_1090:
.L_end_1087:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1113
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1115
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1115:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1117
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1117:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1119
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1119:
.L_else_1113:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1121
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1123
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1123:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1125
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1125:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1127
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1127:
.L_else_1121:
.L_else_1084:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1129
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1133
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1133
    mov x0, #1
    b .L_end_1133
.L_false_1133:
    mov x0, #0
.L_end_1133:
    cmp x0, #0
    beq .L_else_1131
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1131:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1136
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1136
    mov x0, #1
    b .L_end_1136
.L_false_1136:
    mov x0, #0
.L_end_1136:
    cmp x0, #0
    beq .L_else_1134
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1134:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1139
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1139
    mov x0, #1
    b .L_end_1139
.L_false_1139:
    mov x0, #0
.L_end_1139:
    cmp x0, #0
    beq .L_else_1137
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1137:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1142
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1142
    mov x0, #1
    b .L_end_1142
.L_false_1142:
    mov x0, #0
.L_end_1142:
    cmp x0, #0
    beq .L_else_1140
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1140:
.L_else_1129:
.L_else_1035:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseFaktor:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #208
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =40
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1143
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    bl ParseVyraz
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =41
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1145
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1145:
    b .L_end_1144
.L_else_1143:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1147
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1148
.L_else_1147:
    str x0, [sp, -16]!
    ldr x0, =81
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1149
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1150
.L_else_1149:
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1151
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1152
.L_else_1151:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1153
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1154
.L_else_1153:
    str x0, [sp, -16]!
    ldr x0, =98
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1155
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_globalni_float_id
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_globalni_float_id
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1156
.L_else_1155:
    str x0, [sp, -16]!
    ldr x0, =52
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1157
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejVelikostStruktury
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1158
.L_else_1157:
    str x0, [sp, -16]!
    ldr x0, =53
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1159
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1160
.L_else_1159:
    str x0, [sp, -16]!
    ldr x0, =91
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1161
    str x0, [sp, -16]!
    ldr x0, =30
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1162
.L_else_1161:
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1163
    str x0, [sp, -16]!
    ldr x0, =20
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1165:
    str x0, [sp, -16]!
    ldr x0, =41
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1167
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1167
    mov x0, #1
    b .L_end_1167
.L_false_1167:
    mov x0, #0
.L_end_1167:
    cmp x0, #0
    beq .L_end_1166
    bl ParseVyraz
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1168
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_end_1169
.L_else_1168:
.L_end_1169:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =51
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1170
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1170:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1165
.L_end_1166:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1164
.L_else_1163:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1172
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =63
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1174
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1176
    str x0, [sp, -16]!
    ldr x0, =27
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1178
.L_else_1178:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =39
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1180
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1180:
    b .L_end_1177
.L_else_1176:
    str x0, [sp, -16]!
    ldr x0, =16
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1182
.L_else_1182:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_end_1177:
    b .L_end_1175
.L_else_1174:
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1184
    str x0, [sp, -16]!
    ldr x0, =32
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    bl ParseVyraz
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =39
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1186
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1186:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1188
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    bl ParseVyraz
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =39
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1190
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1190:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1192
.L_else_1192:
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
.L_else_1188:
    b .L_end_1185
.L_else_1184:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1196
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1196
    mov x0, #1
    b .L_end_1196
.L_false_1196:
    mov x0, #0
.L_end_1196:
    cmp x0, #0
    beq .L_else_1194
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1195
.L_else_1194:
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_end_1195:
.L_end_1185:
.L_end_1175:
    b .L_end_1173
.L_else_1172:
.L_end_1173:
.L_end_1164:
.L_end_1162:
.L_end_1160:
.L_end_1158:
.L_end_1156:
.L_end_1154:
.L_end_1152:
.L_end_1150:
.L_end_1148:
.L_end_1144:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseNasobeni:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParseFaktor
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1197:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1200
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1200
    mov x0, #0
    b .L_end_1200
.L_true_1200:
    mov x0, #1
.L_end_1200:
    cmp x0, #0
    bne .L_true_1199
    str x0, [sp, -16]!
    ldr x0, =80
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1199
    mov x0, #0
    b .L_end_1199
.L_true_1199:
    mov x0, #1
.L_end_1199:
    cmp x0, #0
    beq .L_end_1198
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl OptimalizujUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1197
.L_end_1198:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseScitani:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParseNasobeni
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1201:
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1203
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1203
    mov x0, #0
    b .L_end_1203
.L_true_1203:
    mov x0, #1
.L_end_1203:
    cmp x0, #0
    beq .L_end_1202
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl OptimalizujUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1201
.L_end_1202:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParsePosun:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParseScitani
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1204:
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1206
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1206
    mov x0, #0
    b .L_end_1206
.L_true_1206:
    mov x0, #1
.L_end_1206:
    cmp x0, #0
    beq .L_end_1205
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl OptimalizujUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1204
.L_end_1205:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParsePorovnani:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParsePosun
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1207:
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1211
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1211
    mov x0, #0
    b .L_end_1211
.L_true_1211:
    mov x0, #1
.L_end_1211:
    cmp x0, #0
    bne .L_true_1210
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1210
    mov x0, #0
    b .L_end_1210
.L_true_1210:
    mov x0, #1
.L_end_1210:
    cmp x0, #0
    bne .L_true_1209
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1209
    mov x0, #0
    b .L_end_1209
.L_true_1209:
    mov x0, #1
.L_end_1209:
    cmp x0, #0
    beq .L_end_1208
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl OptimalizujUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1207
.L_end_1208:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseRovnost:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParsePorovnani
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1212:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1214
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1214
    mov x0, #0
    b .L_end_1214
.L_true_1214:
    mov x0, #1
.L_end_1214:
    cmp x0, #0
    beq .L_end_1213
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl OptimalizujUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1212
.L_end_1213:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseBitAND:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParseRovnost
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1215:
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_end_1216
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1215
.L_end_1216:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseBitXOR:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParseBitAND
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1217:
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_end_1218
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1217
.L_end_1218:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseBitOR:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParseBitXOR
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1219:
    str x0, [sp, -16]!
    ldr x0, =82
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_end_1220
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1219
.L_end_1220:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseVyraz:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #32
    bl ParseBitOR
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1221:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1223
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1223
    mov x0, #0
    b .L_end_1223
.L_true_1223:
    mov x0, #1
.L_end_1223:
    cmp x0, #0
    beq .L_end_1222
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1221
.L_end_1222:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZiskejTypUzlu:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1224
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1224:
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1228
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1228
    mov x0, #0
    b .L_end_1228
.L_true_1228:
    mov x0, #1
.L_end_1228:
    cmp x0, #0
    beq .L_else_1226
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1226:
    str x0, [sp, -16]!
    ldr x0, =98
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1229
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1229:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1237
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1237
    mov x0, #0
    b .L_end_1237
.L_true_1237:
    mov x0, #1
.L_end_1237:
    cmp x0, #0
    bne .L_true_1236
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1236
    mov x0, #0
    b .L_end_1236
.L_true_1236:
    mov x0, #1
.L_end_1236:
    cmp x0, #0
    bne .L_true_1235
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1235
    mov x0, #0
    b .L_end_1235
.L_true_1235:
    mov x0, #1
.L_end_1235:
    cmp x0, #0
    bne .L_true_1234
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1234
    mov x0, #0
    b .L_end_1234
.L_true_1234:
    mov x0, #1
.L_end_1234:
    cmp x0, #0
    bne .L_true_1233
    str x0, [sp, -16]!
    ldr x0, =80
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1233
    mov x0, #0
    b .L_end_1233
.L_true_1233:
    mov x0, #1
.L_end_1233:
    cmp x0, #0
    beq .L_else_1231
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1240
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1240
    mov x0, #0
    b .L_end_1240
.L_true_1240:
    mov x0, #1
.L_end_1240:
    cmp x0, #0
    beq .L_else_1238
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1238:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1243
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1243
    mov x0, #0
    b .L_end_1243
.L_true_1243:
    mov x0, #1
.L_end_1243:
    cmp x0, #0
    beq .L_else_1241
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1241:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1231:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1244
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1246
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1246:
.L_else_1244:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1248
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1252
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1252
    mov x0, #1
    b .L_end_1252
.L_false_1252:
    mov x0, #0
.L_end_1252:
    cmp x0, #0
    beq .L_else_1250
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1250:
.L_else_1248:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ZkontrolujAST:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #192
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1253
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1253:
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1255
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1255:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1257
    ldr x8, =gvar_kontrola_aktualni_typ_metody
    str x0, [x8]
.L_else_1257:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1262
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1262
    mov x0, #0
    b .L_end_1262
.L_true_1262:
    mov x0, #1
.L_end_1262:
    cmp x0, #0
    bne .L_true_1261
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1261
    mov x0, #0
    b .L_end_1261
.L_true_1261:
    mov x0, #1
.L_end_1261:
    cmp x0, #0
    beq .L_else_1259
    ldr x0, =0
.L_start_1263:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_1264
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1265
.L_else_1265:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_1263
.L_end_1264:
.L_else_1259:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1269
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1269
    mov x0, #0
    b .L_end_1269
.L_true_1269:
    mov x0, #1
.L_end_1269:
    cmp x0, #0
    beq .L_else_1267
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1270
.L_else_1270:
.L_else_1267:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1272
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1274
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
.L_else_1274:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1276
.L_else_1276:
.L_else_1272:
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1278
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1283
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1283
    mov x0, #0
    b .L_end_1283
.L_true_1283:
    mov x0, #1
.L_end_1283:
    cmp x0, #0
    bne .L_true_1282
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1282
    mov x0, #0
    b .L_end_1282
.L_true_1282:
    mov x0, #1
.L_end_1282:
    cmp x0, #0
    beq .L_else_1280
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1286
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1286
    mov x0, #1
    b .L_end_1286
.L_false_1286:
    mov x0, #0
.L_end_1286:
    cmp x0, #0
    beq .L_else_1284
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1287
.L_else_1287:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1289
.L_else_1289:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1291
.L_else_1291:
.L_else_1284:
.L_else_1280:
.L_else_1278:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1293
    ldr x0, =0
.L_start_1295:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_1296
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_1295
.L_end_1296:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1299
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1299
    mov x0, #1
    b .L_end_1299
.L_false_1299:
    mov x0, #0
.L_end_1299:
    cmp x0, #0
    beq .L_else_1297
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1300
.L_else_1300:
    ldr x0, =0
.L_start_1302:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_1303
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1304
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1306
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1308
.L_else_1308:
.L_else_1306:
.L_else_1304:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_1302
.L_end_1303:
.L_else_1297:
.L_else_1293:
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1310
    ldr x8, =gvar_kontrola_aktualni_typ_metody
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1314
    str x0, [sp, -16]!
    ldr x8, =gvar_kontrola_aktualni_typ_metody
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1314
    mov x0, #1
    b .L_end_1314
.L_false_1314:
    mov x0, #0
.L_end_1314:
    cmp x0, #0
    beq .L_else_1312
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1315
    ldr x8, =gvar_kontrola_aktualni_typ_metody
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1317
.L_else_1317:
.L_else_1315:
.L_else_1312:
.L_else_1310:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1321
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1321
    mov x0, #0
    b .L_end_1321
.L_true_1321:
    mov x0, #1
.L_end_1321:
    cmp x0, #0
    beq .L_else_1319
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1322
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1324
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1326
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1328
.L_else_1328:
    b .L_end_1327
.L_else_1326:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1330
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1332
.L_else_1332:
.L_else_1330:
.L_end_1327:
.L_else_1324:
.L_else_1322:
.L_else_1319:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1334
    ldr x0, =0
    ldr x8, =gvar_kontrola_aktualni_typ_metody
    str x0, [x8]
.L_else_1334:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseBlok:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #64
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_hloubka_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_hloubka_bloku
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1336:
    str x0, [sp, -16]!
    ldr x0, =37
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1338
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1338
    mov x0, #1
    b .L_end_1338
.L_false_1338:
    mov x0, #0
.L_end_1338:
    cmp x0, #0
    beq .L_end_1337
    bl ParsePrikaz
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1339
    str x0, [sp, -16]!
    ldr x0, =40
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_1341
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
.L_else_1341:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_1339:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1336
.L_end_1337:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_1343:
    str x0, [sp, -16]!
    ldr x8, =gvar_parse_sym_start
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_1344
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_aktualni_hloubka_bloku
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1345
.L_else_1345:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_1343
.L_end_1344:
    ldr x8, =gvar_aktualni_hloubka_bloku
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    ldr x8, =gvar_aktualni_hloubka_bloku
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParsePrikaz:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #480
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x0, =0
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =23
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1347
    str x0, [sp, -16]!
    ldr x0, =26
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1349
    b .L_end_1350
.L_else_1349:
.L_end_1350:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1347:
    str x0, [sp, -16]!
    ldr x0, =94
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1351
    str x0, [sp, -16]!
    ldr x0, =34
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1351:
    str x0, [sp, -16]!
    ldr x0, =66
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1353
    str x0, [sp, -16]!
    ldr x0, =11
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1353:
    str x0, [sp, -16]!
    ldr x0, =54
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1355
    str x0, [sp, -16]!
    ldr x0, =22
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1355:
    str x0, [sp, -16]!
    ldr x0, =56
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1357
    str x0, [sp, -16]!
    ldr x0, =23
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1357:
    str x0, [sp, -16]!
    ldr x0, =92
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1359
    str x0, [sp, -16]!
    ldr x0, =31
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1359:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1361
    str x0, [sp, -16]!
    ldr x0, =3
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x0, =8
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x0, =1
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1363
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1365
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1365:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
.L_else_1363:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1367
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1367:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1369
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1370
.L_else_1369:
.L_end_1370:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1371
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1373
    b .L_end_1374
.L_else_1373:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1375
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1377
.L_else_1377:
.L_else_1375:
.L_end_1374:
.L_else_1371:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1361:
    str x0, [sp, -16]!
    ldr x0, =19
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1379
    str x0, [sp, -16]!
    ldr x0, =25
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1379:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1381
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1386
    str x0, [sp, -16]!
    ldr x0, =69
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1386
    mov x0, #0
    b .L_end_1386
.L_true_1386:
    mov x0, #1
.L_end_1386:
    cmp x0, #0
    bne .L_true_1385
    str x0, [sp, -16]!
    ldr x0, =70
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1385
    mov x0, #0
    b .L_end_1385
.L_true_1385:
    mov x0, #1
.L_end_1385:
    cmp x0, #0
    beq .L_else_1383
    str x0, [sp, -16]!
    ldr x0, =4
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1389
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1389
    mov x0, #1
    b .L_end_1389
.L_false_1389:
    mov x0, #0
.L_end_1389:
    cmp x0, #0
    beq .L_else_1387
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1390
.L_else_1390:
.L_else_1387:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1384
.L_else_1383:
    str x0, [sp, -16]!
    ldr x0, =63
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1392
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1394
    str x0, [sp, -16]!
    ldr x0, =17
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1396
.L_else_1396:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1395
.L_else_1394:
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1398
    str x0, [sp, -16]!
    ldr x0, =19
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1400
.L_else_1400:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =39
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1402
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1402:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1404
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1404:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1398:
.L_end_1395:
    b .L_end_1393
.L_else_1392:
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1406
    str x0, [sp, -16]!
    ldr x0, =33
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    bl ParseVyraz
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =39
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1408
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1408:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1410
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    bl ParseVyraz
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =39
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1412
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1412:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1414
.L_else_1414:
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, =5
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
.L_else_1410:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1416
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1416:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1406:
.L_end_1393:
.L_end_1384:
.L_else_1381:
    str x0, [sp, -16]!
    ldr x0, =21
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1418
    str x0, [sp, -16]!
    ldr x0, =6
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1420
    b .L_end_1421
.L_else_1420:
.L_end_1421:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =22
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1422
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1424
    b .L_end_1425
.L_else_1424:
.L_end_1425:
.L_else_1422:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1418:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1426
    str x0, [sp, -16]!
    ldr x0, =7
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1428
    b .L_end_1429
.L_else_1428:
.L_end_1429:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1426:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1430
    str x0, [sp, -16]!
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =51
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1432
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1432:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =51
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1434
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1434:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =41
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1436
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1436:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1438
    bl ParseBlok
    b .L_end_1439
.L_else_1438:
    bl ParsePrikaz
.L_end_1439:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1430:
    str x0, [sp, -16]!
    ldr x0, =71
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1440
    str x0, [sp, -16]!
    ldr x0, =28
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =41
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1442
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1442:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1444
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1444:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1446:
    str x0, [sp, -16]!
    ldr x0, =37
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1448
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1448
    mov x0, #1
    b .L_end_1448
.L_false_1448:
    mov x0, #0
.L_end_1448:
    cmp x0, #0
    beq .L_end_1447
    str x0, [sp, -16]!
    ldr x0, =72
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1449
    str x0, [sp, -16]!
    ldr x0, =29
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1451
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1451:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1453
    b .L_end_1454
.L_else_1453:
.L_end_1454:
    str x0, [sp, -16]!
    ldr x0, =495
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1455
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_end_1456
.L_else_1455:
.L_end_1456:
    b .L_end_1450
.L_else_1449:
    str x0, [sp, -16]!
    ldr x0, =73
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1457
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1459
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1459:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1461
    b .L_end_1462
.L_else_1461:
.L_end_1462:
    b .L_end_1458
.L_else_1457:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_end_1458:
.L_end_1450:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1446
.L_end_1447:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1440:
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1463
    str x0, [sp, -16]!
    ldr x0, =20
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1465:
    str x0, [sp, -16]!
    ldr x0, =41
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1467
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1467
    mov x0, #1
    b .L_end_1467
.L_false_1467:
    mov x0, #0
.L_end_1467:
    cmp x0, #0
    beq .L_end_1466
    bl ParseVyraz
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1468
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_end_1469
.L_else_1468:
.L_end_1469:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =51
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1470
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1470:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1465
.L_end_1466:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1463:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =100
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

ParseMetoda:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #96
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =65
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1472
    str x0, [sp, -16]!
    ldr x0, =10
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_1474
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_symbolu
    str x0, [x8]
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_symbolu
    str x0, [x8]
.L_else_1474:
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_current_local_offset
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    ldr x8, =gvar_parse_sym_start
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1476:
    str x0, [sp, -16]!
    ldr x0, =41
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1478
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1478
    mov x0, #1
    b .L_end_1478
.L_false_1478:
    mov x0, #0
.L_end_1478:
    cmp x0, #0
    beq .L_end_1477
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1479
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_1481
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    ldr x8, =gvar_kapacita_symbolu
    str x0, [x8]
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    str x0, [sp, -16]!
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl realloc
    ldr x8, =gvar_pamet_symbolu
    str x0, [x8]
.L_else_1481:
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_symbolu
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1483
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1485
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1485:
.L_else_1483:
.L_else_1479:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =51
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1487
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1487:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1476
.L_end_1477:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =57
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1489
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1491
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1491:
.L_else_1489:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1472:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

Parser:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #240
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x0, =0
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1493:
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1495
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_false_1495
    mov x0, #1
    b .L_end_1495
.L_false_1495:
    mov x0, #0
.L_end_1495:
    cmp x0, #0
    beq .L_end_1494
    str x0, [sp, -16]!
    ldr x0, =31
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1496
    str x0, [sp, -16]!
    ldr x0, =24
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl VytvorUzel
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4995
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1498
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_end_1499
.L_else_1498:
.L_end_1499:
    b .L_end_1497
.L_else_1496:
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1500
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1502
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    bl ParseVyraz
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl VyhodnotKonstantu
.L_else_1502:
    b .L_end_1501
.L_else_1500:
    str x0, [sp, -16]!
    ldr x0, =59
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1504
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1505
.L_else_1504:
    str x0, [sp, -16]!
    ldr x0, =60
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1506
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1508:
    str x0, [sp, -16]!
    ldr x0, =37
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1510
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1510
    mov x0, #1
    b .L_end_1510
.L_false_1510:
    mov x0, #0
.L_end_1510:
    cmp x0, #0
    beq .L_end_1509
    ldr x0, =1
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =38
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1511
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1511:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1508
.L_end_1509:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1507
.L_else_1506:
    str x0, [sp, -16]!
    ldr x0, =93
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1513
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1515
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1515:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =36
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1517
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1517:
    ldr x0, =0
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
.L_start_1519:
    str x0, [sp, -16]!
    ldr x0, =37
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1521
    str x0, [sp, -16]!
    ldr x0, =55
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1521
    mov x0, #1
    b .L_end_1521
.L_false_1521:
    mov x0, #0
.L_end_1521:
    cmp x0, #0
    beq .L_end_1520
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1522
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =42
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1524
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1526
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_else_1526:
.L_else_1524:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1530
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1530
    mov x0, #1
    b .L_end_1530
.L_false_1530:
    mov x0, #0
.L_end_1530:
    cmp x0, #0
    beq .L_else_1528
.L_else_1528:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_end_1523
.L_else_1522:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_end_1523:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1519
.L_end_1520:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
    b .L_end_1514
.L_else_1513:
    bl ParseMetoda
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1531
    str x0, [sp, -16]!
    ldr x0, =4995
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1533
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_end_1534
.L_else_1533:
.L_end_1534:
    b .L_end_1532
.L_else_1531:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_aktualni_token_idx
    str x0, [x8]
.L_end_1532:
.L_end_1514:
.L_end_1507:
.L_end_1505:
.L_end_1501:
.L_end_1497:
    ldr x8, =gvar_aktualni_token_idx
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejToken
    b .L_start_1493
.L_end_1494:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GenerujVyraz_x86:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #224
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1535
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1535:
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1537
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1537:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl GenerujIR_Vyraz
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1539
    ldr x8, =gvar_pamet_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1539:
    str x0, [sp, -16]!
    ldr x0, =98
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1541
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1541:
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1543
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1543:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1545
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1545:
    str x0, [sp, -16]!
    ldr x0, =53
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1547
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1547:
    str x0, [sp, -16]!
    ldr x0, =30
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1549
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1551
    b .L_end_1552
.L_else_1551:
.L_end_1552:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1553
    b .L_end_1554
.L_else_1553:
.L_end_1554:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1549:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1555
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1557
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    asr x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1559
    ldr x0, =8
.L_else_1559:
.L_else_1557:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_1561:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_1562
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1565
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1565
    mov x0, #1
    b .L_end_1565
.L_false_1565:
    mov x0, #0
.L_end_1565:
    cmp x0, #0
    beq .L_else_1563
.L_else_1563:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_1561
.L_end_1562:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1566
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1568
.L_else_1568:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1570
.L_else_1570:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1572
.L_else_1572:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1574
.L_else_1574:
    b .L_end_1567
.L_else_1566:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1576
.L_else_1576:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1578
.L_else_1578:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1580
.L_else_1580:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1582
.L_else_1582:
.L_end_1567:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1586
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1586
    mov x0, #1
    b .L_end_1586
.L_false_1586:
    mov x0, #0
.L_end_1586:
    cmp x0, #0
    beq .L_else_1584
    cmp x0, #0
    beq .L_else_1587
    b .L_end_1588
.L_else_1587:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1589
    b .L_end_1590
.L_else_1589:
.L_end_1590:
.L_end_1588:
    b .L_end_1585
.L_else_1584:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1593
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeExterniJmeno
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1593
    mov x0, #1
    b .L_end_1593
.L_false_1593:
    mov x0, #0
.L_end_1593:
    cmp x0, #0
    beq .L_else_1591
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NazevSymbolu
.L_else_1591:
.L_end_1585:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1594
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_1594:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1596
.L_else_1596:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1555:
    str x0, [sp, -16]!
    ldr x0, =27
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1598
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1600
    cmp x0, #0
    beq .L_else_1602
    b .L_end_1603
.L_else_1602:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1604
    b .L_end_1605
.L_else_1604:
.L_end_1605:
.L_end_1603:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1606
.L_else_1606:
    ldr x0, =0
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1608
    ldr x0, =1
.L_else_1608:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1610
    ldr x0, =1
.L_else_1610:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1612
    ldr x0, =1
.L_else_1612:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1614
    ldr x0, =1
.L_else_1614:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1616
    ldr x0, =1
.L_else_1616:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1618
    ldr x0, =1
.L_else_1618:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1620
    ldr x0, =1
.L_else_1620:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1622
    b .L_end_1623
.L_else_1622:
.L_end_1623:
.L_else_1600:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1598:
    str x0, [sp, -16]!
    ldr x0, =32
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1624
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1626
    cmp x0, #0
    beq .L_else_1628
    b .L_end_1629
.L_else_1628:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1630
    b .L_end_1631
.L_else_1630:
.L_end_1631:
.L_end_1629:
.L_else_1626:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1624:
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1632
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1634
    cmp x0, #0
    beq .L_else_1636
    b .L_end_1637
.L_else_1636:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1638
    b .L_end_1639
.L_else_1638:
.L_end_1639:
.L_end_1637:
    ldr x0, =0
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1640
    ldr x0, =1
.L_else_1640:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1642
    ldr x0, =1
.L_else_1642:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1644
    ldr x0, =1
.L_else_1644:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1646
    ldr x0, =1
.L_else_1646:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1648
    ldr x0, =1
.L_else_1648:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1650
    ldr x0, =1
.L_else_1650:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1652
    ldr x0, =1
.L_else_1652:
    cmp x0, #0
    beq .L_else_1654
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1656
.L_else_1656:
    b .L_end_1655
.L_else_1654:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1658
    b .L_end_1659
.L_else_1658:
.L_end_1659:
.L_end_1655:
.L_else_1634:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1632:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1660
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1662
    cmp x0, #0
    beq .L_else_1664
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1668
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeExterniJmeno
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1668
    mov x0, #1
    b .L_end_1668
.L_false_1668:
    mov x0, #0
.L_end_1668:
    cmp x0, #0
    beq .L_else_1666
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NazevSymbolu
.L_else_1666:
    b .L_end_1665
.L_else_1664:
    cmp x0, #0
    beq .L_else_1669
    b .L_end_1670
.L_else_1669:
    cmp x0, #0
    beq .L_else_1671
    b .L_end_1672
.L_else_1671:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1673
    b .L_end_1674
.L_else_1673:
.L_end_1674:
.L_end_1672:
.L_end_1670:
.L_end_1665:
    b .L_end_1663
.L_else_1662:
.L_end_1663:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1660:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1678
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1678
    mov x0, #1
    b .L_end_1678
.L_false_1678:
    mov x0, #0
.L_end_1678:
    cmp x0, #0
    beq .L_false_1677
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1677
    mov x0, #1
    b .L_end_1677
.L_false_1677:
    mov x0, #0
.L_end_1677:
    cmp x0, #0
    beq .L_else_1675
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1675:
    str x0, [sp, -16]!
    ldr x0, =81
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1681
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1681
    mov x0, #1
    b .L_end_1681
.L_false_1681:
    mov x0, #0
.L_end_1681:
    cmp x0, #0
    beq .L_else_1679
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1679:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1682
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1682:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1684
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1684:
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1702
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1702
    mov x0, #0
    b .L_end_1702
.L_true_1702:
    mov x0, #1
.L_end_1702:
    cmp x0, #0
    bne .L_true_1701
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1701
    mov x0, #0
    b .L_end_1701
.L_true_1701:
    mov x0, #1
.L_end_1701:
    cmp x0, #0
    bne .L_true_1700
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1700
    mov x0, #0
    b .L_end_1700
.L_true_1700:
    mov x0, #1
.L_end_1700:
    cmp x0, #0
    bne .L_true_1699
    str x0, [sp, -16]!
    ldr x0, =80
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1699
    mov x0, #0
    b .L_end_1699
.L_true_1699:
    mov x0, #1
.L_end_1699:
    cmp x0, #0
    bne .L_true_1698
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1698
    mov x0, #0
    b .L_end_1698
.L_true_1698:
    mov x0, #1
.L_end_1698:
    cmp x0, #0
    bne .L_true_1697
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1697
    mov x0, #0
    b .L_end_1697
.L_true_1697:
    mov x0, #1
.L_end_1697:
    cmp x0, #0
    bne .L_true_1696
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1696
    mov x0, #0
    b .L_end_1696
.L_true_1696:
    mov x0, #1
.L_end_1696:
    cmp x0, #0
    bne .L_true_1695
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1695
    mov x0, #0
    b .L_end_1695
.L_true_1695:
    mov x0, #1
.L_end_1695:
    cmp x0, #0
    bne .L_true_1694
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1694
    mov x0, #0
    b .L_end_1694
.L_true_1694:
    mov x0, #1
.L_end_1694:
    cmp x0, #0
    bne .L_true_1693
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1693
    mov x0, #0
    b .L_end_1693
.L_true_1693:
    mov x0, #1
.L_end_1693:
    cmp x0, #0
    bne .L_true_1692
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1692
    mov x0, #0
    b .L_end_1692
.L_true_1692:
    mov x0, #1
.L_end_1692:
    cmp x0, #0
    bne .L_true_1691
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1691
    mov x0, #0
    b .L_end_1691
.L_true_1691:
    mov x0, #1
.L_end_1691:
    cmp x0, #0
    bne .L_true_1690
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1690
    mov x0, #0
    b .L_end_1690
.L_true_1690:
    mov x0, #1
.L_end_1690:
    cmp x0, #0
    bne .L_true_1689
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1689
    mov x0, #0
    b .L_end_1689
.L_true_1689:
    mov x0, #1
.L_end_1689:
    cmp x0, #0
    bne .L_true_1688
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1688
    mov x0, #0
    b .L_end_1688
.L_true_1688:
    mov x0, #1
.L_end_1688:
    cmp x0, #0
    beq .L_else_1686
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1705
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1705
    mov x0, #0
    b .L_end_1705
.L_true_1705:
    mov x0, #1
.L_end_1705:
    cmp x0, #0
    beq .L_else_1703
    ldr x0, =1
.L_else_1703:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1706
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1710
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1710
    mov x0, #1
    b .L_end_1710
.L_false_1710:
    mov x0, #0
.L_end_1710:
    cmp x0, #0
    beq .L_else_1708
    ldr x0, =1
.L_else_1708:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1713
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1713
    mov x0, #1
    b .L_end_1713
.L_false_1713:
    mov x0, #0
.L_end_1713:
    cmp x0, #0
    beq .L_else_1711
    ldr x0, =2
.L_else_1711:
.L_else_1706:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1714
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, =1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1716
.L_else_1716:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1718
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    cmp x0, #0
    beq .L_else_1720
    b .L_end_1721
.L_else_1720:
    cmp x0, #0
    beq .L_else_1722
    b .L_end_1723
.L_else_1722:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1724
    b .L_end_1725
.L_else_1724:
.L_end_1725:
.L_end_1723:
.L_end_1721:
.L_else_1718:
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1726
.L_else_1726:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1728
.L_else_1728:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1730
.L_else_1730:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1732
.L_else_1732:
    str x0, [sp, -16]!
    ldr x0, =80
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1734
.L_else_1734:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1736
.L_else_1736:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1738
.L_else_1738:
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1740
.L_else_1740:
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1742
.L_else_1742:
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1744
.L_else_1744:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1746
.L_else_1746:
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1748
.L_else_1748:
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1750
.L_else_1750:
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1752
.L_else_1752:
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1754
.L_else_1754:
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1756
.L_else_1756:
    b .L_end_1715
.L_else_1714:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1758
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1760
    b .L_end_1761
.L_else_1760:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1762
    b .L_end_1763
.L_else_1762:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1764
    b .L_end_1765
.L_else_1764:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1766
    b .L_end_1767
.L_else_1766:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1768
    b .L_end_1769
.L_else_1768:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1770
    b .L_end_1771
.L_else_1770:
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1772
    b .L_end_1773
.L_else_1772:
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1774
    b .L_end_1775
.L_else_1774:
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1776
    b .L_end_1777
.L_else_1776:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1778
.L_else_1778:
.L_end_1777:
.L_end_1775:
.L_end_1773:
.L_end_1771:
.L_end_1769:
.L_end_1767:
.L_end_1765:
.L_end_1763:
.L_end_1761:
    b .L_end_1759
.L_else_1758:
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1780
.L_else_1780:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1782
.L_else_1782:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1784
.L_else_1784:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1786
.L_else_1786:
    str x0, [sp, -16]!
    ldr x0, =80
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1788
.L_else_1788:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1790
.L_else_1790:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1792
.L_else_1792:
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1794
.L_else_1794:
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1796
.L_else_1796:
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1798
.L_else_1798:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1800
.L_else_1800:
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1802
.L_else_1802:
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1804
.L_else_1804:
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1806
.L_else_1806:
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1808
.L_else_1808:
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1810
.L_else_1810:
.L_end_1759:
.L_end_1715:
.L_else_1686:
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1815
    str x0, [sp, -16]!
    ldr x0, =96
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1815
    mov x0, #0
    b .L_end_1815
.L_true_1815:
    mov x0, #1
.L_end_1815:
    cmp x0, #0
    bne .L_true_1814
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1814
    mov x0, #0
    b .L_end_1814
.L_true_1814:
    mov x0, #1
.L_end_1814:
    cmp x0, #0
    beq .L_else_1812
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1816
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1818
    b .L_end_1819
.L_else_1818:
.L_end_1819:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1820
    b .L_end_1821
.L_else_1820:
.L_end_1821:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1822
    b .L_end_1823
.L_else_1822:
.L_end_1823:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1824
    b .L_end_1825
.L_else_1824:
.L_end_1825:
    b .L_end_1817
.L_else_1816:
    str x0, [sp, -16]!
    ldr x0, =96
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1828
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1828
    mov x0, #0
    b .L_end_1828
.L_true_1828:
    mov x0, #1
.L_end_1828:
    cmp x0, #0
    beq .L_else_1826
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1829
    b .L_end_1830
.L_else_1829:
.L_end_1830:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1831
    b .L_end_1832
.L_else_1831:
.L_end_1832:
    str x0, [sp, -16]!
    ldr x0, =96
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1833
    b .L_end_1834
.L_else_1833:
.L_end_1834:
.L_else_1826:
.L_end_1817:
.L_else_1812:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GenerujAST_x86:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #352
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1835
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1835:
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1837
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1837:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1839
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =499
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1841
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_defer
    str x0, [x8]
    b .L_end_1842
.L_else_1841:
.L_end_1842:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1839:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1843
    ldr x0, =0
.L_start_1845:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_1846
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1847
.L_else_1847:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_1845
.L_end_1846:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1843:
    str x0, [sp, -16]!
    ldr x0, =26
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1849
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1855
    str x0, [sp, -16]!
    ldr x0, =114
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1855
    mov x0, #1
    b .L_end_1855
.L_false_1855:
    mov x0, #0
.L_end_1855:
    cmp x0, #0
    beq .L_false_1854
    str x0, [sp, -16]!
    ldr x0, =109
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1854
    mov x0, #1
    b .L_end_1854
.L_false_1854:
    mov x0, #0
.L_end_1854:
    cmp x0, #0
    beq .L_false_1853
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1853
    mov x0, #1
    b .L_end_1853
.L_false_1853:
    mov x0, #0
.L_end_1853:
    cmp x0, #0
    beq .L_else_1851
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1851:
    str x0, [sp, -16]!
    ldr x0, =120
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1860
    str x0, [sp, -16]!
    ldr x0, =56
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1860
    mov x0, #1
    b .L_end_1860
.L_false_1860:
    mov x0, #0
.L_end_1860:
    cmp x0, #0
    beq .L_false_1859
    str x0, [sp, -16]!
    ldr x0, =54
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1859
    mov x0, #1
    b .L_end_1859
.L_false_1859:
    mov x0, #0
.L_end_1859:
    cmp x0, #0
    beq .L_false_1858
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1858
    mov x0, #1
    b .L_end_1858
.L_false_1858:
    mov x0, #0
.L_end_1858:
    cmp x0, #0
    beq .L_else_1856
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_1856:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1849:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1861
    ldr x0, =0
    ldr x8, =gvar_pocet_ir
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_pocet_defer
    str x0, [x8]
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1865
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeExterniJmeno
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1865
    mov x0, #1
    b .L_end_1865
.L_false_1865:
    mov x0, #0
.L_end_1865:
    cmp x0, #0
    beq .L_else_1863
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NazevSymbolu
.L_else_1863:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1866
    b .L_end_1867
.L_else_1866:
.L_end_1867:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_start_1868:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_end_1869
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_1868
.L_end_1869:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1870
.L_else_1870:
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_1872:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_1873
    ldr x8, =gvar_pamet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_1872
.L_end_1873:
    ldr x0, =0
.L_start_1874:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_1875
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =99
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1876
.L_else_1876:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_1874
.L_end_1875:
    ldr x0, =0
    ldr x8, =gvar_pocet_ir
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1861:
    str x0, [sp, -16]!
    ldr x0, =19
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1878
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1880
    cmp x0, #0
    beq .L_else_1882
    b .L_end_1883
.L_else_1882:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1884
    b .L_end_1885
.L_else_1884:
.L_end_1885:
.L_end_1883:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1886
.L_else_1886:
    ldr x0, =0
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1888
    ldr x0, =1
.L_else_1888:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1890
    ldr x0, =1
.L_else_1890:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1892
    ldr x0, =1
.L_else_1892:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1894
    b .L_end_1895
.L_else_1894:
.L_end_1895:
.L_else_1880:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1878:
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1896
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1898
    cmp x0, #0
    beq .L_else_1900
    b .L_end_1901
.L_else_1900:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1902
    b .L_end_1903
.L_else_1902:
.L_end_1903:
.L_end_1901:
.L_else_1898:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1896:
    str x0, [sp, -16]!
    ldr x0, =17
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1904
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1906
    cmp x0, #0
    beq .L_else_1908
    b .L_end_1909
.L_else_1908:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1910
    b .L_end_1911
.L_else_1910:
.L_end_1911:
.L_end_1909:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1912
    b .L_end_1913
.L_else_1912:
.L_end_1913:
.L_else_1906:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1904:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1916
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1916
    mov x0, #0
    b .L_end_1916
.L_true_1916:
    mov x0, #1
.L_end_1916:
    cmp x0, #0
    beq .L_else_1914
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1917
    b .L_end_1918
.L_else_1917:
.L_end_1918:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1919
    str x0, [sp, -16]!
    ldr x0, =69
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1923
    str x0, [sp, -16]!
    ldr x0, =70
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_1923
    mov x0, #0
    b .L_end_1923
.L_true_1923:
    mov x0, #1
.L_end_1923:
    cmp x0, #0
    beq .L_else_1921
    cmp x0, #0
    beq .L_else_1924
    b .L_end_1925
.L_else_1924:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1926
    b .L_end_1927
.L_else_1926:
.L_end_1927:
.L_end_1925:
    str x0, [sp, -16]!
    ldr x0, =69
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1928
.L_else_1928:
    str x0, [sp, -16]!
    ldr x0, =70
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1930
.L_else_1930:
.L_else_1921:
    cmp x0, #0
    beq .L_else_1932
    b .L_end_1933
.L_else_1932:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_1934
    b .L_end_1935
.L_else_1934:
.L_end_1935:
.L_end_1933:
.L_else_1919:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1914:
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1936
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1938
.L_else_1938:
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_1940:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_1941
    ldr x8, =gvar_pamet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_1940
.L_end_1941:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1936:
    str x0, [sp, -16]!
    ldr x0, =25
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1942
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1944
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1946
    b .L_end_1947
.L_else_1946:
.L_end_1947:
    b .L_end_1945
.L_else_1944:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1948
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1950
    b .L_end_1951
.L_else_1950:
.L_end_1951:
    b .L_end_1949
.L_else_1948:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1952
    b .L_end_1953
.L_else_1952:
.L_end_1953:
.L_end_1949:
.L_end_1945:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1942:
    str x0, [sp, -16]!
    ldr x0, =31
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1954
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1956
    b .L_end_1957
.L_else_1956:
.L_end_1957:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1958
    b .L_end_1959
.L_else_1958:
.L_end_1959:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1954:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1960
    ldr x0, =0
.L_start_1962:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_1963
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1964
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1968
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1968
    mov x0, #1
    b .L_end_1968
.L_false_1968:
    mov x0, #0
.L_end_1968:
    cmp x0, #0
    beq .L_else_1966
.L_else_1966:
.L_else_1964:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_1962
.L_end_1963:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1960:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1969
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1973
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1973
    mov x0, #1
    b .L_end_1973
.L_false_1973:
    mov x0, #0
.L_end_1973:
    cmp x0, #0
    beq .L_else_1971
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1974
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1976
.L_else_1976:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    b .L_end_1975
.L_else_1974:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_end_1975:
.L_else_1971:
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1978
.L_else_1978:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1980
.L_else_1980:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1969:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1982
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_1986
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_1986
    mov x0, #1
    b .L_end_1986
.L_false_1986:
    mov x0, #0
.L_end_1986:
    cmp x0, #0
    beq .L_else_1984
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl atoi
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1987
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1987:
.L_else_1984:
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_loop_stack_depth
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_loop_stack_depth
    str x0, [x8]
    ldr x8, =gvar_loop_stack_depth
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    ldr x8, =gvar_loop_stack_depth
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1982:
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1989
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_loop_stack_depth
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_loop_stack_depth
    str x0, [x8]
    ldr x8, =gvar_loop_stack_depth
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    ldr x8, =gvar_loop_stack_depth
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1989:
    str x0, [sp, -16]!
    ldr x0, =23
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1991
    ldr x8, =gvar_loop_continue_stack
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_loop_stack_depth
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1991:
    str x0, [sp, -16]!
    ldr x0, =22
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1993
    ldr x8, =gvar_loop_label_stack
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x8, =gvar_loop_stack_depth
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1993:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_1995
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_1997
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    asr x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_1999
    ldr x0, =8
.L_else_1999:
.L_else_1997:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_2001:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_2002
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2005
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2005
    mov x0, #1
    b .L_end_2005
.L_false_2005:
    mov x0, #0
.L_end_2005:
    cmp x0, #0
    beq .L_else_2003
.L_else_2003:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_2001
.L_end_2002:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2006
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2008
.L_else_2008:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2010
.L_else_2010:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2012
.L_else_2012:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2014
.L_else_2014:
    b .L_end_2007
.L_else_2006:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2016
.L_else_2016:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2018
.L_else_2018:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2020
.L_else_2020:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2022
.L_else_2022:
.L_end_2007:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2026
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2026
    mov x0, #1
    b .L_end_2026
.L_false_2026:
    mov x0, #0
.L_end_2026:
    cmp x0, #0
    beq .L_else_2024
    cmp x0, #0
    beq .L_else_2027
    b .L_end_2028
.L_else_2027:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2029
    b .L_end_2030
.L_else_2029:
.L_end_2030:
.L_end_2028:
    b .L_end_2025
.L_else_2024:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2033
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeExterniJmeno
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2033
    mov x0, #1
    b .L_end_2033
.L_false_2033:
    mov x0, #0
.L_end_2033:
    cmp x0, #0
    beq .L_else_2031
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NazevSymbolu
.L_else_2031:
.L_end_2025:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2034
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_2034:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2036
.L_else_2036:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_1995:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GeneratorASM_x86:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #112
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl fopen
    ldr x0, =0
    ldr x0, =0
.L_start_2038:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_tokenu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_2039
    ldr x8, =gvar_pamet_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =2072
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2040
    ldr x0, =0
    ldr x0, =1
.L_start_2042:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_end_2043
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2044
    ldr x0, =0
    b .L_end_2045
.L_else_2044:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_end_2045:
    b .L_start_2042
.L_end_2043:
.L_else_2040:
    str x0, [sp, -16]!
    ldr x0, =98
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2046
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_2046:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_2038
.L_end_2039:
    ldr x0, =0
.L_start_2048:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_2049
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2050
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2052
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2054
.L_else_2054:
.L_else_2052:
.L_else_2050:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_2048
.L_end_2049:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2056
.L_else_2056:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2058
    b .L_end_2059
.L_else_2058:
.L_end_2059:
    ldr x0, =0
.L_start_2060:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_2061
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =24
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2062
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2064
    b .L_end_2065
.L_else_2064:
.L_end_2065:
.L_else_2062:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_2060
.L_end_2061:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2066
    b .L_end_2067
.L_else_2066:
.L_end_2067:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2068
    b .L_end_2069
.L_else_2068:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2070
    b .L_end_2071
.L_else_2070:
.L_end_2071:
.L_end_2069:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GenerujVyraz:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2074
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2074
    mov x0, #0
    b .L_end_2074
.L_true_2074:
    mov x0, #1
.L_end_2074:
    cmp x0, #0
    beq .L_else_2072
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl GenerujVyraz_ARM
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2072:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl GenerujVyraz_x86
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GenerujAST:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2077
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2077
    mov x0, #0
    b .L_end_2077
.L_true_2077:
    mov x0, #1
.L_end_2077:
    cmp x0, #0
    beq .L_else_2075
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl GenerujAST_ARM
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2075:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl GenerujAST_x86
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GeneratorASM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2080
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2080
    mov x0, #0
    b .L_end_2080
.L_true_2080:
    mov x0, #1
.L_end_2080:
    cmp x0, #0
    beq .L_else_2078
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl GeneratorASM_ARM
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2078:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl GeneratorASM_x86
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GenerujVyraz_ARM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #96
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2081
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2081:
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2083
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2083:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2088
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2088
    mov x0, #1
    b .L_end_2088
.L_false_2088:
    mov x0, #0
.L_end_2088:
    cmp x0, #0
    beq .L_false_2087
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2087
    mov x0, #1
    b .L_end_2087
.L_false_2087:
    mov x0, #0
.L_end_2087:
    cmp x0, #0
    beq .L_else_2085
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2085:
    str x0, [sp, -16]!
    ldr x0, =81
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2091
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2091
    mov x0, #1
    b .L_end_2091
.L_false_2091:
    mov x0, #0
.L_end_2091:
    cmp x0, #0
    beq .L_else_2089
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2089:
    str x0, [sp, -16]!
    ldr x0, =47
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2092
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2092:
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2097
    str x0, [sp, -16]!
    ldr x0, =96
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2097
    mov x0, #0
    b .L_end_2097
.L_true_2097:
    mov x0, #1
.L_end_2097:
    cmp x0, #0
    bne .L_true_2096
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2096
    mov x0, #0
    b .L_end_2096
.L_true_2096:
    mov x0, #1
.L_end_2096:
    cmp x0, #0
    beq .L_else_2094
    str x0, [sp, -16]!
    ldr x0, =95
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2098
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2100
    b .L_end_2101
.L_else_2100:
.L_end_2101:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2102
    b .L_end_2103
.L_else_2102:
.L_end_2103:
    b .L_end_2099
.L_else_2098:
    str x0, [sp, -16]!
    ldr x0, =96
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2106
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2106
    mov x0, #0
    b .L_end_2106
.L_true_2106:
    mov x0, #1
.L_end_2106:
    cmp x0, #0
    beq .L_else_2104
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2107
    b .L_end_2108
.L_else_2107:
.L_end_2108:
    str x0, [sp, -16]!
    ldr x0, =96
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2109
    b .L_end_2110
.L_else_2109:
.L_end_2110:
.L_else_2104:
.L_end_2099:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2094:
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2111
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2111:
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2119
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2119
    mov x0, #0
    b .L_end_2119
.L_true_2119:
    mov x0, #1
.L_end_2119:
    cmp x0, #0
    bne .L_true_2118
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2118
    mov x0, #0
    b .L_end_2118
.L_true_2118:
    mov x0, #1
.L_end_2118:
    cmp x0, #0
    bne .L_true_2117
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2117
    mov x0, #0
    b .L_end_2117
.L_true_2117:
    mov x0, #1
.L_end_2117:
    cmp x0, #0
    bne .L_true_2116
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2116
    mov x0, #0
    b .L_end_2116
.L_true_2116:
    mov x0, #1
.L_end_2116:
    cmp x0, #0
    bne .L_true_2115
    str x0, [sp, -16]!
    ldr x0, =80
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2115
    mov x0, #0
    b .L_end_2115
.L_true_2115:
    mov x0, #1
.L_end_2115:
    cmp x0, #0
    beq .L_else_2113
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2120
.L_else_2120:
    str x0, [sp, -16]!
    ldr x0, =124
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2122
.L_else_2122:
    str x0, [sp, -16]!
    ldr x0, =83
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2124
.L_else_2124:
    str x0, [sp, -16]!
    ldr x0, =84
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2126
.L_else_2126:
    str x0, [sp, -16]!
    ldr x0, =85
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2128
.L_else_2128:
    str x0, [sp, -16]!
    ldr x0, =80
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2130
.L_else_2130:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2113:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2132
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2132:
    str x0, [sp, -16]!
    ldr x0, =53
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2134
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2134:
    str x0, [sp, -16]!
    ldr x0, =27
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2136
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2138
    cmp x0, #0
    beq .L_else_2140
    b .L_end_2141
.L_else_2140:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2142
    b .L_end_2143
.L_else_2142:
.L_end_2143:
.L_end_2141:
    ldr x0, =0
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2144
    ldr x0, =1
.L_else_2144:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2146
    ldr x0, =1
.L_else_2146:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2148
    ldr x0, =1
.L_else_2148:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2150
    b .L_end_2151
.L_else_2150:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2152
.L_else_2152:
.L_end_2151:
.L_else_2138:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2136:
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2154
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2156
    cmp x0, #0
    beq .L_else_2158
    b .L_end_2159
.L_else_2158:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2160
    b .L_end_2161
.L_else_2160:
.L_end_2161:
.L_end_2159:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2162
    b .L_end_2163
.L_else_2162:
.L_end_2163:
.L_else_2156:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2154:
    str x0, [sp, -16]!
    ldr x0, =25
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2164
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl ZiskejTypUzlu
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2166
    b .L_end_2167
.L_else_2166:
.L_end_2167:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2168
    b .L_end_2169
.L_else_2168:
.L_end_2169:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2164:
    str x0, [sp, -16]!
    ldr x0, =30
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2170
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2172
    b .L_end_2173
.L_else_2172:
.L_end_2173:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2170:
    str x0, [sp, -16]!
    ldr x0, =31
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2174
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2176
    b .L_end_2177
.L_else_2176:
.L_end_2177:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2174:
    str x0, [sp, -16]!
    ldr x0, =20
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2178
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_2180:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_2181
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2184
    str x0, [sp, -16]!
    ldr x0, =100
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2184
    mov x0, #1
    b .L_end_2184
.L_false_2184:
    mov x0, #0
.L_end_2184:
    cmp x0, #0
    beq .L_else_2182
.L_else_2182:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_2180
.L_end_2181:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2185
.L_else_2185:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2187
.L_else_2187:
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2189
.L_else_2189:
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2191
.L_else_2191:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2193
.L_else_2193:
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2195
.L_else_2195:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2197
.L_else_2197:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2199
.L_else_2199:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_false_2203
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2203
    mov x0, #1
    b .L_end_2203
.L_false_2203:
    mov x0, #0
.L_end_2203:
    cmp x0, #0
    beq .L_else_2201
    cmp x0, #0
    beq .L_else_2204
    b .L_end_2205
.L_else_2204:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2206
    b .L_end_2207
.L_else_2206:
.L_end_2207:
.L_end_2205:
    b .L_end_2202
.L_else_2201:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2210
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeExterniJmeno
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2210
    mov x0, #1
    b .L_end_2210
.L_false_2210:
    mov x0, #0
.L_end_2210:
    cmp x0, #0
    beq .L_else_2208
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NazevSymbolu
.L_else_2208:
.L_end_2202:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2178:
    str x0, [sp, -16]!
    ldr x0, =35
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2211
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2213
    cmp x0, #0
    beq .L_else_2215
    b .L_end_2216
.L_else_2215:
    cmp x0, #0
    beq .L_else_2217
    b .L_end_2218
.L_else_2217:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2219
    b .L_end_2220
.L_else_2219:
.L_end_2220:
.L_end_2218:
.L_end_2216:
.L_else_2213:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2211:
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2225
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2225
    mov x0, #0
    b .L_end_2225
.L_true_2225:
    mov x0, #1
.L_end_2225:
    cmp x0, #0
    bne .L_true_2224
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2224
    mov x0, #0
    b .L_end_2224
.L_true_2224:
    mov x0, #1
.L_end_2224:
    cmp x0, #0
    bne .L_true_2223
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2223
    mov x0, #0
    b .L_end_2223
.L_true_2223:
    mov x0, #1
.L_end_2223:
    cmp x0, #0
    beq .L_else_2221
    str x0, [sp, -16]!
    ldr x0, =67
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2226
.L_else_2226:
    str x0, [sp, -16]!
    ldr x0, =44
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2228
.L_else_2228:
    str x0, [sp, -16]!
    ldr x0, =49
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2230
.L_else_2230:
    str x0, [sp, -16]!
    ldr x0, =50
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2232
.L_else_2232:
.L_else_2221:
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2240
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2240
    mov x0, #0
    b .L_end_2240
.L_true_2240:
    mov x0, #1
.L_end_2240:
    cmp x0, #0
    bne .L_true_2239
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2239
    mov x0, #0
    b .L_end_2239
.L_true_2239:
    mov x0, #1
.L_end_2239:
    cmp x0, #0
    bne .L_true_2238
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2238
    mov x0, #0
    b .L_end_2238
.L_true_2238:
    mov x0, #1
.L_end_2238:
    cmp x0, #0
    bne .L_true_2237
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2237
    mov x0, #0
    b .L_end_2237
.L_true_2237:
    mov x0, #1
.L_end_2237:
    cmp x0, #0
    bne .L_true_2236
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2236
    mov x0, #0
    b .L_end_2236
.L_true_2236:
    mov x0, #1
.L_end_2236:
    cmp x0, #0
    beq .L_else_2234
    str x0, [sp, -16]!
    ldr x0, =43
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2241
.L_else_2241:
    str x0, [sp, -16]!
    ldr x0, =64
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2243
.L_else_2243:
    str x0, [sp, -16]!
    ldr x0, =45
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2245
.L_else_2245:
    str x0, [sp, -16]!
    ldr x0, =46
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2247
.L_else_2247:
    str x0, [sp, -16]!
    ldr x0, =61
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2249
.L_else_2249:
    str x0, [sp, -16]!
    ldr x0, =62
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2251
.L_else_2251:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2234:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GenerujAST_ARM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #224
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2253
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2253:
    str x0, [sp, -16]!
    ldr x0, =34
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2255
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =499
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2257
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_pocet_defer
    str x0, [x8]
    b .L_end_2258
.L_else_2257:
.L_end_2258:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2255:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2259
    ldr x0, =0
.L_start_2261:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_2262
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2263
.L_else_2263:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_2261
.L_end_2262:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2259:
    str x0, [sp, -16]!
    ldr x0, =26
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2265
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiByt
    str x0, [sp, -16]!
    ldr x0, =120
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2271
    str x0, [sp, -16]!
    ldr x0, =56
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2271
    mov x0, #1
    b .L_end_2271
.L_false_2271:
    mov x0, #0
.L_end_2271:
    cmp x0, #0
    beq .L_false_2270
    str x0, [sp, -16]!
    ldr x0, =54
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2270
    mov x0, #1
    b .L_end_2270
.L_false_2270:
    mov x0, #0
.L_end_2270:
    cmp x0, #0
    beq .L_false_2269
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2269
    mov x0, #1
    b .L_end_2269
.L_false_2269:
    mov x0, #0
.L_end_2269:
    cmp x0, #0
    beq .L_else_2267
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2267:
    str x0, [sp, -16]!
    ldr x0, =97
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2276
    str x0, [sp, -16]!
    ldr x0, =114
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2276
    mov x0, #1
    b .L_end_2276
.L_false_2276:
    mov x0, #0
.L_end_2276:
    cmp x0, #0
    beq .L_false_2275
    str x0, [sp, -16]!
    ldr x0, =109
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2275
    mov x0, #1
    b .L_end_2275
.L_false_2275:
    mov x0, #0
.L_end_2275:
    cmp x0, #0
    beq .L_false_2274
    str x0, [sp, -16]!
    ldr x0, =58
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2274
    mov x0, #1
    b .L_end_2274
.L_false_2274:
    mov x0, #0
.L_end_2274:
    cmp x0, #0
    beq .L_else_2272
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_else_2272:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2265:
    str x0, [sp, -16]!
    ldr x0, =19
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2277
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2279
    cmp x0, #0
    beq .L_else_2281
    b .L_end_2282
.L_else_2281:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2283
    b .L_end_2284
.L_else_2283:
.L_end_2284:
.L_end_2282:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2285
.L_else_2285:
    ldr x0, =0
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2287
    ldr x0, =1
.L_else_2287:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2289
    ldr x0, =1
.L_else_2289:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2291
    ldr x0, =1
.L_else_2291:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2293
    b .L_end_2294
.L_else_2293:
.L_end_2294:
.L_else_2279:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2277:
    str x0, [sp, -16]!
    ldr x0, =33
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2295
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2297
    cmp x0, #0
    beq .L_else_2299
    b .L_end_2300
.L_else_2299:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2301
    b .L_end_2302
.L_else_2301:
.L_end_2302:
.L_end_2300:
.L_else_2297:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2295:
    str x0, [sp, -16]!
    ldr x0, =17
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2303
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2305
    cmp x0, #0
    beq .L_else_2307
    b .L_end_2308
.L_else_2307:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2309
    b .L_end_2310
.L_else_2309:
.L_end_2310:
.L_end_2308:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2311
    b .L_end_2312
.L_else_2311:
.L_end_2312:
.L_else_2305:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2303:
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2315
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2315
    mov x0, #0
    b .L_end_2315
.L_true_2315:
    mov x0, #1
.L_end_2315:
    cmp x0, #0
    beq .L_else_2313
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2316
    b .L_end_2317
.L_else_2316:
.L_end_2317:
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NajdiSymbol
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2318
    cmp x0, #0
    beq .L_else_2320
    b .L_end_2321
.L_else_2320:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2322
    b .L_end_2323
.L_else_2322:
.L_end_2323:
.L_end_2321:
.L_else_2318:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2313:
    str x0, [sp, -16]!
    ldr x0, =10
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2324
    ldr x0, =0
    ldr x8, =gvar_pocet_ir
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_pocet_defer
    str x0, [x8]
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2328
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl JeExterniJmeno
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2328
    mov x0, #1
    b .L_end_2328
.L_false_2328:
    mov x0, #0
.L_end_2328:
    cmp x0, #0
    beq .L_else_2326
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl NazevSymbolu
.L_else_2326:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2329
    b .L_end_2330
.L_else_2329:
.L_end_2330:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
.L_start_2331:
    str x0, [sp, -16]!
    ldr x0, =15
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_end_2332
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_2331
.L_end_2332:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, gt
    cmp x0, #0
    beq .L_else_2333
.L_else_2333:
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_2335:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_2336
    ldr x8, =gvar_pamet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_2335
.L_end_2336:
    ldr x0, =0
.L_start_2337:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_ir
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_2338
    ldr x8, =gvar_pamet_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =48
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =99
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2339
.L_else_2339:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_2337
.L_end_2338:
    ldr x0, =0
    ldr x8, =gvar_pocet_ir
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2324:
    str x0, [sp, -16]!
    ldr x0, =6
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2341
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2343
.L_else_2343:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2345
.L_else_2345:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2341:
    str x0, [sp, -16]!
    ldr x0, =7
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2347
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    ldr x8, =gvar_citac_navesti
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x8, =gvar_citac_navesti
    str x0, [x8]
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2347:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2349
    ldr x0, =0
.L_start_2351:
    str x0, [sp, -16]!
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_2352
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2353
.L_else_2353:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_2351
.L_end_2352:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2349:
    str x0, [sp, -16]!
    ldr x0, =11
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2355
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2357
.L_else_2357:
    ldr x8, =gvar_pocet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
.L_start_2359:
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_end_2360
    ldr x8, =gvar_pamet_defer
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    lsl x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl CtiUkazatel
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    sub x0, x0, x1
    b .L_start_2359
.L_end_2360:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
.L_else_2355:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

GeneratorASM_ARM:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #48
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl fopen
    ldr x0, =0
.L_start_2361:
    str x0, [sp, -16]!
    ldr x8, =gvar_pocet_symbolu
    ldr x0, [x8]
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_end_2362
    ldr x8, =gvar_pamet_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, =3160
    mov x1, x0
    ldr x0, [sp], 16
    mul x0, x0, x1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2366
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2366
    mov x0, #1
    b .L_end_2366
.L_false_2366:
    mov x0, #0
.L_end_2366:
    cmp x0, #0
    beq .L_false_2365
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_false_2365
    mov x0, #1
    b .L_end_2365
.L_false_2365:
    mov x0, #0
.L_end_2365:
    cmp x0, #0
    beq .L_else_2363
.L_else_2363:
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    b .L_start_2361
.L_end_2362:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2367
.L_else_2367:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2369
.L_else_2369:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2371
.L_else_2371:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2373
.L_else_2373:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2375
    b .L_end_2376
.L_else_2375:
.L_end_2376:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

Hlavni:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    sub sp, sp, #96
    ldr x0, =1032
    str x0, [sp, -16]!
    ldr x0, =500
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_struktur_clenove
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_pocet_struktur_clenu
    str x0, [x8]
    ldr x0, =520
    str x0, [sp, -16]!
    ldr x0, =100
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_struktur_def
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_pocet_struktur_def
    str x0, [x8]
    ldr x0, =3160
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_symbolu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_symbolu
    str x0, [x8]
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x0, =4096
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_hash_tabulka
    str x0, [x8]
    ldr x0, =48
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_ir
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_ir
    str x0, [x8]
    ldr x0, =32
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_intervalu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_intervalu
    str x0, [x8]
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x0, =200
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_loop_label_stack
    str x0, [x8]
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x0, =200
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_loop_continue_stack
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_loop_stack_depth
    str x0, [x8]
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, =200
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_externu
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_pocet_externu
    str x0, [x8]
    ldr x0, =8
    str x0, [sp, -16]!
    ldr x0, =500
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_defer
    str x0, [x8]
    ldr x0, =0
    ldr x8, =gvar_pocet_defer
    str x0, [x8]
    ldr x8, =gvar_sys_argc
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, lt
    cmp x0, #0
    beq .L_else_2377
.L_else_2377:
    ldr x8, =gvar_sys_argv
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =8
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, [x0]
    ldr x8, =gvar_sys_argc
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_2379
    ldr x8, =gvar_sys_argv
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =16
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, [x0]
.L_else_2379:
    ldr x0, =2
    ldr x8, =gvar_cilova_platforma
    str x0, [x8]
    ldr x8, =gvar_sys_argc
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ge
    cmp x0, #0
    beq .L_else_2381
    ldr x8, =gvar_sys_argv
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =24
    mov x1, x0
    ldr x0, [sp], 16
    add x0, x0, x1
    ldr x0, [x0]
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2383
    ldr x0, =0
    ldr x8, =gvar_cilova_platforma
    str x0, [x8]
    b .L_end_2384
.L_else_2383:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2385
    ldr x0, =1
    ldr x8, =gvar_cilova_platforma
    str x0, [x8]
    b .L_end_2386
.L_else_2385:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2387
    ldr x0, =2
    ldr x8, =gvar_cilova_platforma
    str x0, [x8]
    b .L_end_2388
.L_else_2387:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2389
    ldr x0, =3
    ldr x8, =gvar_cilova_platforma
    str x0, [x8]
    b .L_end_2390
.L_else_2389:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2391
    ldr x0, =4
    ldr x8, =gvar_cilova_platforma
    str x0, [x8]
    b .L_end_2392
.L_else_2391:
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl strcmp
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2393
    ldr x0, =5
    ldr x8, =gvar_cilova_platforma
    str x0, [x8]
    b .L_end_2394
.L_else_2393:
.L_end_2394:
.L_end_2392:
.L_end_2390:
.L_end_2388:
.L_end_2386:
.L_end_2384:
.L_else_2381:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2395
    b .L_end_2396
.L_else_2395:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2397
    b .L_end_2398
.L_else_2397:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2399
    b .L_end_2400
.L_else_2399:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2401
    b .L_end_2402
.L_else_2401:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2403
    b .L_end_2404
.L_else_2403:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2405
.L_else_2405:
.L_end_2404:
.L_end_2402:
.L_end_2400:
.L_end_2398:
.L_end_2396:
    ldr x0, =2072
    str x0, [sp, -16]!
    ldr x8, =gvar_kapacita_tokenu
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl calloc
    ldr x8, =gvar_pamet_tokenu
    str x0, [x8]
    bl Parser
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
    ldr x0, =256
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
    ldr x0, =512
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
    ldr x0, =512
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    bl malloc
    ldr x0, =0
    str x0, [sp, -16]!
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    ldr x1, [sp], 16
    bl fopen
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, ne
    cmp x0, #0
    beq .L_else_2407
    ldr x0, =1
    b .L_end_2408
.L_else_2407:
.L_end_2408:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2411
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    bne .L_true_2411
    mov x0, #0
    b .L_end_2411
.L_true_2411:
    mov x0, #1
.L_end_2411:
    cmp x0, #0
    beq .L_else_2409
    b .L_end_2410
.L_else_2409:
.L_end_2410:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2412
    b .L_end_2413
.L_else_2412:
.L_end_2413:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =0
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2414
    b .L_end_2415
.L_else_2414:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2416
    b .L_end_2417
.L_else_2416:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =2
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2418
    b .L_end_2419
.L_else_2418:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =3
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2420
    b .L_end_2421
.L_else_2420:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =4
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2422
    b .L_end_2423
.L_else_2422:
    ldr x8, =gvar_cilova_platforma
    ldr x0, [x8]
    str x0, [sp, -16]!
    ldr x0, =5
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2424
    str x0, [sp, -16]!
    ldr x0, =1
    mov x1, x0
    ldr x0, [sp], 16
    cmp x0, x1
    cset x0, eq
    cmp x0, #0
    beq .L_else_2426
    b .L_end_2427
.L_else_2426:
.L_end_2427:
.L_else_2424:
.L_end_2423:
.L_end_2421:
.L_end_2419:
.L_end_2417:
.L_end_2415:
    ldr x0, =0
    str x0, [sp, -16]!
    ldr x0, [sp], 16
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret
    mov sp, x29
    ldp x29, x30, [sp], 16
    ret

