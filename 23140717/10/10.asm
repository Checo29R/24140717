section .data
    msg1 db 0Dh, 0Ah, 0Dh, 0Ah, 'lee seis digitos y lo inserta', '$'
    msg2 db 0Dh, 0Ah, 0Dh, 0Ah, 'luego los extrae en el orden LIFO', '$'
    msg3 db 0Dh, 0Ah, 0Dh, 0Ah, 'ingrese valor unario (0 <= x <= 9)----> ', '$'
    msg4 db 0Dh, 0Ah, 0Dh, 0Ah, 'impresion de datos ', 0Dh, 0Ah, 0Dh, 0Ah, '$'
    msg5 db '     ', '$'

section .bss
    caracter resb 1

section .text
    global _start

_start:
    ; Mostrar mensajes iniciales
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg1
    mov edx, 28         ; longitud del mensaje
    int 0x80

    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg2
    mov edx, 37         ; longitud del mensaje
    int 0x80
    
    ; Leer 6 d�gitos
    mov ecx, 6          ; N�mero de d�gitos a leer
    mov esi, 0          ; �ndice para el almacenamiento de los d�gitos

ciclo1:
    ; Mostrar mensaje para capturar dato
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg3
    mov edx, 38         ; longitud del mensaje
    int 0x80

    ; Leer un caracter
    mov eax, 3          ; syscall read
    mov ebx, 0          ; stdin
    mov ecx, caracter
    mov edx, 1
    int 0x80

    mov al, [caracter]  ; Cargar el valor le�do
    cmp al, '0'         ; Verificar que el valor est� entre '0' y '9'
    jb ciclo1
    cmp al, '9'
    ja ciclo1

    push ax             ; Almacenar el valor en la pila
    inc esi
    loop ciclo1

    ; Mostrar mensaje de impresi�n
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg4
    mov edx, 21         ; longitud del mensaje
    int 0x80

    ; Extraer y mostrar los 6 d�gitos en orden LIFO
    mov ecx, 6          ; N�mero de d�gitos
    mov esi, 0          ; �ndice

ciclo2:
    ; Mostrar espacio
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg5
    mov edx, 5          ; longitud del mensaje
    int 0x80

    pop bx              ; Extraer el valor de la pila
    mov dl, bl          ; Poner el valor en DL
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov edx, 1
    int 0x80            ; Imprimir el valor

    ; Imprimir salto de l�nea
    mov eax, 4          ; syscall write
    mov ebx, 1          ; stdout
    mov ecx, msg5
    mov edx, 1          ; longitud del salto de l�nea
    int 0x80

    loop ciclo2

    ; Terminar programa
    mov eax, 1          ; syscall exit
    xor ebx, ebx        ; c�digo de salida 0
    int 0x80
