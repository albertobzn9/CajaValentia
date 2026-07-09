function GraficaValentia
%copia de la funcion que se ejecuta en ValentiaUnoCP


viejo=pwd;
cd('C:\Users\fsotres\Documents\experimentos');

[file,path]=uigetfile('*.mat');
cd(viejo)

load(strcat(path,file));
if(size(Resultados,1)>0)
%load('C:\Users\fsotres\Documents\MATLAB\Valentia\OA_Resultados','Resultados');
RS=Resultados;


figure(2)
clf


ID=[];
DI=[];
IDE=[];
DIE=[];
II=[];
DD=[];
for i=1:size(RS,1)-1
    %buscamos todos los de izquierda a derecha
    if((RS(i,2)==1)&&(RS(i+1,2)==0)&&(RS(i+1,3)==0))
        ID=[ID;[i RS(i+1)]];
    end
    %buscamos todos los de  derecha a izquierda
    if((RS(i,2)==0)&&(RS(i+1,2)==1)&&(RS(i+1,3)==0))
        DI=[DI;[i RS(i+1)]];
    end
    %buscamos todos los de izquierda a derecha con electrico
    if((RS(i,2)==1)&&(RS(i+1,2)==0)&&(RS(i+1,3)==1))
        IDE=[IDE;[i RS(i+1)]];
    end
    %buscamos todos los de  derecha a izquierda con electrico
    if((RS(i,2)==0)&&(RS(i+1,2)==1)&&(RS(i+1,3)==1))
        DIE=[DIE;[i RS(i+1)]];
    end
    
    
    %buscamos todos los de izquierda a izquierda
    if((RS(i,2)==1)&(RS(i+1,2)==1))
        II=[II;[i RS(i+1)]];
    end
    %buscamos todos los de derecha a derecha
    if((RS(i,2)==0)&(RS(i+1,2)==0))
        DD=[DD;[i RS(i+1)]];
    end
end
subplot(3,3,1)
hold on
bar(1,mean(RS(ID(:,2),4)),'w')
errorbar(1,mean(RS(ID(:,2),4)),std(RS(ID(:,2),4))/(sqrt(size(ID,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Izq Der');
ylabel('tiempo [s]');

subplot(3,3,2)
hold on
bar(1,mean(RS(DI(:,2),4)),'w')
errorbar(1,mean(RS(DI(:,2),4)),std(RS(DI(:,2),4))/(sqrt(size(DI,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Der Izq');
ylabel('tiempo [s]');

cruces=[ID;DI];

subplot(3,3,3)
hold on
bar(1,mean(RS(cruces(:,2),4)),'w')
errorbar(1,mean(RS(cruces(:,2),4)),std(RS(cruces(:,2),4))/(sqrt(size(cruces,1)-1)));
xlim([0 2]);
drawnow;
etiq=strcat('Cruces :',num2str(mean(RS(cruces(:,2),4))),'+-',num2str(std(RS(cruces(:,2),4))/(sqrt(size(cruces,1)-1))));
xlabel(etiq);
ylabel('tiempo [s]');


Nocruces=[II;DD];


subplot(3,3,4)
hold on
bar(1,mean(RS(II(:,2),4)),'w')
errorbar(1,mean(RS(II(:,2),4)),std(RS(II(:,2),4))/(sqrt(size(II,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Izq Izq');
ylabel('tiempo [s]');



subplot(3,3,5)
hold on
bar(1,mean(RS(DD(:,2),4)),'w')
errorbar(1,mean(RS(DD(:,2),4)),std(RS(DD(:,2),4))/(sqrt(size(DD,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Der Der');
ylabel('tiempo [s]');


subplot(3,3,6)
hold on
bar(1,mean(RS(Nocruces(:,2),4)),'w')
errorbar(1,mean(RS(Nocruces(:,2),4)),std(RS(Nocruces(:,2),4))/(sqrt(size(Nocruces,1)-1)));
xlim([0 2]);
drawnow;
etiq2=strcat('No cruces :',num2str(mean(RS(Nocruces(:,2),4))),'+-',num2str(std(RS(Nocruces(:,2),4))/(sqrt(size(Nocruces,1)-1))));
xlabel(etiq2);
ylabel('tiempo [s]');




%electricos

subplot(3,3,7)
hold on
bar(1,mean(RS(IDE(:,2),4)),'w')
errorbar(1,mean(RS(IDE(:,2),4)),std(RS(IDE(:,2),4))/(sqrt(size(IDE,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Izq Der Elect');
ylabel('tiempo [s]');

subplot(3,3,8)
hold on
bar(1,mean(RS(DIE(:,2),4)),'w')
errorbar(1,mean(RS(DIE(:,2),4)),std(RS(DIE(:,2),4))/(sqrt(size(DIE,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Der Izq Elect');
ylabel('tiempo [s]');

crucesE=[IDE;DIE];

subplot(3,3,9)
hold on
bar(1,mean(RS(crucesE(:,2),4)),'w')
errorbar(1,mean(RS(crucesE(:,2),4)),std(RS(crucesE(:,2),4))/(sqrt(size(crucesE,1)-1)));
xlim([0 2]);
drawnow;
etiq=strcat('Cruces Elect :',num2str(mean(RS(crucesE(:,2),4))),'+-',num2str(std(RS(crucesE(:,2),4))/(sqrt(size(crucesE,1)-1))));
xlabel(etiq);
ylabel('tiempo [s]');













end


