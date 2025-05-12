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
    mov rsi, mensaje_impar
    call imprimir_cadena
    jmp salir

es_par:
    mov rsi, mensaje_par
    call imprimir_cadena

salir:
    mov rax, 60     ; syscall: exit
    xor rdi, rdi    ; código de salida 0
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
    mov rax, 1      ; syscall: write
    mov rdi, 1      ; stdout
    mov rsi, rdi
    mov rdx, rcx
    syscall

    pop rcx
    pop rdx
    pop rdi
    pop rax
    ret
