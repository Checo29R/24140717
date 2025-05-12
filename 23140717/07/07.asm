section .data
    var1 db 0Dh, 0Ah, 'Inicia captura ..', 0Dh, 0Ah, '$'
    var2 db 0Dh, 0Ah, 'Fin    captura ..', '$'

section .text
    global _start

_start:
    ; Mostrar mensaje inicial
    mov dx, var1
    mov ah, 09h
    int 21h

loop:
    ; Leer caracter
    mov ah, 01h
    int 21h
    mov bl, al
    
    ; Comparar con Enter (13)
    cmp bl, 13
    jne loop
    jmp fin

fin:
    ; Mostrar mensaje final
    mov dx, var2
    mov ah, 09h
    int 21h
    
    ; Terminar programa
    mov ax, 4c00h
    int 21h