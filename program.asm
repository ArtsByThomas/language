section .data
    fmt_int db "%d", 10, 0
    fmt_scanf db "%d", 0
    gvar_memory_pool dq 0
    gvar_memory_offset dq 0
    gvar_stack_ptr dq 0
    gvar_stack_arg1 dq 0
    gvar_stack_arg2 dq 0
    gvar_stack_ret dq 0

section .text
    global main
    extern printf
    extern scanf
    extern exit
    extern fopen
    extern fclose
    extern fgetc
    extern fputc

main:
    push rbp
    mov rbp, rsp
    sub rsp, 8192

    xor rax, rax
    mov rsp, rbp
    pop rbp
    xor rcx, rcx
    call exit
_fn_InitAllocator:
    push rbp
    mov rbp, rsp
    sub rsp, 8192
    mov rax, 10000000
    mov qword [rel gvar_memory_pool], rax
    mov rax, 0
    mov qword [rel gvar_memory_offset], rax
    mov rsp, rbp
    pop rbp
    ret
    mov rsp, rbp
    pop rbp
    ret

_fn_custom_malloc:
    push rbp
    mov rbp, rsp
    sub rsp, 8192
    mov rax, 0
    mov qword [rbp - 8], rax
    mov rax, 0
    mov qword [rbp - 16], rax
    mov rax, 0
    mov qword [rbp - 24], rax
    mov rax, 0
    mov qword [rbp - 32], rax
    mov rax, 0
    mov qword [rbp - 40], rax
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 40], rax
    mov rax, [rel gvar_stack_arg1]
    push rax
    mov rax, [rbp - 40]
    pop rbx
    add rax, rbx
    mov qword [rbp - 40], rax
    mov qword [rbp - 32], rax
    mov rax, [rbp - 32]
    mov qword [rbp - 8], rax
.L_start_0:
    mov rax, [rbp - 8]
    push rax
    mov rax, 7
    pop rbx
    cmp rbx, rax
    jle .L_end_0
    mov rax, 8
    push rax
    mov rax, [rbp - 8]
    pop rbx
    sub rax, rbx
    mov qword [rbp - 8], rax
.L_cont_0:
    jmp .L_start_0
.L_end_0:
    mov rax, [rbp - 8]
    push rax
    mov rax, 0
    pop rbx
    cmp rbx, rax
    je .L_end_1
    mov rax, [rbp - 8]
    push rax
    mov rax, 8
    pop rbx
    sub rax, rbx
    mov qword [rbp - 16], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 32]
    pop rbx
    add rax, rbx
    mov qword [rbp - 32], rax
.L_end_1:
    mov rax, [rel gvar_memory_offset]
    push rax
    mov rax, [rel gvar_memory_pool]
    pop rbx
    add rax, rbx
    mov qword [rbp - 24], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rel gvar_memory_offset]
    pop rbx
    add rax, rbx
    mov qword [rel gvar_memory_offset], rax
    mov rax, 0
    mov qword [rbp - 48], rax
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 48], rax
    mov rax, [rel gvar_stack_ret]
    push rax
    mov rax, [rbp - 48]
    pop rbx
    add rax, rbx
    mov qword [rbp - 48], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 48]
    pop rbx
    mov qword [rax], rbx
    mov rsp, rbp
    pop rbp
    ret
    mov rsp, rbp
    pop rbp
    ret

_fn_string_compare:
    push rbp
    mov rbp, rsp
    sub rsp, 8192
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 136], rax
    mov rax, 0
    mov qword [rbp - 64], rax
    mov rax, 0
    mov qword [rbp - 72], rax
    mov qword [rbp - 64], rax
    mov qword [rbp - 72], rax
    mov rax, 0
    mov qword [rbp - 80], rax
    mov rax, 0
    mov qword [rbp - 88], rax
    mov rax, 1
    mov qword [rbp - 96], rax
.L_start_2:
    mov rax, 1
    push rax
    mov rax, 1
    pop rbx
    cmp rbx, rax
    jne .L_end_2
    mov rax, [rbp - 64]
    xor rbx, rbx
    mov bl, byte [rax]
    mov rax, rbx
    mov qword [rbp - 80], rax
    mov rax, [rbp - 72]
    xor rbx, rbx
    mov bl, byte [rax]
    mov rax, rbx
    mov qword [rbp - 88], rax
    mov rax, [rbp - 80]
    push rax
    mov rax, [rbp - 88]
    pop rbx
    cmp rbx, rax
    je .L_end_3
    mov rax, 0
    mov qword [rbp - 96], rax
    jmp .L_end_3
.L_end_3:
    mov rax, [rbp - 80]
    push rax
    mov rax, 0
    pop rbx
    cmp rbx, rax
    jne .L_end_4
    jmp .L_end_4
.L_end_4:
    mov rax, 1
    push rax
    mov rax, [rbp - 64]
    pop rbx
    add rax, rbx
    mov qword [rbp - 64], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 72]
    pop rbx
    add rax, rbx
    mov qword [rbp - 72], rax
.L_cont_2:
    jmp .L_start_2
.L_end_2:
    mov rax, [rbp - 96]
    push rax
    mov rax, [rel gvar_stack_ret]
    push rax
    mov rax, [rbp - 136]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    mov rsp, rbp
    pop rbp
    ret
    mov rsp, rbp
    pop rbp
    ret

