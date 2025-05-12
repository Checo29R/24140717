; archivo: captura_linux.asm
section .data
    var1 db "Inicia captura ..", 10
    len_var1 equ $ - var1

    var2 db "Fin    captura ..", 10
    len_var2 equ $ - var2

section .bss
    caracter resb 1

section .text
    global _start

_start:
    ; Mostrar mensaje inicial
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, var1
    mov edx, len_var1
    int 0x80

leer_caracter:
    ; Leer caracter desde stdin
    mov eax, 3          ; syscall read
    mov ebx, 0          ; stdin
    mov ecx, caracter
    mov edx, 1
    int 0x80

    ; Revisar si es ENTER (ASCII 10 en Linux)
    mov al, [caracter]
    cmp al, 10
    jne leer_caracter

fin:
    ; Mostrar mensaje final
    mov eax, 4
    mov ebx, 1
    mov ecx, var2
    mov edx, len_var2
    int 0x80

    ; Terminar programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
