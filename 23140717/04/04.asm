section .data
    long equ 5
    vec times long db 0
    skip db 0dh, 0ah, 0dh, 0ah, '$'
    msg0 db " dato --> $"
    skip1 db "  ", '$'

section .text
    global _start

_start:
    mov cx, long
    mov si, 0

ciclo_cap:
    ; Imprimir saltos de línea
    mov dx, skip
    mov ah, 09h
    int 21h
    
    ; Imprimir mensaje
    mov dx, msg0
    mov ah, 09h
    int 21h
    
    ; Leer caracter
    mov ah, 01h
    int 21h
    
    ; Validar que sea dígito
    cmp al, '0'
    jb ciclo_cap
    cmp al, '9'
    ja ciclo_cap
    
    ; Guardar en vector
    mov [vec + si], al
    
    ; Incrementar índice
    inc si
    
    loop ciclo_cap

    ; Imprimir saltos de línea
    mov cx, 3
repite:
    mov dx, skip
    mov ah, 09h
    int 21h
    loop repite
    
    ; Imprimir vector
    mov cx, long
    mov si, 0
    
ciclo_print:
    mov dl, [vec + si]
    mov ah, 02h
    int 21h
    
    mov dx, skip1
    mov ah, 09h
    int 21h
    
    inc si
    loop ciclo_print
    
    ; Terminar programa
    mov ax, 4c00h
    int 21h