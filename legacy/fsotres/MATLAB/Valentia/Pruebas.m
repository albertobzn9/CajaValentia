function Pruebas

 GS=OA_PreparaSonidos;
 OA = OA_ValentiaInicio;
 
 pause(2)
 
 %OA_ValentiaRecompensaI(OA)
 
 pause(2)
 
 %OA_ValentiaRecompensaD(OA)
 
 pause(2)
 
 
 
 for i=1:500
     
   
      OA_Sonidos(GS,2,15000,1,0,0)
      OA_ValentiaEstimuloI(OA,0,1); 
      
      OA_ValentiaEstimuloD(OA,2,0)

      OA_ValentiaElectrico(OA,1)
      
      pause(3)
      
      OA_ValentiaEstimuloI(OA,0,0);
      OA_ValentiaElectrico(OA,0)
      
     pause (4)
 
 
 
      OA_Sonidos(GS,2,15000,1,0,0)
      OA_ValentiaEstimuloD(OA,0,1); 
      
      OA_ValentiaEstimuloD(OA,2,0)

      OA_ValentiaElectrico(OA,1)
      
      pause(3)
      
      
      OA_ValentiaEstimuloD(OA,0,0);
      OA_ValentiaElectrico(OA,0)
      
 
 
 end    
 
 
 
 
 

