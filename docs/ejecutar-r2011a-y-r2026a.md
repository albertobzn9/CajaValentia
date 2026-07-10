# Abrir Cada Version De MATLAB

## Regla Principal

El comando para abrir el menu nuevo es siempre:

```matlab
abrir1
```

No existe un comando distinto para R2011a y R2026a. La version se decide antes:
por el MATLAB que se abrio y por la carpeta de codigo que se esta usando.

## R2011a: Prueba Principal Con La Caja

Usar la rama candidata:

```text
release/v2.0.0-rc.3-resultados-9-columnas
```

Copiar su carpeta `matlab` al USB como `Z:\CajaValentia`. En MATLAB R2011a:

```matlab
cd('Z:\CajaValentia')
which abrir1 -all
abrir1
```

La primera ruta que muestre `which abrir1 -all` debe ser:

```text
Z:\CajaValentia\abrir1.m
```

Esta es la version que se valida primero con el hardware real.

## R2026a: Prueba Moderna Separada

Usar la rama:

```text
migration/r2022a-r2026a-ni-usb6501
```

Abrir MATLAB R2026a, cambiar a su carpeta `matlab`, comprobar la ruta y usar el
mismo comando:

```matlab
which abrir1 -all
abrir1
```

Esta prueba no sustituye la validacion R2011a: sirve para comprobar la futura
migracion con las interfaces modernas de tarjeta y audio.

## No Usar `abrir`

Aunque la carpeta nueva incluye un `abrir.m` que redirige a `abrir1`, no debe
usarse como rutina diaria. La computadora del lab conserva menus viejos y
MATLAB puede resolver primero otro archivo llamado `abrir.m` si su ruta esta
activa. Eso puede abrir una version historica sin los cambios actuales.

Si aparece un menu inesperado, cerrar la GUI, volver a la carpeta correcta y
repetir `which abrir1 -all` antes de escribir `abrir1`.
