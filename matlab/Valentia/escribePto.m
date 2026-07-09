function escribePto(OA,BE,DE)

DL=getvalue(OA.Line(9:24));
DL(BE-8)=DE;
putvalue(OA.Line([9:24]),DL);
