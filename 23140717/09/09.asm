section .data
    long equ 5
    vec1 times long db 0   ; Primer vector
    vec2 times long db 0   ; Segundo vector
    vec4 times long db 0   ; Vector resultado de la multiplicación
    vec5 times long db 0   ; Vector resultado de la división
    vec6 times long db 0   ; Vector resultado de la suma

    skip db 0Dh, 0Ah, '$'
    msg0 db " Dato 1 --> $"
    msg1 db " Dato 2 --> $"
    skip1 db "  ", '$'
    msg_mult db " Multiplicacion: $"
    msg_div db " Division: $"
    msg_sum db " Suma: $"

section .text
    global _start

_start:
    ; Captura el primer vector
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

    mov [vec1 + si], al   ; Guardar el valor en vec1

    inc si
    loop ciclo_cap1

    ; Captura el segundo vector
    mov cx, long
    mov si, 0

ciclo_cap2:
    mov dx, skip
    mov ah, 09h
    int 21h

    mov dx, msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h

    cmp al, '0'
    jb ciclo_cap2
    cmp al, '9'
    ja ciclo_cap2

    mov [vec2 + si], al   ; Guardar el valor en vec2

    inc si
    loop ciclo_cap2

    ; Operaciones: Multiplicación, División y Suma
    mov cx, long
    mov si, 0

ciclo_operaciones:
    mov al, [vec1 + si]    ; Cargar valor de vec1
    sub al, '0'            ; Convertir de ASCII a número
    mov bl, [vec2 + si]    ; Cargar valor de vec2
    sub bl, '0'            ; Convertir de ASCII a número

    ; Multiplicación
    mul bl                 ; Multiplicar AL * BL
    add al, '0'            ; Convertir de número a ASCII
    mov [vec4 + si], al    ; Guardar resultado en vec4

    ; División (evitar división entre cero)
    cmp bl, 0
    je no_dividir
    mov ah, 0              ; Limpiar AH antes de dividir
    div bl                 ; AL / BL
    add al, '0'            ; Convertir de número a ASCII
    mov [vec5 + si], al    ; Guardar resultado en vec5
no_dividir:

    ; Suma
    mov al, [vec1 + si]
    sub al, '0'
    mov bl, [vec2 + si]
    sub bl, '0'
    add al, bl             ; Sumar AL + BL
    add al, '0'            ; Convertir de número a ASCII
    mov [vec6 + si], al    ; Guardar resultado en vec6

    inc si
    loop ciclo_operaciones

inicio_2:
    ; Espacio antes de mostrar resultados
    mov cx, 3
repite:
    mov dx, skip
    mov ah, 09h
    int 21h
    loop repite

    ; Mostrar Multiplicación
    mov dx, msg_mult
    mov ah, 09h
    int 21h

    mov cx, long
    mov si, 0
ciclo_print4:
    mov dl, [vec4 + si]
    mov ah, 02h
    int 21h

    mov dx, skip1
    mov ah, 09h
    int 21h

    inc si
    loop ciclo_print4

    ; Mostrar División
    mov dx, msg_div
    mov ah, 09h
    int 21h

    mov cx, long
    mov si, 0
ciclo_print5:
    mov dl, [vec5 + si]
    mov ah, 02h
    int 21h

    mov dx, skip1
    mov ah, 09h
    int 21h

    inc si
    loop ciclo_print5

    ; Mostrar Suma
    mov dx, msg_sum
    mov ah, 09h
    int 21h

    mov cx, long
    mov si, 0
ciclo_print6:
    mov dl, [vec6 + si]
    mov ah, 02h
    int 21h

    mov dx, skip1
    mov ah, 09h
    int 21h

    inc si
    loop ciclo_print6

    ; Terminar programa
    mov ax, 4c00h
    int 21h