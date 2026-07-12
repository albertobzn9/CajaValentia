@echo off
rem Ejecutar como usuario normal: no autoelevar a administrador.
set "ROOT=%~dp0CajaValentia_R2011a_RC3"
cd /d "%ROOT%"
"C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe" -nosplash -logfile "%ROOT%\resultados\launcher_menu_rc3.txt" -r "cmc_iniciar_gui_r2011a"
