section .data
    X db 0        ; Variable to store the result

section .text
    global _start

_start:
    ; Example values for al, bl, and cl
    mov al, 5     ; Set al to 5
    mov bl, 3     ; Set bl to 3
    mov cl, 1     ; Set cl to 1

    ; Compare al and bl
    cmp al, bl
    jle .done     ; If al <= bl, jump to done

    ; Compare bl and cl
    cmp bl, cl
    jle .done     ; If bl <= cl, jump to done

    ; If both conditions are true, set X to 1
    mov byte [X], 1

.done:
    ; Convert X to ASCII
    mov al, [X]
    add al, '0'   ; Convert to ASCII character
    mov [output], al

    ; Print the message "X = "
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, msg  ; message to write
    mov edx, 4    ; number of bytes
    int 0x80      ; call kernel

    ; Print the value of X
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, output ; character to write
    mov edx, 1    ; number of bytes
    int 0x80      ; call kernel

    ; Print a newline
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, nl   ; newline character
    mov edx, 1    ; number of bytes
    int 0x80      ; call kernel

    ; Exit program
    mov eax, 1    ; sys_exit system call
    xor ebx, ebx  ; exit code 0
    int 0x80      ; call kernel

section .data
    msg db 'X = ', 0
    nl db 10      ; Newline character

section .bss
    output resb 1 ; Reserve space for the output character
