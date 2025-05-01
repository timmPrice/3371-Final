.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
     expression BYTE "231*+9-", 0       ; expression to-be evaluated
    the_stack DWORD 25 dup(?)           ; memory for stack implementation
    result DWORD 0                      ; result
    stack_point DWORD 0                 ; stack-pointer for stack impl.
    loopCounter DWORD 100000

.code
    loopMain PROC
        mov esi, offset expression      

    READ_STRING:
        movzx eax, byte ptr [esi]       ; mov first char into eax
        cmp al, 0                       ; if char is 0 (null terminator)
        je END_LOOP                     ;      \ it was the last char

        cmp al, '0'                     ; if al < 0
        jl HANDLE_OPERATOR              ;      \ al is not a digit
        cmp al, '9'                     ; if al > 9
        jg HANDLE_OPERATOR              ;      \ al is not a digit


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
        
    loopMain ENDP

    main PROC
        mov ecx, loopCounter      ; Set loop count to 100,000
        LOOP_START:
                CALL loopMain
                dec ecx
                jnz LOOP_START            
                INVOKE ExitProcess, 0
    main ENDP

    END main 
