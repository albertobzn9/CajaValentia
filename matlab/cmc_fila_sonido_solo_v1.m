function Fila = cmc_fila_sonido_solo_v1(Ensayo,TiempoEvento,TiempoAbsoluto, ...
    ContadorTI,ContadorTD,LatenciaCruce)
%CMC_FILA_SONIDO_SOLO_V1 Conserva las ocho columnas de Resultados.

Fila = [Ensayo 3 1 TiempoEvento TiempoAbsoluto ContadorTI ContadorTD LatenciaCruce];
end
