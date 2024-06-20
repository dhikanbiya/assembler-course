section .data
    num db -5 ;nomer yang akan di cek
    result db 0 ; variabel untuk menyimpan hasil dari pengecekan
    output db 'Result: ',0 ; untuk mencetak hasil akhir
    newline db 10 ; 10 adalah karakter ASCII untuk newline

section .bss
    buffer resb 1 ; untuk menyimpan karakter yang ditampilkan pada layar

section .text
    global _start

_start:
    mov al, [num] ; load num ke al

    ;cek apabila nomer = 0
    cmp al,0
    je is_zero

    ;cek apabila nomer positif
    cmp al, 0
    jg is_positive

    ;else
    jmp is_negative

is_zero:
    mov byte [buffer], 'Z' ;simpan Z untuk nilai 0
    jmp print_result

is_positive:
    mov byte[buffer], 'P' ;simpan P untuk nilai positif
    jmp print_result

is_negative:
    mov byte[buffer], 'N' ;simpan N untuk nilai negatif
    jmp print_result

print_result:
   ; Print the "Result: " message
    mov eax, 1              ; syscall: write
    mov edi, 1              ; file descriptor: stdout
    lea rsi, [output]       ; pointer to message
    mov edx, 8              ; message length
    syscall

    ; Print the result character
    mov eax, 1              ; syscall: write
    mov edi, 1              ; file descriptor: stdout
    lea rsi, [buffer]       ; pointer to buffer
    mov edx, 1              ; buffer length
    syscall

    ; Print the newline character
    mov eax, 1              ; syscall: write
    mov edi, 1              ; file descriptor: stdout
    lea rsi, [newline]      ; pointer to newline character
    mov edx, 1              ; length of newline character
    syscall

    ; Exit the program
    mov eax, 60             ; syscall: exit
    xor edi, edi            ; status: 0
    syscall