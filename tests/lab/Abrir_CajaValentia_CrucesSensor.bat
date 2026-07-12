@echo off
net session >nul 2>&1
if not %errorlevel%==0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
set "ROOT=%~dp0CajaValentia_R2011a_CrucesSensor"
cd /d "%ROOT%"
if exist "%ROOT%\resultados\launcher_cruces_sensor.txt" del /q "%ROOT%\resultados\launcher_cruces_sensor.txt"
"C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe" -nosplash -logfile "%ROOT%\resultados\launcher_cruces_sensor.txt" -r "cmc_iniciar_gui_r2011a"
