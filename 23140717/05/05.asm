section .data
    color db 1

section .text
    global _start

_start:
    call main
    mov ax, 4c00h
    int 21h

main:
    call inicio
    call bucle1
    call final
    ret

inicio:
    mov cx, 1
    mov al, 13h
    mov ah, 0
    int 10h
    ret

bucle1:
    mov dx, cx
    mov al, [color]
    mov ah, 0ch
    int 10h
    cmp cx, 200
    jz fin
    ret

final:
    inc cx
    add byte [color], 2
    jmp bucle1

fin:
    ret