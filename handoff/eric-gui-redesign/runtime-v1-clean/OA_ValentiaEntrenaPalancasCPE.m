function varargout = OA_ValentiaEntrenaPalancasCPE(varargin)
% OA_VALENTIAENTRENAPALANCASCPE M-file for OA_ValentiaEntrenaPalancasCPE.fig
%      OA_VALENTIAENTRENAPALANCASCPE, by itself, creates a new OA_VALENTIAENTRENAPALANCASCPE or raises the existing
%      singleton*.
%
%      H = OA_VALENTIAENTRENAPALANCASCPE returns the handle to a new OA_VALENTIAENTRENAPALANCASCPE or the handle to
%      the existing singleton*.
%
%      OA_VALENTIAENTRENAPALANCASCPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIAENTRENAPALANCASCPE.M with the given input arguments.
%
%      OA_VALENTIAENTRENAPALANCASCPE('Property','Value',...) creates a new OA_VALENTIAENTRENAPALANCASCPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaEntrenaPalancasCPE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaEntrenaPalancasCPE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaEntrenaPalancasCPE

% Last Modified by GUIDE v2.5 21-Feb-2014 19:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_ValentiaEntrenaPalancasCPE_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_ValentiaEntrenaPalancasCPE_OutputFcn, ...
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


% --- Executes just before OA_ValentiaEntrenaPalancasCPE is made visible.
function OA_ValentiaEntrenaPalancasCPE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaEntrenaPalancasCPE (see VARARGIN)

% Choose default command line output for OA_ValentiaEntrenaPalancasCPE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaEntrenaPalancasCPE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%se inicializan las interfaces de National Instruments presentes en el
%sistema
daqreset

%se usa la función OA_ValentiaInicio para dar de alta la interfaz de
%National Instruments asociada a la tarea OA_Valentia
handles.OA = OA_ValentiaInicio;
%la referencia handles.OA se utiliza en las funciones de control
%para las luces, sonidos, recompensa, palancas, contadores de las palancas
%y estimulo electrico

handles.GS=OA_PreparaSonidos;  %sonidos

%inicializamos todas las variables de control

%estimulos izquierda
handles.Luz=0;
handles.Sonido=0;
handles.SonidoInt=0;
handles.LuzInt=0;

%estimulos derecha
handles.LuzD=0;
handles.SonidoD=0;
handles.SonidoIntD=0;
handles.LuzIntD=0;

%contadores de las palancas
handles.ContadorI=0;
handles.ContadorD=0;

handles.PalancasIzqSinLuz=0;
handles.PalancasDerSinLuz=0;

handles.PalancasHabIniD=0;
handles.PalancasHabIniI=0;
handles.PalancasHabFinI=0;
handles.PalancasHabFinD=0;

handles.TiempoSinLuzTotal=0;


%cambiamos al directorio de trabajo
cmc_setup_paths();
cd(cmc_state_dir())



%cargamos el valor de  retardo de la recompensa
load('RetardoRecomp','RetardoRecomp');
set(handles.edit3,'String',num2str(RetardoRecomp));

%cargamos el numero de pellets que se dan por evento
load('PelletsEvento','PelletsEvento');
set(handles.edit4,'String',num2str(PelletsEvento));

%asignamos valores inciales a las ventanas de contadores de palancas y
%tiempo
set(handles.edit5,'String','0'); %contador de palancas I
set(handles.edit6,'String','0'); %contador de palancas D
set(handles.edit7,'String','0'); %contador de tiempo I
set(handles.edit8,'String','0'); %contador de tiempo D

DurMaxExp=inputdlg('Duración máxima del experimento [minutos]');
set(handles.edit10,'String',str2num(DurMaxExp{1,1})); %dur max del experimento
set(handles.edit11,'String','0');

%valores de frecuencia para los sonidos

set(handles.edit12,'String','1000');
set(handles.edit13,'String','1000');


handles.TFin=tic;

