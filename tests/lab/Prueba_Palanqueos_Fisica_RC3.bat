@echo off
rem Ejecutar como usuario normal: no autoelevar a administrador.
set "ROOT=%~dp0CajaValentia_R2011a_RC3"
cd /d "%ROOT%"
"C:\Program Files (x86)\MATLAB\R2011a\bin\matlab.exe" -nosplash -logfile "%ROOT%\resultados\launcher_prueba_palanqueos.txt" -r "cmc_prepara_entorno_r2011a; cmc_prueba_fisica_palanqueos"
