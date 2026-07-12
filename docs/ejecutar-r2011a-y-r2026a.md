# Abrir Cada Version De MATLAB

## Regla Principal

El comando para abrir el menu nuevo es siempre:

```matlab
abrir1
```

No existe un comando distinto para R2011a y R2026a. La version se decide antes:
por el MATLAB que se abrio y por la carpeta de codigo que se esta usando.

## R2011a: Prueba Principal Con La Caja

La copia operativa queda desplegada en el Escritorio de la computadora del lab:

```text
C:\Users\Alberto\Desktop\CajaValentia
```

Abrir con doble clic:

```text
C:\Users\Alberto\Desktop\CajaValentia\Abrir_CajaValentia_R2011a.bat
```

El lanzador abre MATLAB R2011a, limpia las rutas viejas y abre `abrir1`. Debe
ejecutarse como usuario normal, sin **Ejecutar como administrador**. Para
diagnostico, dentro de MATLAB:

```matlab
which abrir1 -all
```

La primera ruta debe ser:

```text
C:\Users\Alberto\Desktop\CajaValentia\abrir1.m
```

Esta es la copia que se valida primero con el hardware real.

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

Si aparece un menu inesperado, cerrar la GUI, abrir de nuevo el lanzador del
Escritorio y revisar `which abrir1 -all`.
