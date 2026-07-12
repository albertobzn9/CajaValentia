# Uso Desde El Escritorio En MATLAB R2011a

Esta carpeta es una copia depurada y autocontenida del MATLAB funcional de la
Caja CMC. Contiene solo las rutas activas del manual y sus dependencias
conocidas.

El comando de entrada es:

```matlab
abrir1
```

Tambien existe `abrir.m` como redireccion local, pero el comando de operacion
debe ser siempre `abrir1`. En la computadora del lab hay otros menus llamados
`abrir` en rutas antiguas; MATLAB podria abrir uno de ellos.

## Instalacion Operativa

La copia usada diariamente vive en la computadora del laboratorio, bajo el
perfil normal de Alberto. Ruta recomendada:

```text
C:\Users\Alberto\Desktop\CajaValentia
```

No se opera desde USB. GitHub conserva el codigo fuente; el Escritorio contiene
la copia desplegada y probada con la caja.

## Instrucciones Para El Operador

1. Abrir `Abrir_CajaValentia_R2011a.bat` con doble clic dentro de la carpeta
   `CajaValentia` del Escritorio. El lanzador usa el usuario normal: no elegir
   **Ejecutar como administrador**.
2. Esperar a que abra MATLAB R2011a y elegir la tarea del menu depurado.
3. Si se necesita diagnosticar una ruta desde MATLAB, escribir:

   ```matlab
   which abrir1 -all
   ```

   La primera ruta de `which abrir1 -all` debe apuntar a
   `C:\Users\Alberto\Desktop\CajaValentia\abrir1.m`.

4. Elegir una opcion del menu depurado:

   - `Entrena - moldeamiento / palanqueo`
   - `EntrenaE - luz-comida`
   - `ValentiaE - cruces seguros / discriminacion / prueba`
   - `ValentiaE2 - cruces peligrosos`
   - `Condicionamiento aleatorio`

## Que Se Cambio

Se agrego `abrir1.m`, un menu depurado que:

- agrega al path esta carpeta y sus subcarpetas necesarias;
- muestra solo las opciones usadas en el manual;
- no llama funciones historicas del menu viejo.

Tambien se agrego `abrir.m` como wrapper local para evitar que MATLAB resuelva
el `abrir` viejo desde rutas persistidas en la computadora del lab.

Tambien se cambiaron las rutas absolutas antiguas. `cmc_root` detecta la carpeta
que contiene el propio programa, por lo que no depende de `fsotres`, `Alberto`,
la letra `Z:` ni las carpetas legacy.

## Permisos

El uso diario no requiere privilegios de administrador. El programa escribe
solo en su propia carpeta (`Valentia` y `resultados`) y en `Documents`; esas
rutas pertenecen al usuario normal. MATLAB R2011a y el driver NI USB-6501 deben
estar instalados previamente por quien tenga permisos administrativos.

Si el lanzador falla como usuario normal, guardar el texto de
`resultados\launcher_menu.txt`. No usar administrador como solucion rutinaria:
primero hay que identificar si falta un driver, una ruta o un permiso local.

## Recomendacion De Prueba

Antes de usar con animales:

1. Abrir MATLAB R2011a.
2. Abrir `Abrir_CajaValentia_R2011a.bat` con doble clic.
4. Probar que cada opcion del menu abre su GUI.
5. Cerrar sin iniciar sesion.
6. Confirmar que no aparece error de ruta ni de archivo `.mat` faltante.

Si aparece un error, guardar el mensaje exacto y en que opcion del menu ocurrio.

## Cambios En Esta Version Candidata

- `ValentiaE`: la casilla `Agregar 1 solo sonido / 10 eventos` activa el modo
  nuevo. Con riesgo mayor que cero, cada bloque de diez eventos de comida agrega
  un evento de sonido/parrilla sin luz ni pellet. Sin marcarla, la secuencia de
  riesgo conserva el comportamiento historico.
- `ValentiaE2`: programa eventos de sonido/parrilla sin luz ni pellet cerca de
  los minutos 9, 18 y 27 de la conducta. La duracion se toma del campo de
  ensayo de riesgo.

Antes de usar estos cambios con animales, ejecutar las pruebas de simulacion y
hacer una prueba supervisada de MATLAB R2011a y de la caja. En el repositorio
fuente, el estado de validacion queda documentado en `docs/validation.md`.
