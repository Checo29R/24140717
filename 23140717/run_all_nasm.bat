@echo off
setlocal

REM Cambiar al directorio donde están las carpetas
cd /d "C:\Users\DELL\Documents\23140717"

REM Ejecutar del 01 al 10
for %%i in (01 02 03 04 05 06 07 08 09 10) do (
    echo === Compilando y ejecutando %%i\%%i.asm ===
    cd %%i

    REM Ensamblar con NASM a formato objeto
    nasm -f win32 %%i.asm -o %%i.obj

    REM Enlazar a ejecutable
    if exist %%i.obj (
        ld -m i386pe -o %%i.exe %%i.obj

        REM Ejecutar si se creó correctamente
        if exist %%i.exe (
            echo --- Salida del programa ---
            %%i.exe
        ) else (
            echo !!! Error al enlazar %%i.obj !!!
        )
    ) else (
        echo !!! Error al compilar %%i.asm !!!
    )

    cd ..
    echo.
)

endlocal
pause
