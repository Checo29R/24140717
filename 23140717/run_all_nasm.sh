#!/bin/bash

# Cambiar al directorio donde están los archivos
cd /home/dell/Documents/23140717

# Ejecutar del 01 al 10
for i in {01..10}
do
    echo "=== Compilando y ejecutando ${i}/${i}.asm ==="
    cd $i

    # Ensamblar con NASM
    nasm -f elf32 ${i}.asm -o ${i}.o

    # Enlazar a ejecutable
    if [ -f ${i}.o ]; then
        ld -m elf_i386 -o ${i}.out ${i}.o

        # Ejecutar si se creó correctamente
        if [ -f ${i}.out ]; then
            echo "--- Salida del programa ---"
            ./${i}.out
        else
            echo "!!! Error al enlazar ${i}.o !!!"
        fi
    else
        echo "!!! Error al compilar ${i}.asm !!!"
    fi

    cd ..
    echo
done
