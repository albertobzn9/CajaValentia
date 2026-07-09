function varargout = OA_ValentiaUno(varargin)
% OA_VALENTIAUNO MATLAB code for OA_ValentiaUno.fig
%      OA_VALENTIAUNO, by itself, creates a new OA_VALENTIAUNO or raises the existing
%      singleton*.
%
%      H = OA_VALENTIAUNO returns the handle to a new OA_VALENTIAUNO or the handle to
%      the existing singleton*.
%
%      OA_VALENTIAUNO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIAUNO.M with the given input arguments.
%
%      OA_VALENTIAUNO('Property','Value',...) creates a new OA_VALENTIAUNO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaUno_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaUno_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaUno

% Last Modified by GUIDE v2.5 30-Nov-2012 11:48:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_ValentiaUno_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_ValentiaUno_OutputFcn, ...
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


% --- Executes just before OA_ValentiaUno is made visible.
function OA_ValentiaUno_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaUno (see VARARGIN)

% Choose default command line output for OA_ValentiaUno
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaUno wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%establecemos comunicacion con el equipo
daqreset
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



% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaUno_OutputFcn(hObject, eventdata, handles) 
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


Riesgo=str2num(get(handles.edit1,'String'));
TipoSecuencia=get(handles.checkbox1,'Value');
%con el valor de riesgo y el tipo de secuencia se genera una secuencia de
%500 ensayos
[Secuencia]=OA_SecuenciaEnsayos(TipoSecuencia,Riesgo);



set(handles.Inicio,'String','Ejecutando');

PalXRec=str2num(get(handles.edit5,'String'));

if(PalXRec<=0)
    PalXRec=1;
end 

Ensayo=1;

while(CT_Ejecuta==1);
    
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
            pause(1)
       end 
        if(Secuencia(Ensayo,2)==0)
            OA_ValentiaEstimuloI(handles.OA,0,1);
            ES=0;
            EL=1;
        end
        if(Secuencia(Ensayo,2)==1)
            OA_ValentiaElectrico(handles.OA,1)
            OA_ValentiaEstimuloI(handles.OA,2,2);
            ES=2;
            EL=2;
        end
        tic
        OA_ValentiaResetPalancas(handles.OA)
         [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
         DDA=DI

         while(1)
             [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
             if(DI>=PalXRec)
                Resultados=[Resultados;[Ensayo 1 Secuencia(Ensayo,2) toc]]; 
                set(handles.uitable1,'Data',Resultados); 
                load('RetardoRecomp','RetardoRecomp');
                pause(RetardoRecomp);
                load('PelletsEvento','PelletsEvento');
                for iR=1:PelletsEvento
                    OA_ValentiaRecompensaI(handles.OA);
                    pause(.5)
                end    
                 break
             end  
             DDA=DI;
             pause(.1);
             load('ControlTarea');
             if(CT_Ejecuta==0)
                break;
             end    
         end   
          Ensayo=Ensayo+1; 
     end  %ensayo lado izquierdo   
 
     
     
     %realizar ensayo lado derecho
     if(strcmp(Lado,'I')==1) 
       
        if(SonidoIni==1) 
        OA_ValentiaEstimuloD(handles.OA,1,1);
        pause(1)
       end 

        if(Secuencia(Ensayo,2)==0)
            OA_ValentiaEstimuloD(handles.OA,0,1);
        end
        if(Secuencia(Ensayo,2)==1)
            OA_ValentiaElectrico(handles.OA,1);
            OA_ValentiaEstimuloD(handles.OA,2,2);
        end
         OA_ValentiaResetPalancas(handles.OA);
         [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
         DDA=DD
         tic
         while(1)
             [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
             if(DD>=PalXRec)
                Resultados=[Resultados;[Ensayo 0 Secuencia(Ensayo,2) toc]]; 
                set(handles.uitable1,'Data',Resultados); 
                load('RetardoRecomp','RetardoRecomp');
                pause(RetardoRecomp);
                load('PelletsEvento','PelletsEvento');
                for iR=1:PelletsEvento
                    OA_ValentiaRecompensaD(handles.OA);
                    pause(.5)
                end    
                break
             end 
             DDA=DD;
             pause(.1);
             load('ControlTarea');
             if(CT_Ejecuta==0)
                break;
             end    
         end   
          Ensayo=Ensayo+1; 
     end  %ensayo lado derecho   
     
    OA_ValentiaElectrico(handles.OA,0) 
    OA_ValentiaEstimuloI(handles.OA,0,0)
    OA_ValentiaEstimuloD(handles.OA,0,0)   
    pause(2); 
    load('ControlTarea');
    if(CT_Ejecuta==0)
        break;
    end  
    FinEnsayos=str2num(get(handles.edit4,'String'))
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

%RetardoRecomp=str2double(get(hObject,'String'));
%save('RetardoRecomp','RetardoRecomp');


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


figure(2)
clf


ID=[];
DI=[];
II=[];
DD=[];
for i=1:size(RS,1)-1
    %buscamos todos los de izquierda a derecha
    if((RS(i,2)==1)&(RS(i+1,2)==0))
        ID=[ID;[i RS(i+1)]];
    end
    %buscamos todos los de  derecha a izquierda
    if((RS(i,2)==0)&(RS(i+1,2)==1))
        DI=[DI;[i RS(i+1)]];
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
subplot(2,3,1)
hold on
bar(1,mean(RS(ID(:,2),4)),'w')
errorbar(1,mean(RS(ID(:,2),4)),std(RS(ID(:,2),4)));
xlim([0 2]);
drawnow;
xlabel('Izq Der');
ylabel('tiempo [s]');

subplot(2,3,2)
hold on
bar(1,mean(RS(DI(:,2),4)),'w')
errorbar(1,mean(RS(DI(:,2),4)),std(RS(DI(:,2),4)));
xlim([0 2]);
drawnow;
xlabel('Der Izq');
ylabel('tiempo [s]');

cruces=[ID;DI];

subplot(2,3,3)
hold on
bar(1,mean(RS(cruces(:,2),4)),'w')
errorbar(1,mean(RS(cruces(:,2),4)),std(RS(cruces(:,2),4)));
xlim([0 2]);
drawnow;
etiq=strcat('Cruces :',num2str(mean(RS(cruces(:,2),4))),'+-',num2str(std(RS(cruces(:,2),4))));
xlabel(etiq);
ylabel('tiempo [s]');


Nocruces=[II;DD];


subplot(2,3,4)
hold on
bar(1,mean(RS(II(:,2),4)),'w')
errorbar(1,mean(RS(II(:,2),4)),std(RS(II(:,2),4)));
xlim([0 2]);
drawnow;
xlabel('Izq Izq');
ylabel('tiempo [s]');



subplot(2,3,5)
hold on
bar(1,mean(RS(DD(:,2),4)),'w')
errorbar(1,mean(RS(DD(:,2),4)),std(RS(DD(:,2),4)));
xlim([0 2]);
drawnow;
xlabel('Der Der');
ylabel('tiempo [s]');


subplot(2,3,6)
hold on
bar(1,mean(RS(Nocruces(:,2),4)),'w')
errorbar(1,mean(RS(Nocruces(:,2),4)),std(RS(Nocruces(:,2),4)));
xlim([0 2]);
drawnow;
etiq2=strcat('No cruces :',num2str(mean(RS(Nocruces(:,2),4))),'+-',num2str(std(RS(Nocruces(:,2),4))));
xlabel(etiq2);
ylabel('tiempo [s]');


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
