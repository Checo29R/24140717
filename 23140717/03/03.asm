section .data
    matriz db 2,7,6, 9,5,1, 4,3,8     ; Cuadro mágico clásico 3x3
    mensaje_si db "Es un cuadro magico", 10, 0
    mensaje_no db "No es un cuadro magico", 10, 0

section .bss
    suma_filas resb 3
    suma_columnas resb 3
    suma_diagonal1 resb 1
    suma_diagonal2 resb 1

section .text
    global _start

_start:
    ; Calcular suma de filas
    xor rcx, rcx
suma_filas_loop:
    xor rax, rax
    mov rbx, rcx
    imul rbx, 3
    add al, [matriz + rbx]
    add al, [matriz + rbx + 1]
    add al, [matriz + rbx + 2]
    mov [suma_filas + rcx], al
    inc rcx
    cmp rcx, 3
    jl suma_filas_loop

    ; Calcular suma de columnas
    xor rcx, rcx
suma_columnas_loop:
    xor rax, rax
    add al, [matriz + rcx]
    add al, [matriz + rcx + 3]
    add al, [matriz + rcx + 6]
    mov [suma_columnas + rcx], al
    inc rcx
    cmp rcx, 3
    jl suma_columnas_loop

    ; Calcular diagonales
    xor rax, rax
    add al, [matriz + 0]
    add al, [matriz + 4]
    add al, [matriz + 8]
    mov [suma_diagonal1], al

    xor rax, rax
    add al, [matriz + 2]
    add al, [matriz + 4]
    add al, [matriz + 6]
    mov [suma_diagonal2], al

    ; Verificar si todos los valores son iguales
    mov al, [suma_filas]
    cmp [suma_filas+1], al
    jne no_es_magico
    cmp [suma_filas+2], al
    jne no_es_magico
    cmp [suma_columnas], al
    jne no_es_magico
    cmp [suma_columnas+1], al
    jne no_es_magico
    cmp [suma_columnas+2], al
    jne no_es_magico
    cmp [suma_diagonal1], al
    jne no_es_magico
    cmp [suma_diagonal2], al
    jne no_es_magico

es_magico:
    mov rsi, mensaje_si
    call imprimir_cadena
    jmp salir

no_es_magico:
    mov rsi, mensaje_no
    call imprimir_cadena

salir:
    mov rax, 60     ; syscall: exit
    xor rdi, rdi
    syscall

;-----------------------------------------
; Función para imprimir cadena terminada en 0
imprimir_cadena:
    push rax
    push rdi
    push rdx
    push rcx

    mov rdi, rsi
    xor rcx, rcx
.next_char:
    cmp byte [rdi + rcx], 0
    je .done
    inc rcx
    jmp .next_char
.done:
    mov rax, 1
    mov rdi, 1
    mov rsi, rdi
    mov rdx, rcx
    syscall

    pop rcx
    pop rdx
    pop rdi
    pop rax
    ret
