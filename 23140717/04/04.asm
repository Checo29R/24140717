section .data
    prompt db "Ingrese un digito (0-9): ", 0
    newline db 10
    vec times 5 db 0

section .bss
    input resb 2   ; 1 byte para el car�cter, 1 para el salto de l�nea

section .text
    global _start

_start:
    mov ecx, 0              ; �ndice
next_input:
    ; Mostrar mensaje
    mov eax, 4              ; syscall write
    mov ebx, 1              ; stdout
    mov edx, 24             ; longitud del mensaje
    mov ecx, prompt
    int 0x80

    ; Leer car�cter
    mov eax, 3              ; syscall read
    mov ebx, 0              ; stdin
    mov ecx, input
    mov edx, 2              ; leer 2 bytes (car�cter + newline)
    int 0x80

    ; Validar car�cter entre '0' y '9'
    mov al, [input]
    cmp al, '0'
    jb next_input
    cmp al, '9'
    ja next_input

    ; Guardar en el vector
    mov [vec + ecx], al
    inc ecx
    cmp ecx, 5
    jne next_input

    ; Imprimir salto de l�nea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Imprimir vector
    mov ecx, 0
print_loop:
    mov al, [vec + ecx]
    mov [input], al

    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, 1
    int 0x80

    ; imprimir espacio
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    inc ecx
    cmp ecx, 5
    jne print_loop

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
