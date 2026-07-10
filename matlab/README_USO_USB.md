# Uso Desde USB En MATLAB R2011a

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

## Instrucciones Para El Operador

1. Copiar la carpeta `matlab` de esta version al USB y renombrarla
   `CajaValentia`.
2. Abrir MATLAB R2011a.
3. En MATLAB, cambiar el **Current Folder** a la carpeta del USB:

   ```text
   Z:\CajaValentia
   ```

4. En la Command Window escribir:

   ```matlab
   which abrir1 -all
   abrir1
   ```

   La primera ruta de `which abrir1 -all` debe apuntar a
   `Z:\CajaValentia\abrir1.m`.

5. Elegir una opcion del menu depurado:

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

Tambien se cambiaron las rutas absolutas antiguas de la copia limpia para que
apunten a esta carpeta del USB. La carpeta original legacy puede borrarse y esta
copia debe seguir funcionando.

## Nota Importante Sobre USB

La unidad esperada en Windows es `Z:` y la carpeta debe quedar asi:

```text
Z:\CajaValentia
```

El codigo no depende de rutas locales antiguas ni de la carpeta
`04_codigo_matlab_legacy`. Los archivos de estado se usan desde:

```text
Z:\CajaValentia\Valentia
```

Los resultados se guardan/cargan por defecto desde:

```text
Z:\CajaValentia\resultados
```

## Recomendacion De Prueba

Antes de usar con animales:

1. Abrir MATLAB R2011a.
2. Cambiar el **Current Folder** a `Z:\CajaValentia`.
3. Ejecutar `abrir1`.
4. Probar que cada opcion del menu abre su GUI.
5. Cerrar sin iniciar sesion.
6. Confirmar que no aparece error de ruta ni de archivo `.mat` faltante.

Si aparece un error, guardar el mensaje exacto y en que opcion del menu ocurrio.

## Cambios En Esta Version Candidata

- `ValentiaE`: con riesgo mayor que cero, cada bloque de diez eventos de comida
  agrega un evento de sonido/parrilla sin luz ni pellet. Con riesgo cero no se
  agrega ese evento.
- `ValentiaE2`: programa eventos de sonido/parrilla sin luz ni pellet cerca de
  los minutos 9, 18 y 27 de la conducta. La duracion se toma del campo de
  ensayo de riesgo.

Antes de usar estos cambios con animales, ejecutar las pruebas de simulacion y
hacer una prueba supervisada de MATLAB R2011a y de la caja. En el repositorio
fuente, el estado de validacion queda documentado en `docs/validation.md`.
