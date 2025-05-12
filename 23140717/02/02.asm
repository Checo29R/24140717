section .data
    mensaje_par     db "El numero es par", 10, 0
    mensaje_impar   db "El numero es impar", 10, 0

section .bss

section .text
    global _start

_start:
    ; Supongamos que el número a evaluar es 6
    mov al, 6

    ; Verificamos si es par o impar
    and al, 1
    cmp al, 0
    je es_par

es_impar:
    mov esi, mensaje_impar     ; Usamos esi en lugar de rsi
    call imprimir_cadena
    jmp salir

es_par:
    mov esi, mensaje_par       ; Usamos esi en lugar de rsi
    call imprimir_cadena

salir:
    mov eax, 1         ; syscall: exit
    xor ebx, ebx       ; código de salida 0
    int 0x80           ; interrupt para la syscall

;-----------------------------------------
; Función: imprimir_cadena
; Entrada: ESI -> dirección de cadena ASCII terminada en 0
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
