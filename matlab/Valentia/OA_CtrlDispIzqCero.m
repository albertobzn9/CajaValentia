function  OA_CtrlDispIzqCero(OA)
escribePto(OA,[24],[0]);
Datos=[0 0 0 0];
control=[0 0 0];
CD=[control Datos];
escribePto(OA,17:23,CD);
control=[1 0 1];
CD=[control Datos];
escribePto(OA,17:23,CD);
control=[0 0 0];
CD=[control Datos];
escribePto(OA,17:23,CD);
end

