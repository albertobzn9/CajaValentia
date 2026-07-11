@echo off
net session >nul 2>&1
if not %errorlevel%==0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
set "ROOT=%~dp0CajaValentia_R2011a_RC3"
cd /d "%ROOT%"
"C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe" -nosplash -logfile "%ROOT%\resultados\launcher_prueba_sonido_solo.txt" -r "try, cmc_prepara_entorno_r2011a; cmc_prueba_fisica_sonido_solo_discriminacion; catch ME, disp(ME.message); end; exit"
