function varargout = OA_ValentiaTresCP(varargin)
% OA_VALENTIATRESCP MATLAB code for OA_ValentiaTresCP.fig
%      OA_VALENTIATRESCP, by itself, creates a new OA_VALENTIATRESCP or raises the existing
%      singleton*.
%
%      H = OA_VALENTIATRESCP returns the handle to a new OA_VALENTIATRESCP or the handle to
%      the existing singleton*.
%
%      OA_VALENTIATRESCP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIATRESCP.M with the given input arguments.
%
%      OA_VALENTIATRESCP('Property','Value',...) creates a new OA_VALENTIATRESCP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaTresCP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaTresCP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaTresCP

% Last Modified by GUIDE v2.5 21-Mar-2013 13:57:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_ValentiaTresCP_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_ValentiaTresCP_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



%Los resultados se guardan con el siguiente formato:
%[Ensayo 1 Electrico Latencia Tiempo ContadorTotalIzq ContadorTotalDer]]; 
%Ensayo: numero de ensayo
%Lado:1 izquierdo, 0 Derecho
%Electrico: 0 sin corriente, 1 con corriente
%Latencia: tiempo que tarda la rata en presionar una vez que prendio la luz
%Tiempo transcurrido desde el inicio del experimento
%ContadorTotalIzq 
%ContadorTotalDer






% --- Executes just before OA_ValentiaTresCP is made visible.
function OA_ValentiaTresCP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaTresCP (see VARARGIN)

% Choose default command line output for OA_ValentiaTresCP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaTresCP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%establecemos comunicacion con el equipo
daqreset
GS=OA_PreparaSonidos;
handles.OA = OA_ValentiaInicio;
handles.Luz=0;
handles.Sonido=0;
handles.SonidoInt=0;
handles.LuzInt=0;
guidata(hObject, handles);

