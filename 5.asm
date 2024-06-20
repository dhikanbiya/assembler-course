section .data
    lookup_table dd value1, offset label1
                 dd value2, offset label2
                 dd value3, offset label3
                 dd 0, 0              ; End of table marker

    value1 dd 1
    value2 dd 2
    value3 dd 3

    search_value dd 2                 ; Value we are searching for

section .bss

section .text
    global _start

_start:
    mov esi, lookup_table             ; Point ESI to the start of the lookup table

.loop:
    mov eax, [esi]                    ; Load the value from the table
    cmp eax, 0                        ; Check for end of table marker
    je .not_found                     ; If end of table, jump to not_found

    cmp eax, [search_value]           ; Compare table value with search_value
    je .found                         ; If match, jump to found

    add esi, 8                        ; Move to the next entry in the table (4 bytes for value + 4 bytes for offset)
    jmp .loop                         ; Repeat the loop

.found:
    mov ebx, [esi + 4]                ; Load the offset of the corresponding label
    call ebx                          ; Call the label

    jmp .exit                         ; Exit after label execution

.not_found:
    ; Handle case where value is not found
    ; Print message or perform any other action here

.exit:
    ; Exit program
    mov eax, 1                        ; sys_exit system call
    xor ebx, ebx                      ; exit code 0
    int 0x80                          ; call kernel

label1:
    ; Code for label1
    ; You can print a message or perform actions specific to label1 here
    mov eax, 4                        ; sys_write system call
    mov ebx, 1                        ; file descriptor 1 (stdout)
    mov ecx, msg1                     ; message to write
    mov edx, msg1_len                 ; number of bytes
    int 0x80                          ; call kernel
    ret

label2:
    ; Code for label2
    ; You can print a message or perform actions specific to label2 here
    mov eax, 4                        ; sys_write system call
    mov ebx, 1                        ; file descriptor 1 (stdout)
    mov ecx, msg2                     ; message to write
    mov edx, msg2_len                 ; number of bytes
    int 0x80                          ; call kernel
    ret

label3:
    ; Code for label3
    ; You can print a message or perform actions specific to label3 here
    mov eax, 4                        ; sys_write system call
    mov ebx, 1                        ; file descriptor 1 (stdout)
    mov ecx, msg3                     ; message to write
    mov edx, msg3_len                 ; number of bytes
    int 0x80                          ; call kernel
    ret

section .data
    msg1 db 'Label 1 executed', 0
    msg1_len equ $ - msg1

    msg2 db 'Label 2 executed', 0
    msg2_len equ $ - msg2

    msg3 db 'Label 3 executed', 0
    msg3_len equ $ - msg3
