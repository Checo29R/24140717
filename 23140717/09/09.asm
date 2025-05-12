section .data
    msg0 db " Dato 1 --> $"
    msg1 db " Dato 2 --> $"
    skip db 0Dh, 0Ah, '$'        ; Salto de línea
    skip1 db "  ", '$'
    msg_mult db " Multiplicacion: $"
    msg_div db " Division: $"
    msg_sum db " Suma: $"

section .bss
    vec1 resb 5                  ; Primer vector (reservamos espacio para 5 bytes)
    vec2 resb 5                  ; Segundo vector (reservamos espacio para 5 bytes)
    vec4 resb 5                  ; Vector resultado de la multiplicación
    vec5 resb 5                  ; Vector resultado de la división
    vec6 resb 5                  ; Vector resultado de la suma
    caracter resb 1              ; Para almacenar un carácter

section .text
    global _start

_start:
    ; Captura el primer vector
    mov ecx, 5                   ; Número de elementos
    mov esi, 0                   ; Índice del vector

ciclo_cap1:
    ; Mostrar mensaje para capturar dato
    mov eax, 4                   ; syscall write
    mov ebx, 1                   ; stdout
    mov ecx, msg0
    mov edx, 13                  ; longitud del mensaje
    int 0x80

    ; Leer un carácter
    mov eax, 3                   ; syscall read
    mov ebx, 0                   ; stdin
    mov ecx, caracter
    mov edx, 1
    int 0x80

    mov al, [caracter]           ; Cargar el valor leído
    cmp al, '0'                  ; Verificar que el valor esté entre '0' y '9'
    jb ciclo_cap1
    cmp al, '9'
    ja ciclo_cap1

    ; Convertir de ASCII a número y almacenar en vec1
    sub al, '0'
    mov [vec1 + esi], al
    inc esi
    loop ciclo_cap1

    ; Captura el segundo vector
    mov ecx, 5                   ; Número de elementos
    mov esi, 0                   ; Índice del vector

ciclo_cap2:
    ; Mostrar mensaje para capturar dato
    mov eax, 4                   ; syscall write
    mov ebx, 1                   ; stdout
    mov ecx, msg1
    mov edx, 13                  ; longitud del mensaje
    int 0x80

    ; Leer un carácter
    mov eax, 3                   ; syscall read
    mov ebx, 0                   ; stdin
    mov ecx, caracter
    mov edx, 1
    int 0x80

    mov al, [caracter]           ; Cargar el valor leído
    cmp al, '0'                  ; Verificar que el valor esté entre '0' y '9'
    jb ciclo_cap2
    cmp al, '9'
    ja ciclo_cap2

    ; Convertir de ASCII a número y almacenar en vec2
    sub al, '0'
    mov [vec2 + esi], al
    inc esi
    loop ciclo_cap2

    ; Operaciones: Multiplicación, División y Suma
    mov ecx, 5                   ; Número de elementos
    mov esi, 0                   ; Índice del vector

ciclo_operaciones:
    ; Cargar valores de vec1 y vec2
    mov al, [vec1 + esi]
    mov bl, [vec2 + esi]

    ; Multiplicación
    imul bl                      ; AL * BL
    mov [vec4 + esi], al         ; Guardar resultado en vec4

    ; División (evitar división entre cero)
    cmp bl, 0
    je no_dividir
    mov ah, 0                    ; Limpiar AH antes de dividir
    div bl                       ; AL / BL
    mov [vec5 + esi], al         ; Guardar resultado en vec5
no_dividir:

    ; Suma
    mov al, [vec1 + esi]
    add al, [vec2 + esi]
    mov [vec6 + esi], al         ; Guardar resultado en vec6

    inc esi
    loop ciclo_operaciones

inicio_2:
    ; Espacio antes de mostrar resultados
    mov ecx, 3
repite:
    mov eax, 4
    mov ebx, 1
    mov ecx, skip
    mov edx, 2
    int 0x80
    loop repite

    ; Mostrar Multiplicación
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mult
    mov edx, 15
    int 0x80

    mov ecx, 5
    mov esi, 0
ciclo_print4:
    mov al, [vec4 + esi]
    add al, '0'                  ; Convertir de número a ASCII
    mov dl, al
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, skip1
    mov edx, 2
    int 0x80

    inc esi
    loop ciclo_print4

    ; Mostrar División
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_div
    mov edx, 11
    int 0x80

    mov ecx, 5
    mov esi, 0
ciclo_print5:
    mov al, [vec5 + esi]
    add al, '0'                  ; Convertir de número a ASCII
    mov dl, al
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, skip1
    mov edx, 2
    int 0x80

    inc esi
    loop ciclo_print5

    ; Mostrar Suma
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_sum
    mov edx, 8
    int 0x80

    mov ecx, 5
    mov esi, 0
ciclo_print6:
    mov al, [vec6 + esi]
    add al, '0'                  ; Convertir de número a ASCII
    mov dl, al
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, skip1
    mov edx, 2
    int 0x80

    inc esi
    loop ciclo_print6

    ; Terminar programa
    mov eax, 1                   ; syscall exit
    xor ebx, ebx                 ; código de salida 0
    int 0x80