OA_ValentiaPalanca(handles.OA,'I',1); %sale la palanca izquierda
pause(1)
OA_ValentiaPalanca(handles.OA,'D',1); %sale la palanca derecha
pause(1)


guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaEntrenaPalancasCPE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;






% --- Executes on button press in pushbutton4.  Usar lado  Izquierdo
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Esta función es el control del lado Izquierdo

%La variable Control es la bandera para permanecer en el ciclo
%la inicializamos a cero y la guardamos 
Control=0;
save('controlEnt','Control');

%usamos la función  OA_ValentiaEstimulo para asegurarnos que las luces
%del lado derecho estan apagadas
OA_ValentiaEstimuloI(handles.OA,0,0)
OA_ValentiaEstimuloD(handles.OA,0,0)

%usamos la función OA_ValentiaPalanca para asegurarnos que la palanca 
%del lado derecho esta oculta
%OA_ValentiaPalanca(handles.OA,'D',2); 

%leemos los valores asociados a las luces   y los sonidos
%y las asignamos a las variables EstimS y EstimL respectivamanete
EstimS=handles.Sonido+handles.Sonido*handles.SonidoInt;
EstimL=handles.Luz+handles.Luz*handles.LuzInt;

%usamos la función OA_ValentiaEstimulo para que luces y sonidos
%se enciendan de acuerdo a lo solicitado en el lado Izquierdo
OA_ValentiaEstimuloI(handles.OA,EstimS,EstimL);
stop(handles.GS);
if(EstimS>0)
     FIzq=str2num(get(handles.edit12,'String'));
     OA_Sonidos(handles.GS,300,FIzq,1,0,0);
end     
%hacemos una pausa de medio segundo
pause(.5)
%sacamos la palanca del lado Izquierdo al mandar una 'I' y un 1 
%a la función OA_ValentiaPalanca
OA_ValentiaPalanca(handles.OA,'I',1); 
%limpiamos el contador de eventos de las palancas
OA_ValentiaResetPalancas(handles.OA)

%asignamos el valor 1 a la variable control  para ingresar al ciclo
Control=1;
%y la salvamos
save('controlEnt','Control')

tic;

%leemos el valor del contador de eventos de la palanca
[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA)
%guardamos el valor del contador del lado izquierdo en una variable
%auxiliar
DDA=DI;

%permanecemos en un ciclo hasta que Control sea igual a cero