cd('C:\Users\fsotres\Documents\MATLAB\Valentia\')

%preparamos las recompensas
RD=[0 1];RI=[0 1];
save('C:\Users\fsotres\Documents\MATLAB\Valentia\DatosValentia','RD','RI');

%apagamos los estimulos
OA_ValentiaEstimuloI(handles.OA,0,0)
OA_ValentiaEstimuloD(handles.OA,0,0)

%sacamos las dos palancas
OA_ValentiaPalanca(handles.OA,'I',1); 
OA_ValentiaPalanca(handles.OA,'D',1); 
OA_ValentiaResetPalancas(handles.OA)

CT_Ejecuta=0;
CT_Pausa=0;
CT_Ensayos=0;
save('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos');

set(handles.edit1,'String','0');
set(handles.edit2,'String','0');
set(handles.edit3,'String','1');  %pellets por recompensa
set(handles.edit4,'String','100'); %ensayos a realizar
set(handles.edit5,'String','1'); %palancas por recompensa
set(handles.edit6,'String','0'); %ensayos a realizar
set(handles.edit7,'String','0'); %palancas por recompensa
set(handles.edit8,'String','120'); %maxima duracion de ensayo (s)
set(handles.edit9,'String','0'); %frecuencia del estimulo auditivo
set(handles.edit10,'String','1000'); %maxima duracion de ensayo (s)




% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaTresCP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Inicio.
function Inicio_Callback(hObject, eventdata, handles)
% hObject    handle to Inicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



load('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos');
CT_Ejecuta=1;
save('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos');

Ensayo=0;
Resultados=[];
ContadorTD=0;
ContadorTI=0; 
TultimaP=0;

Riesgo=str2num(get(handles.edit1,'String'));
TipoSecuencia=get(handles.checkbox1,'Value');
%con el valor de riesgo y el tipo de secuencia se genera una secuencia de
%500 ensayos
[Secuencia]=OA_SecuenciaEnsayos(TipoSecuencia,Riesgo);


%limpiamos contadores de palanqueos
set(handles.edit6,'String','0'); %lado izq
set(handles.edit7,'String','0'); %lado der 

set(handles.Inicio,'String','Ejecutando');

PalXRec=str2num(get(handles.edit5,'String'));

if(PalXRec<=0)
    PalXRec=1;
end 

Ensayo=1;
R1=tic;
R0=tic;
TultimaPalanca=toc(R1);
while(CT_Ejecuta==1);% ciclo principal aqui se mantiene hasta terminar los n ensayos
    
     OA_ValentiaPalanca(handles.OA,'I',1); %nos aseguramos que la palanca izq este afuera 
     OA_ValentiaPalanca(handles.OA,'D',1); %nos aseguramos que la palanca der este afuera 


    EnsayoMismoLado=0;
    if((Ensayo>1)&&(Secuencia(Ensayo-1,1)==Secuencia(Ensayo,1)))
        EnsayoMismoLado=1
        load('RetardoRecomp','RetardoRecomp');
        IntVar=2*RetardoRecomp*rand(1,1); %intervalo variable uniformemente distribuido 
    end    
    
    DurMaxEns=str2num(get(handles.edit8,'String'))
    
    
    caso=Secuencia(Ensayo,1)    
    if(caso==1)
        Lado='I';
    elseif(caso==0)
        Lado='D';
    end  
    
     SonidoIni=get(handles.checkbox2,'Value');
    %realizar ensayo lado izquierdo
    if(strcmp(Lado,'D')==1)
      
       if(SonidoIni==1) 
            OA_ValentiaEstimuloI(handles.OA,1,1);
            pause(.1)
       end 
        if(Secuencia(Ensayo,2)==0)
            OA_ValentiaEstimuloI(handles.OA,0,1);
            ES=0;
            EL=1;
        end
        if(Secuencia(Ensayo,2)==1)
            OA_ValentiaEstimuloI(handles.OA,0,2); %dejamos sonido apagado luz intermitente
            ES=2;
            EL=2;
            OA_ValentiaElectrico(handles.OA,1);
        end
        R2=tic;
        OA_ValentiaResetPalancas(handles.OA);
         [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
         DIA=DI;
         DDA=DD;
         
         P=0;
         LatMI=tic;
         CDurMaxEns=1;
         while(P==0)
            [P]=OA_ValentiaBuscaIzquierda(handles.OA);
            if(toc(LatMI)>DurMaxEns)
                CDurMaxEns=0;
                break;
            end
            set(handles.edit9,'String',num2str(toc(LatMI)));
            pause(.01);
         end
         
         if(CDurMaxEns==1) %si la rata cruzo
         LatMotIzq=toc(LatMI);

         while(1)
 
             [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
             if(DIA~=DI)
                 ContadorTI=ContadorTI+1;
                 set(handles.edit6,'String',num2str(ContadorTI)); %lado izq
             end
             if(DDA~=DD)
                 ContadorTD=ContadorTD+1;
                 set(handles.edit7,'String',num2str(ContadorTD)); %lado der
             end
             if((DI>=PalXRec)&& EnsayoMismoLado==0) %%si no se repite el mismo lado
                TultimaPalanca=toc(R1); %guardamos el tiempo de la ultima palanca 
                Resultados=[Resultados;[Ensayo 1 Secuencia(Ensayo,2) toc(R2) toc(R0) ContadorTI ContadorTD LatMotIzq]]; 
                set(handles.uitable1,'Data',Resultados); 
                load('PelletsEvento','PelletsEvento');
                for iR=1:PelletsEvento
                    OA_ValentiaRecompensaI(handles.OA);
                    pause(.1)
                end  
                 break
             end  
             
             if((DI>=PalXRec)&& EnsayoMismoLado==1) %%si se repite el mismo lado
                if(toc(R1)>(TultimaPalanca+IntVar))
                    TultimaPalanca=toc(R1);  %guardamos el tiempo de la ultima palanca  
                    Resultados=[Resultados;[Ensayo 1 Secuencia(Ensayo,2) toc(R2) toc(R0) ContadorTI ContadorTD LatMotIzq]]; 
                    set(handles.uitable1,'Data',Resultados); 
                    load('PelletsEvento','PelletsEvento');
                    for iR=1:PelletsEvento
                        OA_ValentiaRecompensaI(handles.OA);
                        pause(.1)
                    end  
                    break
                end
             end  
             
             
             DIA=DI;
             DDA=DD;
             pause(.1);
             load('ControlTarea');
             if(CT_Ejecuta==0)
                break;
             end    
         end  
         end %si la rata cruza antes de la duracion máxima
          Ensayo=Ensayo+1; 
     end  %ensayo lado izquierdo   
 
     
     
     %realizar ensayo lado derecho
     if(strcmp(Lado,'I')==1) 
       
        if(SonidoIni==1) 
            OA_ValentiaEstimuloD(handles.OA,1,1);
            pause(.1)
        end 

        if(Secuencia(Ensayo,2)==0)
            OA_ValentiaEstimuloD(handles.OA,0,1);
        end
        if(Secuencia(Ensayo,2)==1)
            OA_ValentiaEstimuloD(handles.OA,0,2); %dejamos sonido apagado luz intermitente
            OA_ValentiaElectrico(handles.OA,1);
        end
        
         R2=tic;
         OA_ValentiaResetPalancas(handles.OA);
         [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
         DDA=DD;
         DIA=DI;
         
         P=0;
         LatMD=tic;
         CDurMaxEns=1;
         while(P==0)
            [P]=OA_ValentiaBuscaDerecha(handles.OA);
             if(toc(LatMD)>DurMaxEns)
                CDurMaxEns=0;
                break;
             end  
            set(handles.edit9,'String',num2str(toc(LatMD)));
            pause(.01);
         end
         if(CDurMaxEns==1) %si la rata cruzo
         
         LatMotDer=toc(LatMD);
         
       
         while(1)
             [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
             if(DIA~=DI)
                 ContadorTI=ContadorTI+1;
                 set(handles.edit6,'String',num2str(ContadorTI)); %lado izq
             end
             if(DDA~=DD)
                 ContadorTD=ContadorTD+1;
                 set(handles.edit7,'String',num2str(ContadorTD)); %lado der
             end
             if((DD>=PalXRec)&& EnsayoMismoLado==0)
                TultimaPalanca=toc(R1) %guardamos el tiempo de la ultima palanca 
                Resultados=[Resultados;[Ensayo 0 Secuencia(Ensayo,2) toc(R2) toc(R0) ContadorTI ContadorTD LatMotDer]]; 
                set(handles.uitable1,'Data',Resultados); 
                load('PelletsEvento','PelletsEvento');
                for iR=1:PelletsEvento
                    OA_ValentiaRecompensaD(handles.OA);
                    pause(.1)
                end  
                break
             end 
             
             if((DD>=PalXRec)&& EnsayoMismoLado==1)
                if(toc(R1)>(TultimaPalanca+IntVar))
                    TultimaPalanca=toc(R1) %guardamos el tiempo de la ultima palanca 
                    Resultados=[Resultados;[Ensayo 0 Secuencia(Ensayo,2) toc(R2) toc(R0) ContadorTI ContadorTD LatMotDer]]; 
                    set(handles.uitable1,'Data',Resultados); 
                    load('PelletsEvento','PelletsEvento');
                    for iR=1:PelletsEvento
                        OA_ValentiaRecompensaD(handles.OA);
                        pause(.1)
                    end 
                    break
                end
             end 
             
             
             
             DDA=DD;
             DIA=DI;
             pause(.1);
             load('ControlTarea');
             if(CT_Ejecuta==0)
                break;
             end    
         end   
         end %si la rata cruza antes de la duracion máxima
          Ensayo=Ensayo+1; 
     end  %ensayo lado derecho   
     
    OA_ValentiaElectrico(handles.OA,0) 
    OA_ValentiaEstimuloI(handles.OA,0,0)
    OA_ValentiaEstimuloD(handles.OA,0,0)   
    pause(.2); 
    OA_CtrlDispIzqCero(handles.OA);
    load('ControlTarea');
    if(CT_Ejecuta==0)
        break;
    end  
    FinEnsayos=str2num(get(handles.edit4,'String'));
    if(Ensayo>=FinEnsayos)
        break
    end    
    
end    


set(handles.Inicio,'String','Inicio');
save('C:\Users\fsotres\Documents\MATLAB\Valentia\OA_Resultados','Resultados');
msgbox('Fin de la secuencia')



% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Terminarn2.
function Terminarn2_Callback(hObject, eventdata, handles)
% hObject    handle to Terminarn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos');
CT_Ejecuta=0;
save('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos');


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
    OA_ValentiaEstimuloI(handles.OA,0,0)
    OA_ValentiaEstimuloD(handles.OA,0,0)   
try
daqreset
catch
end    
delete(hObject);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Riesgo=str2double(get(hObject,'String'));
save('Riesgo','Riesgo');


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('C:\Users\fsotres\Documents\MATLAB\Valentia\OA_Resultados','Resultados');
viejo=pwd;
cd('C:\Users\fsotres\Documents\experimentos');
[fname,pname]=uiputfile('*.mat','nombre y ruta para guardar resultados');
save(strcat(pname,fname),'Resultados');
cd(viejo);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

RetardoRecomp=str2double(get(hObject,'String'));
save('RetardoRecomp','RetardoRecomp');


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PelletsEvento=str2double(get(hObject,'String'));
save('PelletsEvento','PelletsEvento');



% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get(hObject,'Value') 


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
viejo=pwd;
cd('C:\Users\fsotres\Documents\experimentos');

[file,path]=uigetfile('*.mat');
cd(viejo)

load(strcat(path,file));
if(size(Resultados,1)>0)
%load('C:\Users\fsotres\Documents\MATLAB\Valentia\OA_Resultados','Resultados');
RS=Resultados;
RSM=Resultados;
RSM(:,4)=RSM(:,8);


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
title('Latencias de Palanca');


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

try
subplot(3,3,7)
hold on
bar(1,mean(RS(IDE(:,2),4)),'w')
errorbar(1,mean(RS(IDE(:,2),4)),std(RS(IDE(:,2),4))/(sqrt(size(IDE,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Izq Der Elect');
ylabel('tiempo [s]');
catch
end 
   

try
subplot(3,3,8)
hold on
bar(1,mean(RS(DIE(:,2),4)),'w')
errorbar(1,mean(RS(DIE(:,2),4)),std(RS(DIE(:,2),4))/(sqrt(size(DIE,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Der Izq Elect');
ylabel('tiempo [s]');
catch
end    

try
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

catch
end    



%ahora hacemos lo mismo pero con las latencias de desplazamiento

figure(3)
clf
RS=RSM; %usamos el mismo codigo, solo sustituimos por la matriz de respaldo


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
title('Latencias de Desplazamiento');

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

try
subplot(3,3,7)
hold on
bar(1,mean(RS(IDE(:,2),4)),'w')
errorbar(1,mean(RS(IDE(:,2),4)),std(RS(IDE(:,2),4))/(sqrt(size(IDE,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Izq Der Elect');
ylabel('tiempo [s]');
catch
end 
   

try
subplot(3,3,8)
hold on
bar(1,mean(RS(DIE(:,2),4)),'w')
errorbar(1,mean(RS(DIE(:,2),4)),std(RS(DIE(:,2),4))/(sqrt(size(DIE,1)-1)));
xlim([0 2]);
drawnow;
xlabel('Der Izq Elect');
ylabel('tiempo [s]');
catch
end    

try
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

catch
end    








end






function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
