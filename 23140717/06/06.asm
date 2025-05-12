; archivo: matrices_linux.asm

section .bss
    matriz1 resd 16
    matriz2 resd 16
    matrizSuma resd 16
    matrizResta resd 16
    matrizMult resd 16
    buffer resb 8

section .data
   msg1 db "Ingrese la primera matriz:", 10
len_msg1 equ $ - msg1

msg2 db "Ingrese la segunda matriz:", 10
len_msg2 equ $ - msg2

msgSum db "Matriz suma:", 10
len_msgSum equ $ - msgSum

msgRes db "Matriz resta:", 10
len_msgRes equ $ - msgRes

msgMul db "Matriz multiplicacion:", 10
len_msgMul equ $ - msgMul

newline db 0xA, 0

section .text
    global _start

_start:
    ; Imprimir mensaje 1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len_msg1
    int 0x80

    ; Leer 16 enteros para matriz1
    mov ecx, matriz1
    call leer_matriz

    ; Imprimir mensaje 2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len_msg2
    int 0x80

    ; Leer 16 enteros para matriz2
    mov ecx, matriz2
    call leer_matriz

    ; Sumar matrices
    mov esi, matriz1
    mov edi, matriz2
    mov ebx, matrizSuma
    call suma_matrices

    ; Restar matrices
    mov esi, matriz1
    mov edi, matriz2
    mov ebx, matrizResta
    call resta_matrices

    ; Multiplicar matrices
    mov esi, matriz1
    mov edi, matriz2
    mov ebx, matrizMult
    call multiplicar_matrices

    ; Mostrar matrices
    mov eax, 4
    mov ebx, 1
    mov ecx, msgSum
    mov edx, len_msgSum
    int 0x80
    mov ecx, matrizSuma
    call imprimir_matriz

    mov eax, 4
    mov ebx, 1
    mov ecx, msgRes
    mov edx, len_msgRes
    int 0x80
    mov ecx, matrizResta
    call imprimir_matriz

    mov eax, 4
    mov ebx, 1
    mov ecx, msgMul
    mov edx, len_msgMul
    int 0x80
    mov ecx, matrizMult
    call imprimir_matriz

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ============================
; Subrutina: leer_matriz
; Entrada: ecx = dirección donde guardar
; ============================
leer_matriz:
    mov esi, 0
.leer_loop:
    ; Leer línea (scanf simulado)
    mov eax, 3
    mov ebx, 0
    mov edx, 8
    mov edi, buffer
    int 0x80

    ; Convertir a entero (atoi)
    mov edi, buffer
    call atoi
    mov [ecx + esi*4], eax
    inc esi
    cmp esi, 16
    jne .leer_loop
    ret

; ============================
; Subrutina: imprimir_matriz
; Entrada: ecx = dirección de la matriz
; ============================
imprimir_matriz:
    mov esi, 0
.print_loop:
    mov eax, [ecx + esi*4]
    call itoa
    ; Escribir número
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, edi
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    inc esi
    cmp esi, 16
    jne .print_loop
    ret

; ============================
; Subrutina: suma_matrices
; Entrada: esi=mat1, edi=mat2, ebx=resultado
; ============================
suma_matrices:
    mov ecx, 16
.loop:
    mov eax, [esi]
    add eax, [edi]
    mov [ebx], eax
    add esi, 4
    add edi, 4
    add ebx, 4
    loop .loop
    ret

; ============================
; Subrutina: resta_matrices
; ============================
resta_matrices:
    mov ecx, 16
.loop:
    mov eax, [esi]
    sub eax, [edi]
    mov [ebx], eax
    add esi, 4
    add edi, 4
    add ebx, 4
    loop .loop
    ret

; ============================
; Subrutina: multiplicar_matrices (elemento a elemento)
; ============================
multiplicar_matrices:
    mov ecx, 16
.loop:
    mov eax, [esi]
    imul eax, [edi]
    mov [ebx], eax
    add esi, 4
    add edi, 4
    add ebx, 4
    loop .loop
    ret

; ============================
; atoi – convierte string en EDI a entero en EAX
; ============================
atoi:
    xor eax, eax
    xor ebx, ebx
.next:
    mov bl, byte [edi]
    cmp bl, 10
    je .done
    cmp bl, 0
    je .done
    sub bl, '0'
    imul eax, eax, 10
    add eax, ebx
    inc edi
    jmp .next
.done:
    ret

; ============================
; itoa – convierte número en EAX a string en buffer
; ============================
itoa:
    mov edi, buffer
    mov ecx, 0
    mov ebx, 10
    xor edx, edx
.reverse:
    xor edx, edx
    div ebx
    add dl, '0'
    push dx
    inc ecx
    test eax, eax
    jnz .reverse
.write:
    pop dx
    mov [edi], dl
    inc edi
    dec ecx
    jnz .write
    mov byte [edi], 0
    sub edi, buffer
    ret

; ============================
; Longitudes
; ============================
%define len_msg1 39
%define len_msg2 39
%define len_msgSum 14
%define len_msgRes 14
%define len_msgMul 23
