@echo off
setlocal

rem Abre el menu completo de CajaValentia desde la raiz del repositorio.
net session >nul 2>&1
if not %errorlevel%==0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "ROOT=%~dp0"
set "MATLAB_DIR=%ROOT%matlab"
set "MATLAB_EXE=C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe"
set "LOG_DIR=%MATLAB_DIR%\resultados"
set "LOG_FILE=%LOG_DIR%\launcher_menu.txt"

if not exist "%MATLAB_DIR%\cmc_iniciar_gui_r2011a.m" (
    echo ERROR: No se encontro matlab\cmc_iniciar_gui_r2011a.m.
    echo Revisa que este archivo BAT siga en la raiz del repositorio.
    pause
    exit /b 1
)

if not exist "%MATLAB_EXE%" (
    echo ERROR: No se encontro MATLAB R2011a en:
    echo %MATLAB_EXE%
    pause
    exit /b 1
)

if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
if exist "%LOG_FILE%" del /q "%LOG_FILE%"

cd /d "%MATLAB_DIR%"
"%MATLAB_EXE%" -nosplash -logfile "%LOG_FILE%" -r "cmc_iniciar_gui_r2011a"

endlocal
