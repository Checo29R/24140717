section .data
    var1 db 0Dh, 0Ah, 0Dh, 0Ah, 'Inicia captura ....', 0Dh, 0Ah, 0Dh, 0Ah, '$'
    var2 db 0Dh, 0Ah, 0Dh, 0Ah, 'Termina captura ...', 0Dh, 0Ah, 0Dh, 0Ah, '$'
    var3 db 0Dh, 0Ah, 0Dh, 0Ah, 'Press any to exit ', '$'

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
    
    ; Comparar con 'Q' (51h)
    cmp bl, 51h
    jnz loop

fin:
    ; Mostrar mensajes finales
    mov dx, var2
    mov ah, 09h
    int 21h
    
    mov dx, var3
    mov ah, 09h
    int 21h
    
    ; Esperar tecla
    mov ah, 00h
    int 16h
    
    ; Terminar programa
    mov ax, 4c00h
    int 21h