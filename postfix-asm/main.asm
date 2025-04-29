.386
.model flat, stdcall
.stack 4096

.data
    expression BYTE "231*+9-"
    stack dw 0
    result DWORD 0

.code
    main PROC
    ; Print the expression string
    mov ah, 09h                    ; DOS function: Print string
    lea dx, expression             ; Load address of the string into DX

    ; Exit the program
    mov ah, 4Ch                    ; DOS function: Exit
    int 21h                        ; Call DOS interrupt 21h to exit
    main ENDP
    
    END main
