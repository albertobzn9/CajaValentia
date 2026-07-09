function OA_ValentiaPalanqueo(OA,Lado,Modo,Duracion)

tic
if(strcmp(Lado,'I'))
    escribePto(OA,[21 22],[1 1]);
    escribePto(OA,[15],[1]);
    escribePto(OA,[21 22],[0 0]);
    escribePto(OA,[15],[0]);
    while(toc<Duracion)
        escribePto(OA,[9:12],[1 1 0 0]);
        Datos=[getvalue(OA.Line(1:8))]
    end
end    


