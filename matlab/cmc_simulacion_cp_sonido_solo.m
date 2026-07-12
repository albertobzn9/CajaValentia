function [Resultados,Cronograma] = cmc_simulacion_cp_sonido_solo(DuracionRiesgo)
%CMC_SIMULACION_CP_SONIDO_SOLO Simula CP temporal sin tarjeta ni caja.
% Cronograma: [Evento Tipo Inicio Fin]. Tipo 1=CP normal, 2=sonido solo.

if nargin < 1
    DuracionRiesgo = 30;
end
assert(any(DuracionRiesgo == [30 60 90 120]), ...
    'Use una duracion CP valida: 30, 60, 90 o 120 s.');

cmc_setup_paths();
rand('state',1);

Secuencia = OA_SecuenciaEnsayos4(1,1);
TiemposSonidoSolo = [9 18 27]*60;
ProximoSonidoSolo = 1;
Tiempo = 0;
NumeroEvento = 1;
Resultados = [];
Cronograma = [];
NecesitaITI = false;

Ensayo = 1;
while true
    plan = cmc_planificador_cp_sonido_solo(Tiempo, DuracionRiesgo, ProximoSonidoSolo);
    if plan.ejecutar_sonido
        Inicio = Tiempo;
        Tiempo = Tiempo + DuracionRiesgo;
        LatenciaCruceSimulada = max(1,round(DuracionRiesgo/2));
        Resultados = [Resultados;[NumeroEvento 1 1 DuracionRiesgo Tiempo ...
            0 0 LatenciaCruceSimulada 2]];
        Cronograma = [Cronograma;[NumeroEvento 2 Inicio Tiempo]];
        NumeroEvento = NumeroEvento + 1;
        ProximoSonidoSolo = ProximoSonidoSolo + 1;
        continue
    end

    if plan.finalizar_sin_nuevo_ensayo
        break
    end

    if NecesitaITI
        ITIAleatorio = 60 + round(120 * rand(1,1));
        Tiempo = Tiempo + min(ITIAleatorio, plan.max_iti_s);
        NecesitaITI = false;
        continue
    end

    Inicio = Tiempo;
    LatenciaSimulada = min(DuracionRiesgo,5 + round(25*rand(1,1)));
    Tiempo = Tiempo + LatenciaSimulada;
    Resultados = [Resultados;[NumeroEvento Secuencia(Ensayo,1) 1 ...
        LatenciaSimulada Tiempo 0 0 LatenciaSimulada 1]];
    Cronograma = [Cronograma;[NumeroEvento 1 Inicio Tiempo]];
    NumeroEvento = NumeroEvento + 1;
    Ensayo = Ensayo + 1;
    if Ensayo > size(Secuencia,1)
        Ensayo = 1;
    end
    NecesitaITI = true;
end

NumSonidoSolo = sum(Resultados(:,9) == 2);
assert(sum(Resultados(:,9) == 1) > 0, 'Debe haber CP normales.');
assert(NumSonidoSolo == 3, 'CP debe programar los tres sonidos solos.');
InicioSonidos = Cronograma(Cronograma(:,2) == 2,3);
assert(all(InicioSonidos < 30*60), ...
    'Cada sonido solo debe iniciar antes de terminar los 30 min conductuales.');
FilasSonidoSolo = Resultados(Resultados(:,9) == 2,:);
assert(all(FilasSonidoSolo(:,4) == DuracionRiesgo), ...
    'Sonido solo CP debe conservar la duracion completa.');
assert(all(FilasSonidoSolo(:,8) < FilasSonidoSolo(:,4)), ...
    'El cruce simulado no debe cortar el sonido solo CP.');

fprintf('OK CP: 10 ensayos normales + %d sonido(s) solo; duracion = %d s.\n', ...
    NumSonidoSolo,DuracionRiesgo);