IntVar=0;
TultimaPalanca=0;
ContadorPI=0;
set(handles.edit5,'String',num2str(ContadorPI));
handles.ContadorI=0;
guidata(hObject, handles);
set(handles.edit1,'String',num2str(handles.ContadorI));
contPalanIzqLuz=0;
contPalanIzqSinLuz=0;
while(Control==1)
    RazonVariable=str2num(get(handles.edit16,'String'))+round(rand(1,1)*(str2num(get(handles.edit17,'String'))-str2num(get(handles.edit16,'String'))))
    while(contPalanIzqLuz<=RazonVariable)
    set(handles.edit7,'string',num2str(toc));
    set(handles.edit11,'String',num2str(toc(handles.TFin)/60));
    if((toc(handles.TFin)/60)>=(str2num(get(handles.edit10,'String'))))
        msgbox('fin de experimento')
        break
    end    
    %leemos el valor del contador de eventos de la palanca
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA)
    %si se modifico el valor del contador de eventos entonces la rata lo
    %presiono
    if(DI~=DDA)
        if(toc>(TultimaPalanca+IntVar))
            TultimaPalanca=toc;
            %si lo presiono actualizamos el contador
            handles.ContadorI=handles.ContadorI+1;
            guidata(hObject, handles);
            set(handles.edit1,'String',num2str(handles.ContadorI));
            %leemos cuantos pellets debemos dar
            PelletsEvento=str2num(get(handles.edit4,'String'));
            %entramos en un ciclo para dar los pellets
            for i=1:PelletsEvento
                %usamos la funcion OA_ValentiaRecompensaI para activar el
                %dispensador del lado izquierdo
                OA_ValentiaRecompensaI(handles.OA);
                pause(1)
            end
            contPalanIzqLuz=contPalanIzqLuz+1;
        end
        ContadorPI=ContadorPI+1;
        set(handles.edit5,'String',num2str(ContadorPI));
        %leemos cual es el valor del retardo asociado al intervalo variable
        load('RetardoRecomp','RetardoRecomp');
        IntVar=2*RetardoRecomp*rand(1,1); %intervalo variable uniformemente distribuido 
        %IntVar=2*RetardoRecomp*((abs(randn(1,1))+3.5)/7); %intervalo variable normalmente distribuido
   %%%     pause(IntVar);
        DDA=DI;
    end
    if(DI==15)
        OA_ValentiaResetPalancas(handles.OA)
    end     
    
    
    
    %verificamos si el entrenador activo el control manual para dar
    %recompensa para eso leemos el archivo controlPellet
    pause(.1)
    load('controlPellet','Pellet')
    if(Pellet==1)
        %de ser asi entonces usamos la funcion OA_ValentiaRecompensaI_est para activar el
            %dispensador del lado izquierdo
       OA_ValentiaRecompensaI(handles.OA)
       %apagamos la bandera de solicitud manual de pellet
       Pellet=0;
       save('controlPellet','Pellet')
    end   
    %verificamos si el entrenador quiere que termine la secuencia del lado
    %izquierdo
    load('controlEnt')
    if(Control==0)
       % de ser asi, salimos del ciclo
    Control=0;
    save('controlEnt','Control')
        break
    end  
    end
    InterSinLuz=(str2num(get(handles.edit14,'String'))+rand(1,1)*(str2num(get(handles.edit15,'String'))-str2num(get(handles.edit14,'String')))) %calculamos el intervalo
    tsl=str2num(get(handles.edit26,'String'));
    set(handles.edit26,'String',num2str(tsl+InterSinLuz));
    
    OA_ValentiaEstimuloI(handles.OA,0,0); %apagamos luces y sonidos
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA); %revisamos el valor de la palanca
    DDA=DI;
    %calculamos numero de ciclos de 300 ms que caben en el InterSinLuz
    NumCiclosSinLuz=round(InterSinLuz/0.42);
    for i=1:NumCiclosSinLuz
    %si se modifico el valor del contador de eventos entonces la rata lo
    %presiono
  
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA); %revisamos el valor de la palanca
    if(DI~=DDA)
        handles.PalancasIzqSinLuz=handles.PalancasIzqSinLuz+1;
        set(handles.edit18,'String',num2str(handles.PalancasIzqSinLuz));
        DDA=DI;
    end
    pause(0.3) %esperamos el tiempo variable
  
    end
    OA_ValentiaEstimuloI(handles.OA,0,EstimL); %prendemos las luces
    contPalanIzqLuz=0;
    
    %verificamos si debemos salir del ciclo
    load('controlEnt')
    if(Control==0)
       % de ser asi, salimos del ciclo
    Control=0;
    save('controlEnt','Control')
        break
    end  
    
    
    
end 

%si salimos del ciclo del lado izquierdo apagamos luces y sonidos mediante
%la función OA_ValentiaEstimulo
stop(handles.GS);
OA_ValentiaEstimuloI(handles.OA,0,0)
guidata(hObject, handles);



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%cuando se presiona el boton detener ponemos en cero la bandera Control
Control=0;
save('controlEnt','Control')
%apagamos luces y sonido de ambos lados
OA_ValentiaEstimuloI(handles.OA,0,0)
OA_ValentiaEstimuloD(handles.OA,0,0)

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%cuando el entrenado presiona el botón de dar pellet prendemos la
%bandera correspondiente
Pellet=1;
save('controlPellet','Pellet')


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%cuando se presiona el boton detener ponemos en cero la bandera Control
Control=0;
save('controlEnt','Control')
%apagamos luces y sonido de ambos lados
OA_ValentiaEstimuloD(handles.OA,0,0)
OA_ValentiaEstimuloI(handles.OA,0,0)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%se verifica el valor de la bandera de Luz Izquierda 0 apagada 1 encendida
handles.Luz=get(hObject,'Value'); 
guidata(hObject, handles);
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%se verifica el valor de la bandera de Sonido Izquierda 0 apagada 1 encendida
handles.Sonido=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%se verifica el valor de la bandera de Luz Intermitente Izquierda:
%0 continua 1 parpadea
handles.LuzInt=get(hObject,'Value'); 
guidata(hObject, handles);



% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%se verifica el valor de la bandera de Sonido Intermitente Izquierda:
%0 continua 1 intermitente
handles.SonidoInt=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%se verifica el valor de la bandera de Luz Derecha 0 apagada 1 encendida
handles.LuzD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%se verifica el valor de la bandera de Sonido Derecha 0 apagada 1 encendida
handles.SonidoD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%se verifica el valor de la bandera de Luz Intermitente Derecha:
%0 continua 1 parpadea

handles.LuzIntD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%se verifica el valor de la bandera de Sonido Intermitente Derecha:
%0 continua 1 intermitente

handles.SonidoIntD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in pushbutton12. Usar Derecha
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Esta función es el control del lado Derecho

%La variable Control es la bandera para permanecer en el ciclo
%la inicializamos a cero y la guardamos 
Control=0;
save('controlEnt','Control')

%usamos la función  OA_ValentiaEstimulo para asegurarnos que las luces
%del lado Izquierdo estan apagadas
OA_ValentiaEstimuloI(handles.OA,0,0)
%usamos la función OA_ValentiaPalanca para asegurarnos que la palanca 
%del lado Izquierdo esta oculta
%OA_ValentiaPalanca(handles.OA,'I',2); 

%leemos los valores asociados a las luces   y los sonidos del lado derecho
%y las asignamos a las variables EstimS y EstimL respectivamanete
EstimS=handles.SonidoD+handles.SonidoD*handles.SonidoIntD;
EstimL=handles.LuzD+handles.LuzD*handles.LuzIntD;

%usamos la función OA_ValentiaEstimulo para que luces y sonidos
%se enciendan de acuerdo a lo solicitado en el lado derecho
OA_ValentiaEstimuloD(handles.OA,EstimS,EstimL);
stop(handles.GS);
if(EstimS>0)
     FDer=str2num(get(handles.edit13,'String'));
     OA_Sonidos(handles.GS,300,0,0,FDer,1);
end   
%hacemos una pausa de medio segundo
pause(.5)
%sacamos la palanca del lado Derecho al mandar una 'D' y un 1 
%a la función OA_ValentiaPalanca
OA_ValentiaPalanca(handles.OA,'D',1); 
%limpiamos el contador de eventos de las palancas
OA_ValentiaResetPalancas(handles.OA); %no usar ResetPalanca antes de Palanca

%asignamos el valor 1 a la variable control  para ingresar al ciclo
Control=1;
%y la salvamos
save('controlEnt','Control')
Contador=0;

tic

