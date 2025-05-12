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
    push rax

    ; Sacar el valor de la pila y guardarlo en [valor]
    pop rax
    mov [valor], al

    ; Mostrar el mensaje
    mov rsi, mensaje
    call imprimir_cadena

    ; Mostrar el valor (convertido a carácter)
    movzx rax, byte [valor]
    add al, '0'
    mov [valor], al
    mov rsi, valor
    call imprimir_cadena

    ; Imprimir salto de línea
    mov rsi, salto
    call imprimir_cadena

    ; Salir del programa
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; código de salida 0
    syscall

;-----------------------------------------
; Función: imprimir_cadena
; Entrada: RSI -> dirección de cadena ASCII terminada en 0
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
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rdx, rcx        ; longitud
    syscall

    pop rcx
    pop rdx
    pop rdi
    pop rax
    ret
