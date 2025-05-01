    ; REQUIRES MASM-32 SDK

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
    expression BYTE "231*+9-", 0
    ; expression BYTE "92*", 0
    the_stack DWORD 25 dup(?)
    result DWORD 0
    stack_point DWORD 0

    buffer db 32 dup(0)
    fmtStr db "%d", 0

    consoleHandle DWORD ?
    messageSize DWORD ?
    bytesWritten DWORD ?

.code
    main PROC
        STD_OUTPUT_HANDLE EQU -11

        invoke GetStdHandle, STD_OUTPUT_HANDLE
        mov consoleHandle, eax
        mov esi, offset expression

    READ_STRING:
        movzx eax, byte ptr [esi]  ; Load next character
        cmp al, 0 
        je END_LOOP

        cmp al, '0'
        jl HANDLE_OPERATOR
        cmp al, '9'
        jg HANDLE_OPERATOR

        ; Handle digit
        sub al, '0'     ; convert from ascii
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

        ; Determine which operation to perform
        cmp byte ptr [esi], '+'
        je DO_ADD
        cmp byte ptr [esi], '-'
        je DO_SUB
        cmp byte ptr [esi], '*'
        je DO_MUL
        jmp INVALID_OP

    INVALID_OP:
        ; handle invalid operator
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
        
    ; Convert result to string
    invoke wsprintf, addr buffer, addr fmtStr, result

    invoke lstrlen, addr buffer
    mov messageSize, eax

    ; write to console
    INVOKE WriteConsole,
        consoleHandle,
        ADDR buffer,
        messageSize,
        ADDR bytesWritten,
        0

    INVOKE ExitProcess, 0
    main ENDP

END main
