# Migracion A MATLAB R2026a: Retos Y Ruta Segura

## Resumen Ejecutivo

La conducta experimental si es migrable: secuencias, reglas de riesgo, sonido
solo, conteo y CSV son codigo MATLAB ordinario. Lo que no puede pasar sin
cambios es la capa que habla con el mundo fisico.

| Dependencia actual | Que hace | Por que es fragil |
| --- | --- | --- |
| MATLAB R2011a | Corre GUIDE y la API DAQ antigua. | Es la ultima pieza que entiende directamente este codigo de hardware. |
| `digitalio('nidaq','Dev2')` | Lee sensores y ordena luces, pellet, parrilla y palancas por la NI USB-6501. | La interfaz DAQ legacy no existe en MATLAB moderno de 64 bits. |
| `analogoutput('winsound',0)` | Genera el ruido blanco estereo de 15 kHz. | Es una salida de audio legacy de Windows; hay que implementarla y medirla otra vez. |

`Dev2` no es el modelo de tarjeta. Es el identificador que MATLAB R2011a le dio
a la NI USB-6501 en esa PC. En una instalacion nueva puede ser `Dev1`, `Dev3` u
otro: el programa nuevo debe descubrirlo, no suponerlo.

## Que Se Puede Reusar

- reglas conductuales de Discriminacion y CP;
- secuencias de ensayos, incluido sonido solo;
- CSV de resultados, palanqueos y resumen;
- mapa funcional de las 24 lineas de la tarjeta;
- pruebas sin hardware.

La suite actual ya pasa sin hardware en R2026a. Eso demuestra que buena parte
de la logica se interpreta en MATLAB nuevo; no demuestra que la caja pueda ser
controlada desde R2026a.

## Que Se Debe Reescribir O Verificar

- NI: `digitalio`, `addline`, `getvalue`, `putvalue` y `daqreset`;
- audio: `analogoutput`, `addchannel`, muestreo y lados izquierdo/derecho;
- apagado seguro ante error o cierre;
- nombre del dispositivo, puertos y lineas en la instalacion nueva;
- cambios visuales de GUIDE hechos con editor grafico.

## Retos Tecnicos

### Tarjeta NI USB-6501

La caja usa tres puertos digitales de ocho lineas: puerto 0 para sensores y
contadores; puerto 1 para selector de lectura, parrilla y reset; puerto 2 para
luces, LED/sonido, dispensadores y palancas.

En R2026a la ruta moderna es crear un objeto `DataAcquisition` de NI,
descubrir dispositivos con `daqlist("ni")`, agregar lineas con
`addinput`/`addoutput` y operar con `read`/`write`. No basta traducir nombres
de funciones: hay que confirmar el orden fisico de cada linea con la caja.

La USB-6501 usa NI-DAQmx segun su manual. Aun asi, antes de prometer
compatibilidad con R2026a, el criterio real debe ser: NI MAX la detecta y
MATLAB la lista en `daqlist("ni")`. Esto sigue siendo un requisito de prueba,
no un hecho ya validado.

### Audio

El ruido no sale por la NI: sale por la tarjeta de sonido Windows. El codigo
viejo crea dos canales estereo a 20 kHz y usa `15000` para generar ruido blanco.
El reemplazo moderno debe elegirse por medicion, no por apariencia de API.

La prueba de audio debe confirmar en ambos lados:

1. ruido blanco perceptualmente equivalente al R2011a;
2. predominio claro de la bocina objetivo;
3. misma duracion y momento de inicio;
4. que no altere el retardo LED/ruido -> luz de comida.

### GUI GUIDE

R2026a puede correr una app GUIDE existente, pero desde R2025a GUIDE ya no se
puede editar con su editor grafico. Se puede editar el `.m` asociado o migrar
la interfaz a App Designer. Por eso el rediseño de Eric no debe mezclarse con
el primer cambio de tarjeta/audio: son dos riesgos distintos.

### R2016a Como Puente

R2016a es una opcion intermedia para una PC vieja, no una solucion que permita
abrir el programa actual sin modificaciones. Sus requisitos para Windows son
mucho menores que los de R2026a: 2 GB de RAM como minimo y soporte para
Windows 10. En `DESKTOP-LAB-S` probablemente arrancaria y responderia mejor
que R2021b/R2026a, aunque el HDD seguiria haciendo lentas las cargas.

El limite importante aparece precisamente en R2016a: MATLAB pasa a ser solo
de 64 bits y la interfaz DAQ legacy usada por la caja deja de ser la ruta
soportada. Por tanto, `digitalio('nidaq','Dev2')` y
`analogoutput('winsound',0)` no deben asumirse funcionales solo por instalar
R2016a. Tarjeta y audio necesitan una capa nueva y una prueba fisica, igual
que en R2026a.

R2016a conserva GUIDE, asi que puede ser util para abrir y editar los `.fig`
durante una transicion. La ruta de adquisicion de esa epoca se parece mas a la
interfaz de sesiones que a la API actual, pero no existe una traduccion
automatica ni esta validada aun con esta USB-6501, su driver y esta caja.