%leemos el valor del contador de eventos de la palanca
[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
%guardamos el valor del contador del lado derecho en una variable
%auxiliar
DDA=DD;

IntVar=0;
TultimaPalanca=0;
ContadorPD=0;
set(handles.edit6,'String',num2str(ContadorPD));
handles.ContadorD=0;
guidata(hObject, handles);
set(handles.edit2,'String',num2str(handles.ContadorD));
contPalanDerLuz=0;
contPalanDerSinLuz=0;
while(Control==1)
    RazonVariable=str2num(get(handles.edit16,'String'))+round(rand(1,1)*(str2num(get(handles.edit17,'String'))-str2num(get(handles.edit16,'String'))))
    while(contPalanDerLuz<=RazonVariable)
    set(handles.edit8,'string',num2str(toc));
    set(handles.edit11,'String',num2str(toc(handles.TFin)/60));
    if((toc(handles.TFin)/60)>=(str2num(get(handles.edit10,'String'))))
        msgbox('fin de experimento')
        break
    end    


      %leemos el valor del contador de eventos de la palanca
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
     %si se modifico el valor del contador de eventos entonces la rata lo
    %presiono

    if(DD~=DDA)
        if(toc>(TultimaPalanca+IntVar))
            TultimaPalanca=toc;    
            %     %si lo presiono actualizamos el contador
            handles.ContadorD=handles.ContadorD+1;
            guidata(hObject, handles);
            set(handles.edit2,'String',num2str(handles.ContadorD));
            %leemos cuantos pellets debemos dar
            PelletsEvento=str2num(get(handles.edit4,'String'));
             %entramos en un ciclo para dar los pellets
            for i=1:PelletsEvento
                %usamos la funcion OA_ValentiaRecompensaD para activar el
                %dispensador del lado derecho
                OA_ValentiaRecompensaD(handles.OA);
                pause(1)
            end 
           [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);   
          DDA=DD;           
            contPalanDerLuz=contPalanDerLuz+1;
        end
        ContadorPD=ContadorPD+1;
        set(handles.edit6,'String',num2str(ContadorPD));

        %leemos cual es el valor del retardo asociado al intervalo variable
        load('RetardoRecomp','RetardoRecomp');
        IntVar=2*RetardoRecomp*rand(1,1); %intervalo variable uniformemente distribuido 
        %IntVar=2*RetardoRecomp*((abs(randn(1,1))+3.5)/7); %intervalo variable normalmente distribuido
         DDA=DD;
    end
    pause(.1)
    load('controlPelletD','Pellet')
    if(Pellet==1)
        %de ser asi entonces usamos la funcion OA_ValentiaRecompensaD para activar el
        %dispensador del lado derecho
       OA_ValentiaRecompensaD(handles.OA);
        %apagamos la bandera de solicitud manual de pellet y la salvamos
       Pellet=0;
       save('controlPelletD','Pellet')
    end   
    %verificamos si el entrenador quiere que termine la secuencia del lado
    %derecho
    load('controlEnt')
    if(Control==0)
        % de ser asi, salimos del ciclo
     Control=0;
    save('controlEnt','Control')
        break
    end  
    end
    InterSinLuz=(str2num(get(handles.edit14,'String'))+rand(1,1)*(str2num(get(handles.edit15,'String'))-str2num(get(handles.edit14,'String')))) %calculamos el intervalo
    tsl=str2num(get(handles.edit25,'String'));
    set(handles.edit25,'String',num2str(tsl+InterSinLuz));

    OA_ValentiaEstimuloD(handles.OA,0,0); %apagamos luces y sonidos
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA); %revisamos el valor de la palanca
    DDA=DD;
    %calculamos numero de ciclos de 300 ms que caben en el InterSinLuz
    NumCiclosSinLuz=round(InterSinLuz/0.42);
    for i=1:NumCiclosSinLuz
    %si se modifico el valor del contador de eventos entonces la rata lo
    %presiono
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA)
    %revisamos el valor de la palanca
    if((DD~=DDA)&(DD==2))
        handles.PalancasDerSinLuz=handles.PalancasDerSinLuz+1;
        set(handles.edit19,'String',num2str(handles.PalancasDerSinLuz));
        DDA=DD;
    end
    if((DD~=DDA)&(DD==3))
        DDA=DD;
    end
    
    
    pause(0.3) %esperamos el tiempo variable
    end
    %falta codigo para contar palancas
    OA_ValentiaEstimuloD(handles.OA,0,EstimL); %prendemos las luces
    contPalanDerLuz=0;
    
    %verificamos si permanecemos en el ciclo
    load('controlEnt')
    if(Control==0)
       % de ser asi, salimos del ciclo
    Control=0;
    save('controlEnt','Control')
        break
    end  
    

    
    
end 
%si salimos del ciclo del lado derecho apagamos luces y sonidos mediante
%la función OA_ValentiaEstimulo
stop(handles.GS);
OA_ValentiaEstimuloD(handles.OA,0,0)
guidata(hObject, handles);



% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%cuando el entrenado presiona el botón de dar pellet prendemos la
%bandera correspondiente del lado derecho
Pellet=1;
save('controlPelletD','Pellet')


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%cuando se presiona el boton detener ponemos en cero la bandera Control del
%lado derecho
Control=0;
save('controlEntD','Control')
%apagamos luces y sonido del lado derecho
OA_ValentiaEstimuloD(handles.OA,0,0)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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
set(hObject,'String','0');




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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

%se asigna cero a la casilla 
set(hObject,'String','0');


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

%cuando se ordena cerrar la pantalla de control
%primero apagamos los estimulos y se restaura y cierra la tarjeta de
%National Instrument
OA_ValentiaEstimuloD(handles.OA,0,0)
OA_ValentiaEstimuloI(handles.OA,0,0)
daqreset
delete(hObject);



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%leemos de la casilla cual es el valor promedio para el intervalo variable 
%asociado a la activacion de las palancas
RetardoRecomp=str2double(get(hObject,'String'));
save('RetardoRecomp','RetardoRecomp');

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


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%cargamos la variable de resultados
load('Resultados','Resultados');
%la presentamos en pantalla
Resultados


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%limpiamos la variable de resultados
Resultados=[];
%la salvamos
save('Resultados','Resultados');



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%leemos la casilla para saber cuantos pellets por evento se daran
PelletsEvento=str2double(get(hObject,'String'));
save('PelletsEvento','PelletsEvento');

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



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name,path]=uiputfile('Nombre del archivo para guardar datos del experimento')

a=str2num(get(handles.edit18,'String'));
b=str2num(get(handles.edit19,'String'));
c=str2num(get(handles.edit26,'String'));
d=str2num(get(handles.edit25,'String'));


Datos=[str2num(get(handles.edit1,'String')) str2num(get(handles.edit2,'String')) a b str2num(get(handles.edit20,'String')) str2num(get(handles.edit22,'String')) str2num(get(handles.edit21,'String')) str2num(get(handles.edit23,'String')) c d];

save(strcat(path,name),'Datos');

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ThabIni=str2num(get(handles.edit24,'String'));
    NumCiclosHabIni=round(ThabIni/0.42);
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA); %revisamos el valor de la palanca
    DDA=DD;
    DIA=DI;
    rebote=0;
    for i=1:NumCiclosHabIni
    %si se modifico el valor del contador de eventos entonces la rata lo
    %presiono
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA); %revisamos el valor de la palanca
    if(DD~=DDA)
        if(DD<DDA)
        handles.PalancasHabIniD=handles.PalancasHabIniD+1;
        set(handles.edit22,'String',num2str(handles.PalancasHabIniD));
        end
        DDA=DD;
            
    end
    if(DI~=DIA)
        handles.PalancasHabIniI=handles.PalancasHabIniI+1;
        set(handles.edit20,'String',num2str(handles.PalancasHabIniI));
        DIA=DI;
    end

    pause(0.3) %esperamos el tiempo variable
    end
msgbox('fin de habituacion');


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ThabFin=str2num(get(handles.edit24,'String'));
    NumCiclosHabFin=round(ThabFin/0.42);
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA); %revisamos el valor de la palanca
    DDA=DD;
    DIA=DI;
    for i=1:NumCiclosHabFin
    %si se modifico el valor del contador de eventos entonces la rata lo
    %presiono
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA); %revisamos el valor de la palanca
    if(DD~=DDA)
        handles.PalancasHabFinD=handles.PalancasHabFinD+1;
        set(handles.edit23,'String',num2str(handles.PalancasHabFinD));
        DDA=DD;
    end
    if(DI~=DIA)
        handles.PalancasHabFinI=handles.PalancasHabFinI+1;
        set(handles.edit21,'String',num2str(handles.PalancasHabFinI));
        DIA=DI;
    end

    pause(0.3) %esperamos el tiempo variable
    end
msgbox('fin de habituacion');


function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
