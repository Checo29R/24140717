section .data
    msg1 db 0Dh, 0Ah, 0Dh, 0Ah, 'lee seis digitos y lo inserta', '$'
    msg2 db 0Dh, 0Ah, 0Dh, 0Ah, 'luego los extrae en el orden LIFO', '$'
    msg3 db 0Dh, 0Ah, 0Dh, 0Ah, 'ingrese valor unario (0 <= x <= 9)----> ', '$'
    msg4 db 0Dh, 0Ah, 0Dh, 0Ah, 'impresion de datos ', 0Dh, 0Ah, 0Dh, 0Ah, '$'
    msg5 db '     ', '$'

section .text
    global _start

_start:
    ; Mostrar mensajes iniciales
    mov dx, msg1
    mov ah, 09h
    int 21h
    
    mov dx, msg2
    mov ah, 09h
    int 21h
    
    ; Leer 6 dígitos
    mov cl, 6
    
ciclo1:
    mov dx, msg3
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '0'
    jb ciclo1
    
    cmp al, '9'
    ja ciclo1
    
    push ax
    
    loop ciclo1
    
    ; Mostrar mensaje de impresión
    mov dx, msg4
    mov ah, 09h
    int 21h
    
    ; Extraer y mostrar los 6 dígitos en orden LIFO
    mov cl, 6
ciclo2:
    mov dx, msg5
    mov ah, 09h
    int 21h
    
    pop bx
    mov dl, bl
    mov ah, 02h
    int 21h
    
    loop ciclo2
    
    ; Terminar programa
    mov ax, 4c00h
    int 21h