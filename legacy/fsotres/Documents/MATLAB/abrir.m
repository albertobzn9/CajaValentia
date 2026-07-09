function abrir

Resp=menu('Que aplicacion quieres?','Entrena','Condicionamiento','ValentiaC','ValentiaD','EntrenaE','ValentiaE','CondicionamientoAleatorio','ValentiaE2','ValentiaE3','ValentiaConflicto','Matlab');

if(Resp==1)
    OA_ValentiaEntrenaPalancasCP
end
if(Resp==2)
    OA_Condicionamiento
end
if(Resp==3)
    OA_ValentiaCuatroC
end
if(Resp==4)
    OA_ValentiaCuatroD
end
if(Resp==5)
    OA_ValentiaEntrenaPalancasCPE
end
if(Resp==6)
    OA_ValentiaCuatroE
end
if(Resp==7)
    OA_Condiciona_Aleatorio
end    
if(Resp==8)
    OA_ValentiaCuatroE2  %incluye pausa aleatoria al inicio de cada ensayo
end
if(Resp==9)
    OA_ValentiaCuatroE3  %incluye ensayos neutros
end
if(Resp==10)
    OA_ValentiaCuatroEConflicto  %incluye ensayos neutros
end