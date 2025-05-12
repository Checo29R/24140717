section .data
    mensaje db "Valor almacenado en la pila: ", 0
    salto db 10, 0

section .bss
    valor resb 1

section .text
    global _start

_start:
    ; Guardar el valor 7 en la pila
    mov al, 7
    push eax          ; Usamos eax, no rax

    ; Sacar el valor de la pila y guardarlo en [valor]
    pop eax           ; Usamos eax, no rax
    mov [valor], al

    ; Mostrar el mensaje
    mov esi, mensaje  ; Cambiar rsi por esi en 32 bits
    call imprimir_cadena

    ; Mostrar el valor (convertido a carácter)
    movzx eax, byte [valor]
    add al, '0'
    mov [valor], al
    mov esi, valor    ; Cambiar rsi por esi
    call imprimir_cadena

    ; Imprimir salto de línea
    mov esi, salto    ; Cambiar rsi por esi
    call imprimir_cadena

    ; Salir del programa
    mov eax, 1         ; syscall: exit
    xor ebx, ebx       ; código de salida 0
    int 0x80           ; interrupción para la syscall

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
    int 0x80           ; interrupción para la syscall

    pop ecx
    pop edx
    pop ebx
    pop eax
    ret
