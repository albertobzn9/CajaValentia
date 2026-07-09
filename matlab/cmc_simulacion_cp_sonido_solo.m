function [Resultados,Cronograma] = cmc_simulacion_cp_sonido_solo(DuracionRiesgo)
%CMC_SIMULACION_CP_SONIDO_SOLO Simula 10 CP normales sin tarjeta ni caja.
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

for Ensayo = 1:10
    if Ensayo > 1
        Tiempo = Tiempo + 60 + round(120*rand(1,1));

        % Es el mismo punto seguro donde el programa real revisa su agenda:
        % despues del ITI y antes del siguiente CP normal.
        if ProximoSonidoSolo <= length(TiemposSonidoSolo) && ...
                Tiempo >= TiemposSonidoSolo(ProximoSonidoSolo)
            Inicio = Tiempo;
            Tiempo = Tiempo + DuracionRiesgo;
            LatenciaCruceSimulada = max(1,round(DuracionRiesgo/2));
            Resultados = [Resultados;[NumeroEvento Secuencia(Ensayo,1) 1 ...
                DuracionRiesgo Tiempo 0 0 LatenciaCruceSimulada 2]];
            Cronograma = [Cronograma;[NumeroEvento 2 Inicio Tiempo]];
            NumeroEvento = NumeroEvento + 1;
            ProximoSonidoSolo = ProximoSonidoSolo + 1;
        end
    end

    Inicio = Tiempo;
    LatenciaSimulada = min(DuracionRiesgo,5 + round(25*rand(1,1)));
    Tiempo = Tiempo + LatenciaSimulada;
    Resultados = [Resultados;[NumeroEvento Secuencia(Ensayo,1) 1 ...
        LatenciaSimulada Tiempo 0 0 LatenciaSimulada 1]];
    Cronograma = [Cronograma;[NumeroEvento 1 Inicio Tiempo]];
    NumeroEvento = NumeroEvento + 1;
end

NumSonidoSolo = sum(Resultados(:,9) == 2);
assert(sum(Resultados(:,9) == 1) == 10, 'Deben conservarse 10 CP normales.');
assert(NumSonidoSolo <= 3, 'No pueden programarse mas de tres sonidos solos.');
if NumSonidoSolo > 0
    InicioSonidos = Cronograma(Cronograma(:,2) == 2,3);
    assert(all(InicioSonidos >= TiemposSonidoSolo(1:NumSonidoSolo)'), ...
        'Un sonido solo no puede iniciar antes de su hora objetivo.');
    FilasSonidoSolo = Resultados(Resultados(:,9) == 2,:);
    assert(all(FilasSonidoSolo(:,4) == DuracionRiesgo), ...
        'Sonido solo CP debe conservar la duracion completa.');
    assert(all(FilasSonidoSolo(:,8) < FilasSonidoSolo(:,4)), ...
        'El cruce simulado no debe cortar el sonido solo CP.');
end

fprintf('OK CP: 10 ensayos normales + %d sonido(s) solo; duracion = %d s.\n', ...
    NumSonidoSolo,DuracionRiesgo);
