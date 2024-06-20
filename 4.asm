section .data
    sum db 0          ; Variable to store the sum
    msg db 'Sum = ', 0
    nl db 10          ; Newline character

section .bss
    output resb 1     ; Reserve space for the output character

section .text
    global _start

_start:
    ; Initialize sum and counter
    mov eax, 0        ; Clear eax register (used for sum)
    mov ecx, 1        ; Initialize counter to 1

.loop:
    ; Add counter to sum
    add eax, ecx

    ; Increment counter
    inc ecx

    ; Check if counter is greater than 5
    cmp ecx, 6
    jle .loop         ; If counter <= 5, repeat loop

    ; Store the result in the sum variable
    mov [sum], al

    ; Convert sum to ASCII
    mov al, [sum]
    add al, '0'       ; Convert to ASCII character
    mov [output], al

    ; Print the message "Sum = "
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, msg      ; message to write
    mov edx, 6        ; number of bytes (including null terminator)
    int 0x80          ; call kernel

    ; Print the value of sum
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, output   ; character to write
    mov edx, 1        ; number of bytes
    int 0x80          ; call kernel

    ; Print a newline
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, nl       ; newline character
    mov edx, 1        ; number of bytes
    int 0x80          ; call kernel

    ; Exit program
    mov eax, 1        ; sys_exit system call
    xor ebx, ebx      ; exit code 0
    int 0x80          ; call kernel
