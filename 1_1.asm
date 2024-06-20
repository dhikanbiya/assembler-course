section .data
    var1 db 11     ; Example value for var1
    var2 db 9      ; Example value for var2
    var3 db 0      ; Variable to store the result
    var4 db 0      ; Another variable to store the result if needed
    msg_var3 db 'var3 = ', 0  ; Message for var3
    msg_var4 db 'var4 = ', 0  ; Message for var4

section .bss
    output_var3 resb 1  ; Reserve space for the output character of var3
    output_var4 resb 1  ; Reserve space for the output character of var4

section .text
    global _start

_start:
    ; Load variables into registers
    mov al, [var1]
    mov bl, [var2]

    ; Compare var1 and var2
    cmp al, bl
    jle .less_equal

    ; If var1 > var2
    ; Set var3 = 6
    mov byte [var3], 6
    ; Set var4 = 7
    mov byte [var4], 7
    jmp .done

.less_equal:
    ; If var1 <= var2
    ; Set var3 = 10
    mov byte [var3], 10

.done:
    ; Convert var3 to ASCII and store in output_var3
    mov al, [var3]
    add al, '0'  ; Convert to ASCII character
    mov [output_var3], al

    ; Print the message "var3 = "
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, msg_var3   ; message to write
    mov edx, 7          ; number of bytes (including null terminator)
    int 0x80            ; call kernel

    ; Print the value of var3
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, output_var3 ; character to write
    mov edx, 1          ; number of bytes
    int 0x80            ; call kernel

    ; Print a newline
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, nl         ; newline character
    mov edx, 1          ; number of bytes
    int 0x80            ; call kernel

    ; Check if var4 was set (only if var1 > var2)
    cmp byte [var4], 0
    je .exit            ; If var4 is 0, skip printing var4

    ; Convert var4 to ASCII and store in output_var4
    mov al, [var4]
    add al, '0'  ; Convert to ASCII character
    mov [output_var4], al

    ; Print the message "var4 = "
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, msg_var4   ; message to write
    mov edx, 7          ; number of bytes (including null terminator)
    int 0x80            ; call kernel

    ; Print the value of var4
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, output_var4 ; character to write
    mov edx, 1          ; number of bytes
    int 0x80            ; call kernel

    ; Print a newline
    mov eax, 4          ; sys_write system call
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, nl         ; newline character
    mov edx, 1          ; number of bytes
    int 0x80            ; call kernel

.exit:
    ; Exit program
    mov eax, 1          ; sys_exit system call
    xor ebx, ebx        ; exit code 0
    int 0x80            ; call kernel

section .data
    nl db 10  ; Newline character
