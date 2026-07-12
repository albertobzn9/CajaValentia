# Mini Guia Para Leer El MATLAB De La Caja

Esta guia sirve para entender el programa sin leerlo linea por linea. Lee
primero esto; despues consulta el [mapa](01_mapa_modulos_matlab_limpio.md) y el
[inventario](02_inventario_modulos_matlab_limpio.md) cuando necesites detalle.

## La Idea Central

MATLAB es el programa que ejecuta instrucciones. Cada archivo `.m` de esta
caja es una pieza de trabajo: abrir una ventana, decidir un ensayo, leer un
sensor o activar una luz.

El programa no es una sola cosa enorme. Es una cadena:

```text
menu -> tarea -> tarjeta/audio -> ensayo -> sensores/acciones -> resultados
```

## Las Piezas Que Veras

| Nombre | Que significa aqui | Ejemplo de la caja |
|---|---|---|
| Archivo `.m` | Codigo que MATLAB puede ejecutar. | `OA_ValentiaCuatroE.m` controla cruces seguros. |
| Funcion | Una accion con nombre dentro de un `.m`. | `OA_Sonidos` reproduce un tono o ruido. |
| GUI | Ventana con botones y parametros. | La ventana de `ValentiaE`. |
| Archivo `.fig` | El dibujo de una GUI: botones, textos y cajas. | `OA_ValentiaCuatroE.fig`. |
| Callback | Codigo que corre cuando se presiona un boton. | El boton Inicio empieza los ensayos. |
| Archivo `.mat` | Memoria guardada: parametros o resultados. | `Riesgo.mat`, `Resultados.mat`. |

## Como Abre El Programa

El operador escribe `abrir1`. Esa funcion muestra el menu. Al elegir una
opcion, MATLAB abre la GUI correspondiente.

Por ejemplo:

```text
abrir1 -> ValentiaE -> OA_ValentiaCuatroE.m
```

La GUI no inicia necesariamente una sesion al abrirse. Primero prepara la
caja. La sesion empieza cuando el operador presiona el boton de inicio.

## Que Es `handles`

`handles` es una mochila de datos que la GUI conserva mientras esta abierta.
Por ejemplo, ahi guarda:

- `handles.OA`: conexion con la tarjeta de la caja;
- `handles.GS`: conexion con el audio;
- referencias a botones, textos y parametros de la ventana.

No es una funcion nueva ni un archivo extra. Es la manera antigua de MATLAB de
mantener juntas las cosas que necesita una ventana.

## Tarjeta, Sensores Y Acciones

`OA_ValentiaInicio` abre la conexion con la tarjeta National Instruments. A
partir de ahi, las funciones pequenas controlan una parte fisica concreta:

- `OA_ValentiaEstimuloI/D`: luces o estimulos de un lado;
- `OA_ValentiaRecompensaI/D`: entrega de pellet;
- `OA_ValentiaElectrico`: descarga;
- `OA_ValentiaBuscaIzquierda/Derecha`: deteccion de cruce;
- `OA_ValentiaRevisaPalanca`: lectura de palancas.

Estas funciones no deciden la regla del experimento. Solo ejecutan ordenes de
la GUI. Por eso, para cambiar una regla conductual se revisa primero la GUI de
la tarea, no `OA_ValentiaInicio`.

## Como Se Decide Un Ensayo

En las tareas de cruces, la GUI pide una secuencia. Esa secuencia define:

1. que lado toca;
2. si es un ensayo seguro o de riesgo.

`OA_SecuenciaEnsayos3` se usa para `ValentiaE`. `OA_SecuenciaEnsayos4` se usa
para `ValentiaE2`. Ambas usan funciones mas pequenas para ordenar los lados y
la proporcion de riesgo.

Despues, la GUI enciende las senales, espera un cruce o un timeout, entrega
comida cuando corresponde y guarda el resultado.

## Guardar Y Cargar Datos

`save` guarda datos en un `.mat`. `load` los vuelve a leer.

Ejemplos sencillos:

- `Riesgo.mat` guarda el porcentaje de ensayos de riesgo;
- `ControlTarea.mat` indica si la tarea sigue, se pausa o se detiene;
- `OA_Resultados.mat` guarda los resultados de cruces durante la sesion.

Los `.mat` de estado estan en `Valentia/`. Los resultados finales se exportan
a `resultados/` dentro de la copia desplegada.

## Que Son Las Rutas

MATLAB solo puede usar un archivo si sabe donde buscarlo. Las funciones
`cmc_root` y `cmc_setup_paths` le dicen: “usa esta carpeta desplegada y sus
subcarpetas”. Esto evita que por accidente use una copia vieja del programa en
la computadora.

## Por Que Este MATLAB Se Ve Antiguo

La version del laboratorio (R2011b) usa una forma vieja de crear GUIs y de
hablar con tarjetas de adquisicion. MATLAB actual y Python tienen herramientas
mas modernas, pero eso no significa que este codigo sea inutil: la logica
conductual y el control de la caja siguen estando aqui.

La regla practica es sencilla: no modernizar una funcion solo porque se ve
vieja. Primero hay que entender que hace y probar cualquier cambio con la caja.

## Como Leer Un Archivo Sin Perderte

Cuando abras un `.m`, busca en este orden:

1. El nombre de la funcion al inicio: te dice de que trata el archivo.
2. Las llamadas a otras funciones: te dicen que piezas usa.
3. `load` y `save`: te dicen que parametros o resultados toca.
4. Los botones `..._Callback`: te dicen que acciones hace el usuario.

Con eso basta para una primera lectura. No necesitas entender cada linea para
saber donde vive una regla experimental.
