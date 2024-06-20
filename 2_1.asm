section .data

section .text
    global _start

_start:
    ; Example values for ebx, ecx, and edx
    mov ebx, 3     ; Set ebx to 3
    mov ecx, 4     ; Set ecx to 4
    mov edx, 2     ; Set edx to 2

    ; Compare ebx and ecx
    cmp ebx, ecx
    jg .done     ; If ebx > ecx, jump to done

    ; Compare ecx and edx
    cmp ecx, edx
    jle .done    ; If ecx <= edx, jump to done

    ; If both conditions are true, set eax to 5 and edx to 6
    mov eax, 5
    mov edx, 6

.done:
    ; Prepare to print the value of eax and edx
    ; Convert eax to ASCII and store in output_eax
    mov ebx, eax
    add ebx, '0'  ; Convert to ASCII character
    mov [output_eax], bl

    ; Convert edx to ASCII and store in output_edx
    mov ebx, edx
    add ebx, '0'  ; Convert to ASCII character
    mov [output_edx], bl

    ; Print the message "eax = "
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, msg_eax  ; message to write
    mov edx, 6    ; number of bytes (including null terminator)
    int 0x80      ; call kernel

    ; Print the value of eax
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, output_eax ; character to write
    mov edx, 1    ; number of bytes
    int 0x80      ; call kernel

    ; Print a newline
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, nl   ; newline character
    mov edx, 1    ; number of bytes
    int 0x80      ; call kernel

    ; Print the message "edx = "
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, msg_edx  ; message to write
    mov edx, 6    ; number of bytes (including null terminator)
    int 0x80      ; call kernel

    ; Print the value of edx
    mov eax, 4    ; sys_write system call
    mov ebx, 1    ; file descriptor 1 (stdout)
    mov ecx, output_edx ; character to write
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
    msg_eax db 'eax = ', 0
    msg_edx db 'edx = ', 0
    nl db 10      ; Newline character

section .bss
    output_eax resb 1 ; Reserve space for the output character of eax
    output_edx resb 1 ; Reserve space for the output character of edx
