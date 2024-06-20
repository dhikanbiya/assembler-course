section .data
    op1 db 10   ; Example operand 1
    op2 db 10   ; Example operand 2
    X   db 0    ; Variable to store the result
    msg db 'X = ', 0  ; Message to be printed

section .bss
    output resb 1  ; Reserve space for the output character

section .text
    global _start

_start:
    ; Load operands into registers
    mov al, [op1]
    mov bl, [op2]

    ; Compare op1 and op2
    cmp al, bl
    jne .not_equal

    ; If equal, set X to 1
    mov byte [X], 1
    jmp .done

.not_equal:
    ; If not equal, set X to 2
    mov byte [X], 2

.done:
    ; Convert the result to ASCII
    mov al, [X]
    add al, '0'  ; Convert to ASCII character
    mov [output], al

    ; Print the message "X = "
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, msg        ; message to write
    mov edx, 4          ; number of bytes
    int 0x80            ; call kernel

    ; Print the value of X
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, output     ; character to write
    mov edx, 1          ; number of bytes
    int 0x80            ; call kernel

    ; Print a newline
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, nl         ; newline character
    mov edx, 1          ; number of bytes
    int 0x80            ; call kernel

    ; Exit program
    mov eax, 1          ; sys_exit system call
    xor ebx, ebx        ; exit code 0
    int 0x80            ; call kernel

section .data
    nl db 10  ; Newline character