_fn_string_copy:
    push rbp
    mov rbp, rsp
    sub rsp, 8192
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 136], rax
    mov rax, 0
    mov qword [rbp - 112], rax
    mov rax, 0
    mov qword [rbp - 120], rax
    mov qword [rbp - 112], rax
    mov qword [rbp - 120], rax
    mov rax, 0
    mov qword [rbp - 128], rax
.L_start_5:
    mov rax, 1
    push rax
    mov rax, 1
    pop rbx
    cmp rbx, rax
    jne .L_end_5
    mov rax, [rbp - 120]
    xor rbx, rbx
    mov bl, byte [rax]
    mov rax, rbx
    mov qword [rbp - 128], rax
    mov rax, [rbp - 128]
    push rax
    mov rax, [rbp - 112]
    pop rbx
    mov byte [rax], bl
    mov rax, [rbp - 128]
    push rax
    mov rax, 0
    pop rbx
    cmp rbx, rax
    jne .L_end_6
    jmp .L_end_6
.L_end_6:
    mov rax, 1
    push rax
    mov rax, [rbp - 120]
    pop rbx
    add rax, rbx
    mov qword [rbp - 120], rax
    mov rax, 1
    push rax
    mov rax, [rbp - 112]
    pop rbx
    add rax, rbx
    mov qword [rbp - 112], rax
.L_cont_5:
    jmp .L_start_5
.L_end_5:
    mov rsp, rbp
    pop rbp
    ret
    mov rsp, rbp
    pop rbp
    ret

_fn_Tokenize:
    push rbp
    mov rbp, rsp
    sub rsp, 8192
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 136], rax
    mov qword [rbp - 144], rax
    mov qword [rbp - 152], rax
    mov rax, 0
    mov qword [rbp - 160], rax
    mov rax, 0
    mov qword [rbp - 168], rax
    mov rax, 51
    mov qword [rbp - 176], rax
.L_start_7:
    mov rax, 1
    push rax
    mov rax, 1
    pop rbx
    cmp rbx, rax
    jne .L_end_7
    mov rax, [rbp - 144]
    mov rcx, rax
    call fgetc
    mov qword [rbp - 168], rax
    mov rax, [rbp - 168]
    push rax
    mov rax, 255
    pop rbx
    cmp rbx, rax
    jne .L_end_8
    jmp .L_end_8
.L_end_8:
    mov rax, [rbp - 168]
    push rax
    mov rax, 45
    pop rbx
    cmp rbx, rax
    jne .L_end_9
    jmp .L_end_9
.L_end_9:
.L_cont_7:
    jmp .L_start_7
.L_end_7:
    mov rax, 264
    push rax
    mov rax, [rbp - 160]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 184], rax
    mov rax, [rbp - 176]
    push rax
    mov rax, [rbp - 184]
    push rax
    mov rax, [rbp - 152]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    mov rax, [rbp - 160]
    push rax
    mov rax, [rel gvar_stack_ret]
    push rax
    mov rax, [rbp - 136]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    mov rsp, rbp
    pop rbp
    ret
    mov rsp, rbp
    pop rbp
    ret

_fn_StartKompilator:
    push rbp
    mov rbp, rsp
    sub rsp, 8192
    call _fn_InitAllocator
    mov rax, 1
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    add rax, rbx
    mov qword [rel gvar_stack_ptr], rax
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 192], rax
    mov rax, 1056000
    push rax
    mov rax, [rel gvar_stack_arg1]
    push rax
    mov rax, [rbp - 192]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    call _fn_custom_malloc
    mov qword [rbp - 200], rax
    mov rax, 1
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    sub rax, rbx
    mov qword [rel gvar_stack_ptr], rax
    mov rax, 1
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    add rax, rbx
    mov qword [rel gvar_stack_ptr], rax
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 192], rax
    mov rax, 1000
    push rax
    mov rax, [rel gvar_stack_arg1]
    push rax
    mov rax, [rbp - 192]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    mov rax, 1050
    push rax
    mov rax, [rel gvar_stack_arg2]
    push rax
    mov rax, [rbp - 192]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    mov rax, 1
    mov qword [rbp - 208], rax
    mov rax, 1
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    sub rax, rbx
    mov qword [rel gvar_stack_ptr], rax
    mov rax, 1
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    add rax, rbx
    mov qword [rel gvar_stack_ptr], rax
    mov rax, 8
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    imul rax, rbx
    mov qword [rbp - 192], rax
    mov rax, [rbp - 208]
    push rax
    mov rax, [rel gvar_stack_arg1]
    push rax
    mov rax, [rbp - 192]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    mov rax, [rbp - 200]
    push rax
    mov rax, [rel gvar_stack_arg2]
    push rax
    mov rax, [rbp - 192]
    pop rbx
    add rax, rbx
    pop rbx
    mov qword [rax], rbx
    call _fn_Tokenize
    mov qword [rbp - 216], rax
    mov rax, 1
    push rax
    mov rax, [rel gvar_stack_ptr]
    pop rbx
    sub rax, rbx
    mov qword [rel gvar_stack_ptr], rax
    mov rax, [rbp - 216]
    lea rcx, [rel fmt_int]
    mov rdx, rax
    xor rax, rax
    call printf
    mov rsp, rbp
    pop rbp
    ret
    mov rsp, rbp
    pop rbp
    ret