**Decision recomendada:** mantener R2011a como produccion. Usar R2016a solo
como banco de transicion si se quiere comprobar antes la tarjeta y el audio en
esta PC con menor carga. No convertirlo en destino definitivo: duplicaria el
trabajo de migracion y dejaria otra version obsoleta entre R2011a y R2026a.

### Tiempo Y Seguridad

Una migracion correcta debe preservar, no solo aproximar:

- inicio sin pellet;
- un pellet por palanqueo valido;
- parrilla apagada al iniciar, terminar y ante error;
- sonido solo sin luz ni pellet;
- retardo LED/ruido -> luz de comida;
- limites de 60 s, 180 s y ventana extra de CP;
- CSV actuales y su significado.

El software nuevo necesita una funcion central de apagado seguro, usada tambien
en errores y al cerrar la ventana. Esto es requisito de seguridad, no estetica.

## PC Actual Del Laboratorio

Registro conocido de `DESKTOP-LAB-S`:

| Componente | Estado conocido | Lectura para R2026a |
| --- | --- | --- |
| CPU | Intel Core i3-4330, 3.5 GHz, 2 nucleos/4 hilos | Puede servir para control simple; no es el bloqueo principal. |
| RAM | 8 GB DDR3-1600 | Minimo oficial; no deja margen para MATLAB, GUI, NI, audio y Windows. |
| Disco | HDD mecanico | Principal causa practica de arranque y GUI lentos. |
| SO | Windows 10 build 19044 (21H2) | R2026a requiere Windows 10 22H2 o posterior; asi no es una plataforma soportada. |
| MATLAB | R2011a operativo; R2021b muy lento | R2011a debe seguir como produccion durante la migracion. |

MathWorks pide minimo 8 GB, recomienda 16 GB y recomienda SSD. Tambien
recomienda cuatro hilos logicos con AVX2. La PC esta en el minimo de RAM, usa
HDD y su Windows es anterior al soportado. Una GPU dedicada no es necesaria
para controlar la caja.

### Recomendacion De Equipo

No migrar directamente sobre la instalacion que hoy corre animales. La opcion
de menor riesgo es una PC Windows separada o un SSD clonable de prueba con:

- Windows 10 22H2 o Windows 11 soportado;
- SSD para sistema y MATLAB;
- 16 GB de RAM DDR3 compatibles, si se conserva esta PC;
- MATLAB R2026a, Data Acquisition Toolbox y soporte NI-DAQmx;
- NI-DAQmx compatible con USB-6501 y ese Windows;
- audio Windows validado por prueba fisica.

La Mac sirve para leer, editar y probar logica. No sirve para controlar esta
caja con R2026a: Data Acquisition Toolbox no esta disponible para macOS.

## Ruta De Migracion

1. **Banco Windows:** instalar R2026a y dependencias sin tocar R2011a.
2. **Descubrimiento sin salidas:** confirmar NI y audio; sin animales.
3. **Adaptador digital minimo:** reproducir las 24 lineas, con todo apagado
   por defecto. Probar una salida por vez y parrilla deshabilitada.
4. **Audio aislado:** comparar ruido 15 kHz, lados y tiempos contra R2011a.
5. **Sensores y pellets:** validar posicion, palancas, un pellet por pulso y
   reset de contadores.
6. **Sesion simulada:** comparar LEDs, luces, CSV y tiempos con R2011a.
7. **Sesion supervisada:** solo despues de pasar todos los pasos anteriores.

Hasta la fase 7, R2011a sigue siendo produccion.

## Fuentes Tecnicas

- [Requisitos de MATLAB R2026a para Windows](https://www.mathworks.com/support/requirements/matlab-system-requirements.html)
- [Entrada/salida digital moderna](https://www.mathworks.com/help/daq/digital-input-and-output.html)
- [Salida digital no sincronizada con `write`](https://www.mathworks.com/help/daq/generate-non-clocked-digital-data.html)
- [Estado de GUIDE en MATLAB moderno](https://www.mathworks.com/help/matlab/ref/guide.html)
- [Requisitos de MATLAB R2016a para Windows](https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/support/sysreq/files/SystemRequirements-Release2016a_Windows.pdf)
- [Compatibilidad entre versiones de Data Acquisition Toolbox](https://www.mathworks.com/help/daq/ug/using-previous-matlab-releases.html)
- [Compatibilidad de NI con sistemas operativos](https://www.ni.com/en/support/documentation/compatibility/21/ni-hardware-and-operating-system-compatibility.html)
- [Manual de la NI USB-6501](https://download.ni.com/support/manuals/375267a.pdf)

## Conclusion

Migrar a R2026a no es abrir el mismo archivo en un MATLAB nuevo. Es sustituir
la capa de tarjeta y audio, y despues demostrar equivalencia conductual. SSD +
16 GB de RAM mejorarian mucho la PC actual, pero no eliminan el trabajo de I/O
ni sus pruebas.
