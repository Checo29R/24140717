section .data
    var1 db "Inicia captura ....", 10
    len_var1 equ $ - var1

    var2 db "Termina captura ...", 10
    len_var2 equ $ - var2

    var3 db "Press any to exit ", 10
    len_var3 equ $ - var3

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

loop:
    ; Leer caracter desde stdin
    mov eax, 3          ; syscall read
    mov ebx, 0          ; stdin
    mov ecx, caracter
    mov edx, 1
    int 0x80

    ; Comparar con 'Q' (ASCII 81h)
    mov al, [caracter]
    cmp al, 81h
    jnz loop

fin:
    ; Mostrar mensaje final
    mov eax, 4
    mov ebx, 1
    mov ecx, var2
    mov edx, len_var2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, var3
    mov edx, len_var3
    int 0x80

    ; Esperar cualquier tecla (no es necesario en Linux)
    ; Podemos salir directamente con un mensaje de salida.
    
    ; Terminar programa
    mov eax, 1          ; syscall exit
    xor ebx, ebx        ; código de salida 0
    int 0x80
