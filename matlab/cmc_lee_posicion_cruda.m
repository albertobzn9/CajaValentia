function lugar = cmc_lee_posicion_cruda(OA)
%CMC_LEE_POSICION_CRUDA Lee los 18 sensores laser de posicion.
% La tarjeta entrega los sensores activos en nivel bajo. Las lineas 13:16
% se conservan en cero para no activar ningun estimulo de la caja.

selectores = [0 0 0 0; 1 0 0 0; 0 1 0 0];
datos = [];
for i = 1:3
    escribePto(OA, 9:16, [selectores(i,:) 0 0 0 0]);
    pause(.01);
    datos = [datos getvalue(OA.Line(1:8))];
end

lugar = not(datos(2:19));
lugar = fliplr(lugar);
