# Uso Desde USB En MATLAB R2011a

Esta carpeta es una copia depurada y autocontenida del MATLAB funcional de la
Caja CMC. Contiene solo las rutas activas del manual y sus dependencias
conocidas.

El comando de entrada es:

```matlab
abrir1
```

Tambien existe `abrir.m` como seguro: si por costumbre se escribe `abrir`
estando dentro de esta carpeta, redirige a `abrir1` y no al menu viejo del disco
C.

## Instrucciones Para El Operador

1. Copiar la carpeta completa `06_matlab_limpio_usb` directo al USB.
2. Abrir MATLAB R2011a.
3. En MATLAB, cambiar el **Current Folder** a la carpeta del USB:

   ```text
   Z:\06_matlab_limpio_usb
   ```

4. En la Command Window escribir:

   ```matlab
   abrir1
   ```

   Si se escribe `abrir` por error, esta copia local tambien abre el menu
   depurado.

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
Z:\06_matlab_limpio_usb
```

El codigo no depende de rutas locales antiguas ni de la carpeta
`04_codigo_matlab_legacy`. Los archivos de estado se usan desde:

```text
Z:\06_matlab_limpio_usb\Valentia
```

Los resultados se guardan/cargan por defecto desde:

```text
Z:\06_matlab_limpio_usb\resultados
```

## Recomendacion De Prueba

Antes de usar con animales:

1. Abrir MATLAB R2011a.
2. Cambiar el **Current Folder** a `Z:\06_matlab_limpio_usb`.
3. Ejecutar `abrir1`.
4. Probar que cada opcion del menu abre su GUI.
5. Cerrar sin iniciar sesion.
6. Confirmar que no aparece error de ruta ni de archivo `.mat` faltante.

Si aparece un error, guardar el mensaje exacto y en que opcion del menu ocurrio.
