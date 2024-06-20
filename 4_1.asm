section .data
    val1 db 10       ; Example value for val1
    msg_ebx db 'ebx = ', 0
    msg_val1 db 'val1 = ', 0
    nl db 10         ; Newline character

section .bss
    output_ebx resb 4  ; Reserve space for the output character of ebx (4 bytes to handle up to "255")
    output_val1 resb 4 ; Reserve space for the output character of val1 (4 bytes to handle up to "255")

section .text
    global _start

_start:
    ; Initialize ebx and val1
    mov ebx, 0        ; Initialize ebx to 0
    mov al, [val1]
    mov bl, al        ; Initialize val1

.loop:
    ; Compare ebx and val1
    cmp ebx, eax
    jg .done         ; If ebx > val1, exit loop

    ; Add 5 to ebx
    add ebx, 5

    ; Subtract 1 from val1
    dec al

    ; Store the updated val1 in the data section
    mov [val1], al

    ; Continue the loop
    jmp .loop

.done:
    ; Prepare to print the value of ebx
    mov eax, ebx
    call print_num
    ; Print the message "ebx = "
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, msg_ebx  ; message to write
    mov edx, 6        ; number of bytes (including null terminator)
    int 0x80          ; call kernel

    ; Print the value of ebx
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, output_ebx ; character to write
    mov edx, 4        ; number of bytes
    int 0x80          ; call kernel

    ; Print a newline
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, nl       ; newline character
    mov edx, 1        ; number of bytes
    int 0x80          ; call kernel

    ; Prepare to print the value of val1
    mov eax, [val1]
    call print_num
    ; Print the message "val1 = "
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, msg_val1 ; message to write
    mov edx, 7        ; number of bytes (including null terminator)
    int 0x80          ; call kernel

    ; Print the value of val1
    mov eax, 4        ; sys_write system call
    mov ebx, 1        ; file descriptor 1 (stdout)
    mov ecx, output_val1 ; character to write
    mov edx, 4        ; number of bytes
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

; Function to print a number in eax as a string
print_num:
    mov ecx, output_val1
    mov ebx, 10
    add ecx, 3
.loop_print:
    xor edx, edx
    div ebx
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz .loop_print
    ret
