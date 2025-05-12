section .data
    long equ 16
    matriz1 times long dw 0
    matriz2 times long dw 0
    matrizSuma times long dw 0
    matrizResta times long dw 0
    matrizMult times long dw 0
    
    skip db 0dh, 0ah, 0dh, 0ah, '$'
    msg0 db " Dato --> $"
    skip1 db "  ", '$'
    msg1 db "Ingrese la primera matriz:", 0Dh, 0Ah, '$'
    msg2 db "Ingrese la segunda matriz:", 0Dh, 0Ah, '$'
    msg3 db "Matriz suma:", 0Dh, 0Ah, '$'
    msg4 db "Matriz resta:", 0Dh, 0Ah, '$'
    msg5 db "Matriz multiplicacion:", 0Dh, 0Ah, '$'

section .text
    global _start

_start:
    ; Capturar primera matriz
    mov dx, msg1
    mov ah, 09h
    int 21h
    
    mov cx, long
    mov si, 0

ciclo_cap1:
    mov dx, skip
    mov ah, 09h
    int 21h
    
    mov dx, msg0
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '0'
    jb ciclo_cap1
    cmp al, '9'
    ja ciclo_cap1
    
    sub al, '0'
    mov ah, 0
    mov [matriz1 + si], ax
    
    add si, 2
    loop ciclo_cap1

    ; Capturar segunda matriz
    mov dx, msg2
    mov ah, 09h
    int 21h
    
    mov cx, long
    mov si, 0

ciclo_cap2:
    mov dx, skip
    mov ah, 09h
    int 21h
    
    mov dx, msg0
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '0'
    jb ciclo_cap2
    cmp al, '9'
    ja ciclo_cap2
    
    sub al, '0'
    mov ah, 0
    mov [matriz2 + si], ax
    
    add si, 2
    loop ciclo_cap2

    ; Saltos de línea
    mov cx, 3
repite:
    mov dx, skip
    mov ah, 09h
    int 21h
    loop repite

    ; Suma de matrices
    mov dx, msg3
    mov ah, 09h
    int 21h
    
    mov cx, long
    mov si, 0

suma_matrices:
    mov ax, [matriz1 + si]
    add ax, [matriz2 + si]
    mov [matrizSuma + si], ax
    add si, 2
    loop suma_matrices
    
    ; Mostrar matriz suma
    mov cx, long
    mov si, 0

ciclo_print_suma:
    mov ax, [matrizSuma + si]
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    
    mov dx, skip1
    mov ah, 09h
    int 21h
    
    add si, 2
    loop ciclo_print_suma

    ; Resta de matrices
    mov dx, msg4
    mov ah, 09h
    int 21h
    
    mov cx, long
    mov si, 0

resta_matrices:
    mov ax, [matriz1 + si]
    sub ax, [matriz2 + si]
    mov [matrizResta + si], ax
    add si, 2
    loop resta_matrices
    
    ; Mostrar matriz resta
    mov cx, long
    mov si, 0

ciclo_print_resta:
    mov ax, [matrizResta + si]
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    
    mov dx, skip1
    mov ah, 09h
    int 21h
    
    add si, 2
    loop ciclo_print_resta

    ; Multiplicación de matrices (simplificada para este ejemplo)
    mov dx, msg5
    mov ah, 09h
    int 21h
    
    mov cx, long
    mov si, 0

multiplica_matrices:
    mov ax, [matriz1 + si]
    mov bx, [matriz2 + si]
    mul bx
    mov [matrizMult + si], ax
    add si, 2
    loop multiplica_matrices
    
    ; Mostrar matriz multiplicación
    mov cx, long
    mov si, 0

ciclo_print_multiplicacion:
    mov ax, [matrizMult + si]
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h
    
    mov dx, skip1
    mov ah, 09h
    int 21h
    
    add si, 2
    loop ciclo_print_multiplicacion

    ; Terminar programa
    mov ax, 4c00h
    int 21h