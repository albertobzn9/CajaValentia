function cmc_prueba_conteo_ensayos_cruce
%CMC_PRUEBA_CONTEO_ENSAYOS_CRUCE Valida conteo y cierre sin hardware.

assert(cmc_es_ensayo_cruce_programado(0,0) == 1);
assert(cmc_es_ensayo_cruce_programado(0,1) == 1);
assert(cmc_es_ensayo_cruce_programado(1,0) == 0);
assert(cmc_es_ensayo_cruce_programado(1,1) == 0);
assert(cmc_es_ensayo_cruce_programado(0,2) == 0);
assert(cmc_es_ensayo_cruce_programado(1,2) == 0);

% El resultado fisico no interviene: cruce y timeout cuentan igual cuando
% el evento con comida fue programado como cambio de lado.
CuentaSiCruza = cmc_es_ensayo_cruce_programado(0,0);
CuentaSiTimeout = cmc_es_ensayo_cruce_programado(0,0);
assert(CuentaSiCruza == 1 && CuentaSiTimeout == 1);

SecuenciaManual = [ ...
    0 0; ... % primer ensayo normal
    1 0; ... % cambio de lado
    1 0; ... % mismo lado
    0 1; ... % cambio de lado con riesgo
    1 2; ... % sonido solo
    1 0; ... % mismo lado respecto al sonido
    0 0];    % cambio de lado
assert(cmc_cuenta_ensayos_cruce_programados(SecuenciaManual) == 4);

[SecuenciaSegura,ModoSeguro] = ...
    OA_SecuenciaDiscriminacionSonidoSolo(30,3,0,1);
assert(ModoSeguro == 0);
assert(cmc_cuenta_ensayos_cruce_programados(SecuenciaSegura) >= 30);

[SecuenciaSinSonido,ModoSinSonido] = ...
    OA_SecuenciaDiscriminacionSonidoSolo(30,3,0.3,0);
assert(ModoSinSonido == 0);
assert(cmc_cuenta_ensayos_cruce_programados(SecuenciaSinSonido) >= 30);

for Repeticion = 1:20
    [Secuencia,Modo] = OA_SecuenciaDiscriminacionSonidoSolo(30,3,0.3,1);
    assert(Modo == 1);
    assert(cmc_cuenta_ensayos_cruce_programados(Secuencia) == 30);
    assert(sum(Secuencia(:,2) == 2) == 3);

    EnsayosCruce = 0;
    FinEnsayos = 30;
    for i = 1:size(Secuencia,1)
        MismoLado = i > 1 && Secuencia(i-1,1) == Secuencia(i,1);
        if cmc_es_ensayo_cruce_programado(MismoLado,Secuencia(i,2))
            EnsayosCruce = EnsayosCruce + 1;
        end
        if EnsayosCruce >= FinEnsayos
            break
        end
    end
    assert(EnsayosCruce == FinEnsayos);
    assert(i <= size(Secuencia,1));
    assert(sum(Secuencia(1:i,2) == 2) == 3, ...
        'El cierre no debe dejar pendiente el sonido del ultimo bloque.');
end

disp('OK: conteo y cierre de ensayos de cruce validados.');
