@echo off
setlocal

rem Este lanzador se ejecuta como el usuario normal del laboratorio.
rem Debe vivir dentro de la carpeta desplegada en el Escritorio.
set "ROOT=%~dp0"
set "MATLAB_EXE=C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe"

if not exist "%ROOT%abrir1.m" (
    echo ERROR: abrir1.m no se encontro junto a este lanzador.
    pause
    exit /b 1
)

if not exist "%MATLAB_EXE%" (
    echo ERROR: No se encontro MATLAB R2011a en:
    echo %MATLAB_EXE%
    pause
    exit /b 1
)

if not exist "%ROOT%resultados" mkdir "%ROOT%resultados"
cd /d "%ROOT%"
"%MATLAB_EXE%" -nosplash -logfile "%ROOT%resultados\launcher_menu.txt" -r "cmc_iniciar_gui_r2011a"
endlocal
