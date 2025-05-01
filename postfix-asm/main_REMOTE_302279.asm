.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
INCLUDE kernel32.inc

.data
    expression BYTE "231*+9-", 0
    the_stack DWORD 25 dup(?)
    result DWORD 0
    stack_point DWORD 0

.code
    main PROC
        mov esi, offset expression

    READ_STRING:
        movzx eax, byte ptr [esi]
        cmp al, 0 
        je END_LOOP

        cmp al, '0'
        jl HANDLE_OPERATOR
        cmp al, '9'
        jg HANDLE_OPERATOR

        sub al, '0'
        movzx eax, al
        mov ecx, stack_point
        mov [the_stack + ecx*4], eax
        inc stack_point
        inc esi
        jmp READ_STRING

    HANDLE_OPERATOR:
        dec stack_point
        mov ecx, stack_point
        mov eax, [the_stack + ecx*4] ; first popped value
        dec stack_point
        mov ecx, stack_point
        mov ebx, [the_stack + ecx*4] ; second popped value

        cmp byte ptr [esi], '+'
        je DO_ADD
        cmp byte ptr [esi], '-'
        je DO_SUB
        cmp byte ptr [esi], '*'
        je DO_MUL
        jmp INVALID_OP

    INVALID_OP:
        jmp END_LOOP

    DO_ADD:
        add ebx, eax
        jmp PUSH_RESULT

    DO_SUB:
        sub ebx, eax
        jmp PUSH_RESULT
            
    DO_MUL:
        imul ebx, eax
        jmp PUSH_RESULT

    PUSH_RESULT:
        mov ecx, stack_point
        mov [the_stack + ecx*4], ebx
        inc stack_point
        inc esi
        jmp READ_STRING

    END_LOOP:
        dec stack_point
        mov ecx, stack_point
        mov eax, [the_stack + ecx*4]
        mov result, eax
        
        INVOKE ExitProcess, 0
    main ENDP

END main
