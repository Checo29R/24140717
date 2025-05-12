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
    xor ecx, ecx                ; Limpiar ecx (índice de filas)
suma_filas_loop:
    xor eax, eax                ; Limpiar eax
    mov ebx, ecx
    imul ebx, 3                 ; Multiplicar por 3 para obtener la dirección de la fila
    add al, [matriz + ebx]
    add al, [matriz + ebx + 1]
    add al, [matriz + ebx + 2]
    mov [suma_filas + ecx], al
    inc ecx
    cmp ecx, 3
    jl suma_filas_loop

    ; Calcular suma de columnas
    xor ecx, ecx                ; Limpiar ecx (índice de columnas)
suma_columnas_loop:
    xor eax, eax                ; Limpiar eax
    add al, [matriz + ecx]
    add al, [matriz + ecx + 3]
    add al, [matriz + ecx + 6]
    mov [suma_columnas + ecx], al
    inc ecx
    cmp ecx, 3
    jl suma_columnas_loop

    ; Calcular diagonales
    xor eax, eax
    add al, [matriz + 0]
    add al, [matriz + 4]
    add al, [matriz + 8]
    mov [suma_diagonal1], al

    xor eax, eax
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
    mov esi, mensaje_si
    call imprimir_cadena
    jmp salir

no_es_magico:
    mov esi, mensaje_no
    call imprimir_cadena

salir:
    mov eax, 1         ; syscall: exit
    xor ebx, ebx       ; código de salida 0
    int 0x80           ; interrupt para la syscall

;-----------------------------------------
; Función para imprimir cadena terminada en 0
imprimir_cadena:
    push eax
    push ebx
    push edx
    push ecx

    mov ebx, esi      ; Usamos ebx en lugar de rdi
    xor ecx, ecx      ; Limpiar ecx para contar la longitud de la cadena
.next_char:
    cmp byte [ebx + ecx], 0
    je .done
    inc ecx
    jmp .next_char
.done:
    mov eax, 4         ; syscall: write
    mov ebx, 1         ; stdout
    mov edx, ecx       ; longitud de la cadena
    int 0x80           ; interrupt para la syscall

    pop ecx
    pop edx
    pop ebx
    pop eax
    ret
