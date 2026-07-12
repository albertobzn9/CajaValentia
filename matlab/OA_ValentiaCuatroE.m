function varargout = OA_ValentiaCuatroE(varargin)
% OA_VALENTIACUATROE MATLAB code for OA_ValentiaCuatroE.fig
%      OA_VALENTIACUATROE, by itself, creates a new OA_VALENTIACUATROE or raises the existing
%      singleton*.
%
%      H = OA_VALENTIACUATROE returns the handle to a new OA_VALENTIACUATROE or the handle to
%      the existing singleton*.
%
%      OA_VALENTIACUATROE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIACUATROE.M with the given input arguments.
%
%      OA_VALENTIACUATROE('Property','Value',...) creates a new OA_VALENTIACUATROE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaCuatroE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaCuatroE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaCuatroE

% Last Modified by GUIDE v2.5 03-Dec-2013 18:20:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @OA_ValentiaCuatroE_OpeningFcn, ...
    'gui_OutputFcn',  @OA_ValentiaCuatroE_OutputFcn, ...
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
%TipoEvento: 0 seguro, 1 conflicto con comida, 2 sonido/parrilla sin comida






% --- Executes just before OA_ValentiaCuatroE is made visible.
function OA_ValentiaCuatroE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaCuatroE (see VARARGIN)

% Choose default command line output for OA_ValentiaCuatroE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaCuatroE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%establecemos comunicacion con el equipo
daqreset
handles.GS=OA_PreparaSonidos;
handles.OA = OA_ValentiaInicio;
handles.Luz=0;
handles.Sonido=0;
handles.SonidoInt=0;
handles.LuzInt=0;
handles.PalancasIzqHabitua=0;
handles.PalancasDerHabitua=0;

cmc_configurar_tabla_resultados(handles.uitable1);
guidata(hObject, handles);

cmc_setup_paths();
cd(cmc_state_dir())

%preparamos las recompensas
%RD=[0 1];RI=[0 1];
%save(fullfile(cmc_state_dir(), 'DatosValentia'),'RD','RI');

%apagamos los estimulos
OA_ValentiaEstimuloI(handles.OA,0,0)
OA_ValentiaEstimuloD(handles.OA,0,0)

%retiramos las dos palancas
OA_ValentiaPalanca(handles.OA,'I',1); %sacar las palancas
OA_ValentiaPalanca(handles.OA,'D',1); %sacar las palancas

CT_Ejecuta=0;
CT_Pausa=0;
CT_Ensayos=0;
CT_FinalizarTrasEnsayo=0;
save('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos','CT_FinalizarTrasEnsayo');

set(handles.edit1,'String','0');
set(handles.edit3,'String','1');  %pellets por recompensa ensayo seguro
set(handles.edit4,'String','300'); %ensayos a realizar
set(handles.edit5,'String','1'); %palancas por recompensa
set(handles.edit6,'String','0'); %ensayos a realizar
set(handles.edit7,'String','0'); %palancas por recompensa
set(handles.edit8,'String','180'); %maxima duracion de ensayo seguro (s)
set(handles.edit9,'String','0'); %reloj
set(handles.edit14,'String',num2str(cmc_frecuencia_ruido_predeterminada)); %Frecuencia del estimulo auditivo de Riesgo D
set(handles.edit15,'String','300'); %amplitud del estimulo auditivo D
set(handles.edit16,'String','3'); %máximo número de repeticiones por lado
set(handles.edit17,'String','1');  %pellets por recompensa ensayo riesgo
set(handles.edit18,'String','180'); %maxima duracion de ensayo riesgo (s)
set(handles.edit19,'String','0'); %cuenta de ensayos donde la rata cruzo
set(handles.Terminarn2,'String','Detener ahora');
set(handles.checkbox1,'Value',1); %secuencia aleatoria (informativa)
set(handles.checkbox4,'Value',1); %luz en ensayo seguro
set(handles.checkbox7,'Value',1); %luz en ensayo de riesgo
set(handles.checkbox8,'Value',1); %sonido en ensayo de riesgo
cmc_ocultar_controles_legacy(handles);
handles.ActivarSonidoSolo = uicontrol('Parent', hObject, ...
    'Style', 'checkbox', ...
    'String', 'Agregar evento sonido 1:10', ...
    'Tag', 'ActivarSonidoSolo', ...
    'Units', 'characters', ...
    'Position', [139.8 58.1 33 2], ...
    'FontSize', 8, ...
    'Value', 1, ...
    'TooltipString', ['Con riesgo mayor que 0, agrega un evento de solo sonido ', ...
        'por cada 10 eventos con comida.']);
handles.DetenerTrasEnsayo = uicontrol('Parent', hObject, ...
    'Style', 'pushbutton', ...
    'String', 'Detener tras ensayo', ...
    'Tag', 'DetenerTrasEnsayo', ...
    'Units', 'characters', ...
    'Position', [153 10.5 20.2 2], ...
    'FontSize', 8, ...
    'Callback', @DetenerTrasEnsayo_Callback);
guidata(hObject, handles);







% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaCuatroE_OutputFcn(hObject, eventdata, handles)
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



Riesgo=str2num(get(handles.edit1,'String'));
NumRepLado=str2num(get(handles.edit16,'String'));
NumEnsayos=str2num(get(handles.edit4,'String'));
ActivarSonidoSolo=get(handles.ActivarSonidoSolo,'Value');
if(Riesgo==1)
    NumRepLado=1;
    set(handles.edit16,'String','1');
end

try
    [Secuencia,ModoSonidoSolo]=OA_SecuenciaDiscriminacionSonidoSolo( ...
        NumEnsayos,NumRepLado,Riesgo,ActivarSonidoSolo);
catch ME
    errordlg(ME.message,'Discriminacion experimental');
    return
end

load('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos');
CT_Ejecuta=1;
CT_FinalizarTrasEnsayo=0;
save('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos','CT_FinalizarTrasEnsayo');

Ensayo=0;
Resultados=[];
ContadorTD=0;
ContadorTI=0;
[EstadoPalanqueos, EventosPalanqueo] = cmc_nuevo_registro_palanqueos;
ContadorHabI=0;
ContadorHabD=0;
ContadorSinLuzI=0;
ContadorSinLuzD=0;
TultimaP=0;

%limpiamos contadores de palanqueos
set(handles.edit6,'String','0'); %lado izq
set(handles.edit7,'String','0'); %lado der
set(handles.edit20,'String','0'); %habituacion izq
set(handles.edit21,'String','0'); %habituacion der
set(handles.edit22,'String','0'); %sin luz izq
set(handles.edit23,'String','0'); %sin luz der

set(handles.Inicio,'String','Ejecutando');

PalXRec=str2num(get(handles.edit5,'String'));

if(PalXRec<=0)
    PalXRec=1;
end

Ensayo=1;
R1=tic;
R0=tic;
TultimaPalanca=toc(R1);

if(ModoSonidoSolo==1)
    msgbox(sprintf(['Modo experimental: cada bloque tiene 10 eventos con comida y 1 de sonido solo.\n' ...
        'Riesgo y sonido solo solo aparecen cuando cambia el lado.']))
end


THabitua=str2num(get(handles.edit15,'String'));
msgbox('Cerrar mensaje para iniciar habituacion')

NumCiclosHabitua=round(THabitua/0.42);
[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
EstadoPalanqueos=cmc_reiniciar_referencia_palanqueos(EstadoPalanqueos,DI,DD);

for i=1:NumCiclosHabitua
    [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD]=cmc_observar_palanqueos( ...
        handles.OA,EstadoPalanqueos,EventosPalanqueo,toc(R0), ...
        'habituacion_inicial',0,'ninguno');
    ContadorHabI=ContadorHabI+NuevaI;
    ContadorHabD=ContadorHabD+NuevaD;
    set(handles.edit20,'String',num2str(ContadorHabI));
    set(handles.edit21,'String',num2str(ContadorHabD));
    pause(0.3) %esperamos 300 ms
end

OA_ValentiaResetPalancas(handles.OA);
[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
EstadoPalanqueos=cmc_reiniciar_referencia_palanqueos(EstadoPalanqueos,DI,DD);


EnsayoValido=0;
set(handles.edit19,'String',num2str(EnsayoValido));

while(CT_Ejecuta==1);% ciclo principal aqui se mantiene hasta terminar los n ensayos
    clc
    
    OA_ValentiaEstimuloI(handles.OA,0,0)
    OA_ValentiaEstimuloD(handles.OA,0,0)

    [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD]=cmc_observar_palanqueos( ...
        handles.OA,EstadoPalanqueos,EventosPalanqueo,toc(R0), ...
        'sin_luz',0,'ninguno');
    ContadorSinLuzI=ContadorSinLuzI+NuevaI;
    ContadorSinLuzD=ContadorSinLuzD+NuevaD;
    set(handles.edit22,'String',num2str(ContadorSinLuzI));
    set(handles.edit23,'String',num2str(ContadorSinLuzD));
    
    EnsayoMismoLado=0;
    if((Ensayo>1)&&(Secuencia(Ensayo-1,1)==Secuencia(Ensayo,1)))
        EnsayoMismoLado=1
        IntVar=0;
    end
    
    freqRiesgo=str2num(get(handles.edit14,'String'));
    
    
    caso=Secuencia(Ensayo,1);
    if(caso==1)
        Lado='I';
    elseif(caso==0)
        Lado='D';
    end

    TipoEvento=Secuencia(Ensayo,2);
    if(TipoEvento==0)
        TipoEventoTexto='seguro';
    elseif(TipoEvento==1)
        TipoEventoTexto='riesgo';
    else
        TipoEventoTexto='sonido_solo';
    end
    % La zona se confirma antes de encender estimulos solo en ensayos con
    % comida. Sonido solo mantiene su flujo independiente de cruces.
    ZonaInicio = 'no_aplica';
    if(TipoEvento~=2)
        ZonaInicio = cmc_lee_zona_posicion(handles.OA);
    end
    if(TipoEvento==2)
        DuracionSonidoSolo=180;
        DuracionAudio=DuracionSonidoSolo+1;
        if(strcmp(Lado,'D')==1)
            OA_Sonidos(handles.GS,DuracionAudio,freqRiesgo,1,0,0);
        else
            OA_Sonidos(handles.GS,DuracionAudio,0,0,freqRiesgo,1);
        end
        pause(.1)
        OA_ValentiaEstimuloD(handles.OA,2,0); % LED que marca estimulacion electrica
        pause(.1)
        OA_ValentiaElectrico(handles.OA,1);
        R2=tic;

        [LadoResultado,LatenciaCruce,ContadorTI,ContadorTD,Detenido, ...
            EstadoPalanqueos,EventosPalanqueo] = OA_MonitoreaSonidoSolo( ...
            handles.OA,DuracionSonidoSolo,ContadorTI,ContadorTD,handles.edit9, ...
            EstadoPalanqueos,EventosPalanqueo,R0,Ensayo);
        set(handles.edit6,'String',num2str(ContadorTI));
        set(handles.edit7,'String',num2str(ContadorTD));

        if(Detenido==0)
            Resultados=[Resultados;cmc_fila_resultado(Ensayo,LadoResultado,1,DuracionSonidoSolo, ...
                toc(R0),ContadorTI,ContadorTD,LatenciaCruce,2,ModoSonidoSolo)];
            cmc_mostrar_tabla_resultados(handles.uitable1,Resultados);
        end
        Ensayo=Ensayo+1;
        stop(handles.GS);
    else
    %realizar ensayo lado izquierdo
    if(strcmp(Lado,'D')==1)
        
        if(Secuencia(Ensayo,2)==0) %ensayo seguro
            if(get(handles.checkbox4,'Value')==1)
                OA_ValentiaEstimuloI(handles.OA,0,1); %dejamos sonido apagado luz prendida
            end
            ES=0;
            EL=1;
            PelletsEvento=str2num(get(handles.edit3,'String'));
            DurMaxEns=str2num(get(handles.edit8,'String'));
%             if(get(handles.checkbox6,'Value')==1)
%                 OA_ValentiaPalanca(handles.OA,'I',1); %nos aseguramos que la palanca izq este afuera
%             end
            
        end
        if(Secuencia(Ensayo,2)==1) %ensayo con riesgo
            
            
            
            DurMaxEns=str2num(get(handles.edit18,'String'));
            if(get(handles.checkbox8,'Value')==1)
                OA_Sonidos(handles.GS,DurMaxEns,freqRiesgo,1,0,0); %mandamos ruido blanco del lado izq
                pause(.1)
                OA_ValentiaEstimuloD(handles.OA,2,0); %dejamos sonido apagado luz prendida
                pause(.1)
            end
            OA_ValentiaElectrico(handles.OA,1);
            pause(.1)
            if(get(handles.checkbox7,'Value')==1)
                OA_ValentiaEstimuloI(handles.OA,0,1); %dejamos sonido apagado luz prendida
            end
            ES=2;
            EL=2;
            PelletsEvento=str2num(get(handles.edit17,'String'));
%             if(get(handles.checkbox6,'Value')==1)
%                 OA_ValentiaPalanca(handles.OA,'I',1); %nos aseguramos que la palanca izq este afuera
%             end
            
        end
        
%         if((get(handles.checkbox6,'Value')==1)&&(get(handles.checkbox11,'Value')==0)) %si se pide meter la palanca antes de cruzar
%             OA_ValentiaPalanca(handles.OA,'D',2); %se mete la palanca del otro lado
%         end
        
        
        
        R2=tic;
        OA_ValentiaResetPalancas(handles.OA);
        [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
        EstadoPalanqueos=cmc_reiniciar_referencia_palanqueos(EstadoPalanqueos,DI,DD);
        P=0;
        LatMI=tic;
        CDurMaxEns=1;
        while(P==0)
            [P]=OA_ValentiaBuscaIzquierda(handles.OA);
            if(P==1)
                P=0;
                [P]=OA_ValentiaBuscaIzquierda(handles.OA);
            end
            [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD]=cmc_observar_palanqueos( ...
                handles.OA,EstadoPalanqueos,EventosPalanqueo,toc(R0), ...
                'ensayo',Ensayo,TipoEventoTexto);
            ContadorTI=ContadorTI+NuevaI;
            ContadorTD=ContadorTD+NuevaD;
            set(handles.edit6,'String',num2str(ContadorTI));
            set(handles.edit7,'String',num2str(ContadorTD));
            if(toc(LatMI)>DurMaxEns)
                CDurMaxEns=0;
                break;
            end
            set(handles.edit9,'String',num2str(toc(LatMI)));
            drawnow;
            load('ControlTarea','CT_Ejecuta');
            if(CT_Ejecuta==0)
                CDurMaxEns=-1;
                break;
            end
            pause(.01);
        end
        
        if(CDurMaxEns==0) %si la rata NO cruzo
            Resultados=[Resultados;cmc_fila_resultado(Ensayo,-2,Secuencia(Ensayo,2),toc(R2), ...
                toc(R0),ContadorTI,ContadorTD,DurMaxEns,Secuencia(Ensayo,2),ModoSonidoSolo)];
            cmc_mostrar_tabla_resultados(handles.uitable1,Resultados);
        end    
        
        
        if(CDurMaxEns==1) %si la rata cruzo
            LatMotIzq=toc(LatMI);
            CruceValido=cmc_es_cruce_valido(EnsayoMismoLado,ZonaInicio,Lado,LatMotIzq);
            fprintf('Cruce %d: inicio=%s, lado=%s, desplazamiento=%.3f s, valido=%d\n', ...
                Ensayo,ZonaInicio,Lado,LatMotIzq,CruceValido);
            if(CruceValido)
                EnsayoValido=EnsayoValido+1;  %contamos ensayos donde la rata debia cruzar
                set(handles.edit19,'String',num2str(EnsayoValido));
            end    
            
%             if((get(handles.checkbox6,'Value')==1)&&(get(handles.checkbox11,'Value')==1)) %si se pide meter la palanca despues de cruzar
%                 OA_ValentiaPalanca(handles.OA,'D',2); %se mete la palanca del otro lado
%             end
            
            
            
            while(1)
                drawnow;
                load('ControlTarea','CT_Ejecuta');
                if(CT_Ejecuta==0)
                    break;
                end
                [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD,DI,DD]=cmc_observar_palanqueos( ...
                    handles.OA,EstadoPalanqueos,EventosPalanqueo,toc(R0), ...
                    'ensayo',Ensayo,TipoEventoTexto);
                ContadorTI=ContadorTI+NuevaI;
                ContadorTD=ContadorTD+NuevaD;
                set(handles.edit6,'String',num2str(ContadorTI));
                set(handles.edit7,'String',num2str(ContadorTD));
                if((DI>=PalXRec)&& EnsayoMismoLado==0) %%si no se repite el mismo lado
                    TultimaPalanca=toc(R1); %guardamos el tiempo de la ultima palanca
                    Resultados=[Resultados;cmc_fila_resultado(Ensayo,1,Secuencia(Ensayo,2),toc(R2), ...
                        toc(R0),ContadorTI,ContadorTD,LatMotIzq,Secuencia(Ensayo,2),ModoSonidoSolo)];
                    cmc_mostrar_tabla_resultados(handles.uitable1,Resultados);
                    for iR=1:PelletsEvento
                        'recomp'
                        OA_ValentiaRecompensaI(handles.OA);
                        pause(.1)
                    end
                    break
                end
                
                if((DI>=PalXRec)&& EnsayoMismoLado==1) %%si se repite el mismo lado
                    if(toc(R1)>(TultimaPalanca+IntVar))
                        TultimaPalanca=toc(R1);  %guardamos el tiempo de la ultima palanca
                        Resultados=[Resultados;cmc_fila_resultado(Ensayo,1,Secuencia(Ensayo,2),toc(R2), ...
                            toc(R0),ContadorTI,ContadorTD,LatMotIzq,Secuencia(Ensayo,2),ModoSonidoSolo)];
                        cmc_mostrar_tabla_resultados(handles.uitable1,Resultados);
                        for iR=1:PelletsEvento
                             'recomp'
                            OA_ValentiaRecompensaI(handles.OA);
                            pause(.1)
                        end
                        break
                    end
                end
                
                
                pause(.1);
                load('ControlTarea');
                if(CT_Ejecuta==0)
                    break;
                end
            end
        end %si la rata cruza antes de la duracion máxima
        %           if((get(handles.checkbox9,'Value')==1)&&(Secuencia(Ensayo,1)~=Secuencia(Ensayo+1,1))) %si se pide meter la palanca y el ensayo siguiente es de lado diferente
        %               OA_ValentiaPalanca(handles.OA,'I',2); %nos aseguramos que la palanca der este afuera
        %           end
        Ensayo=Ensayo+1;
        
        
        stop(handles.GS);
    end  %ensayo lado izquierdo
    
    
    
    %realizar ensayo lado derecho
    if(strcmp(Lado,'I')==1)
        
        if(Secuencia(Ensayo,2)==0) %ensayo seguro
            if(get(handles.checkbox4,'Value')==1)
                OA_ValentiaEstimuloD(handles.OA,0,1);  %dejamos sonido apagado luz prendida
            end
            PelletsEvento=str2num(get(handles.edit3,'String'));
            DurMaxEns=str2num(get(handles.edit8,'String'));
%             if(get(handles.checkbox9,'Value')==1)
%                 OA_ValentiaPalanca(handles.OA,'D',1); %nos aseguramos que la palanca der este afuera
%             end
            
        end
        if(Secuencia(Ensayo,2)==1) %ensayo con  riesgo
            DurMaxEns=str2num(get(handles.edit18,'String'));
            if(get(handles.checkbox8,'Value')==1)
                OA_Sonidos(handles.GS,DurMaxEns,0,0,freqRiesgo,1); %mandamos tono der
                pause(.1)
                OA_ValentiaEstimuloD(handles.OA,2,0); %prendemos led rojo
                pause(.1)
            end
            OA_ValentiaElectrico(handles.OA,1);
            pause(.1)
           
            if(get(handles.checkbox7,'Value')==1)
                OA_ValentiaEstimuloD(handles.OA,2,1); %dejamos sonido apagado luz prendida
                pause(.1)
            end
            PelletsEvento=str2num(get(handles.edit17,'String'));
%             if(get(handles.checkbox9,'Value')==1)
%                 OA_ValentiaPalanca(handles.OA,'D',1); %nos aseguramos que la palanca der este afuera
%             end

        end
        
%         if((get(handles.checkbox6,'Value')==1)&&(get(handles.checkbox11,'Value')==0)) %si se pide meter la palanca antes del cruce
%             OA_ValentiaPalanca(handles.OA,'I',2); %se mete la palanca del otro lado
%         end
        
        
        
        R2=tic;
        OA_ValentiaResetPalancas(handles.OA);
        [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
        EstadoPalanqueos=cmc_reiniciar_referencia_palanqueos(EstadoPalanqueos,DI,DD);
        P=0;
        LatMD=tic;
        CDurMaxEns=1;
        while(P==0)
            [P]=OA_ValentiaBuscaDerecha(handles.OA);
            [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD]=cmc_observar_palanqueos( ...
                handles.OA,EstadoPalanqueos,EventosPalanqueo,toc(R0), ...
                'ensayo',Ensayo,TipoEventoTexto);
            ContadorTI=ContadorTI+NuevaI;
            ContadorTD=ContadorTD+NuevaD;
            set(handles.edit6,'String',num2str(ContadorTI));
            set(handles.edit7,'String',num2str(ContadorTD));
            if(toc(LatMD)>DurMaxEns)
                CDurMaxEns=0;
                break;
            end
            set(handles.edit9,'String',num2str(toc(LatMD)));
            drawnow;
            load('ControlTarea','CT_Ejecuta');
            if(CT_Ejecuta==0)
                CDurMaxEns=-1;
                break;
            end
            pause(.01);
        end

        if(CDurMaxEns==0) %si la rata NO cruzo
            Resultados=[Resultados;cmc_fila_resultado(Ensayo,-2,Secuencia(Ensayo,2),toc(R2), ...
                toc(R0),ContadorTI,ContadorTD,DurMaxEns,Secuencia(Ensayo,2),ModoSonidoSolo)];
            cmc_mostrar_tabla_resultados(handles.uitable1,Resultados);
        end    
        
        
        
        if(CDurMaxEns==1) %si la rata cruzo
            LatMotDer=toc(LatMD);
            CruceValido=cmc_es_cruce_valido(EnsayoMismoLado,ZonaInicio,Lado,LatMotDer);
            fprintf('Cruce %d: inicio=%s, lado=%s, desplazamiento=%.3f s, valido=%d\n', ...
                Ensayo,ZonaInicio,Lado,LatMotDer,CruceValido);
            if(CruceValido)
                EnsayoValido=EnsayoValido+1;  %contamos ensayos donde la rata debia cruzar
                set(handles.edit19,'String',num2str(EnsayoValido));
            end  
            
%             if((get(handles.checkbox6,'Value')==1)&&(get(handles.checkbox11,'Value')==1)) %si se pide meter la palanca despues del cruce
%                 OA_ValentiaPalanca(handles.OA,'I',2); %se mete la palanca del otro lado
%             end
            
            
            while(1)
                drawnow;
                load('ControlTarea','CT_Ejecuta');
                if(CT_Ejecuta==0)
                    break;
                end
                [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD,DI,DD]=cmc_observar_palanqueos( ...
                    handles.OA,EstadoPalanqueos,EventosPalanqueo,toc(R0), ...
                    'ensayo',Ensayo,TipoEventoTexto);
                ContadorTI=ContadorTI+NuevaI;
                ContadorTD=ContadorTD+NuevaD;
                set(handles.edit6,'String',num2str(ContadorTI));
                set(handles.edit7,'String',num2str(ContadorTD));
                if((DD>=PalXRec)&& EnsayoMismoLado==0)
                    TultimaPalanca=toc(R1) %guardamos el tiempo de la ultima palanca
                    Resultados=[Resultados;cmc_fila_resultado(Ensayo,0,Secuencia(Ensayo,2),toc(R2), ...
                        toc(R0),ContadorTI,ContadorTD,LatMotDer,Secuencia(Ensayo,2),ModoSonidoSolo)];
                    cmc_mostrar_tabla_resultados(handles.uitable1,Resultados);
                    for iR=1:PelletsEvento
                        OA_ValentiaRecompensaD(handles.OA);
                        pause(.1)
                    end
                    break
                end
                
                if((DD>=PalXRec)&& EnsayoMismoLado==1)
                    if(toc(R1)>(TultimaPalanca+IntVar)) %verificamos que la respuesta se presente despues de un retardo
                        TultimaPalanca=toc(R1) %guardamos el tiempo de la ultima palanca
                        Resultados=[Resultados;cmc_fila_resultado(Ensayo,0,Secuencia(Ensayo,2),toc(R2), ...
                            toc(R0),ContadorTI,ContadorTD,LatMotDer,Secuencia(Ensayo,2),ModoSonidoSolo)];
                        cmc_mostrar_tabla_resultados(handles.uitable1,Resultados);
                        for iR=1:PelletsEvento
                            OA_ValentiaRecompensaD(handles.OA);
                            pause(.1)
                        end
                        break
                    end
                end
                
                pause(.1);
                load('ControlTarea');
                if(CT_Ejecuta==0)
                    break;
                end
            end
        end %si la rata cruza antes de la duracion máxima
        
        %           if((get(handles.checkbox9,'Value')==1)&&(Secuencia(Ensayo,1)~=Secuencia(Ensayo+1,1))) %si se pide meter la palanca y el ensayo siguiente es de lado diferente
        %               OA_ValentiaPalanca(handles.OA,'D',2); %nos aseguramos que la palanca der este afuera
        %           end
        Ensayo=Ensayo+1;
        
        
        stop(handles.GS);
    end  %ensayo lado derecho
    end  %sonido solo o ensayo con comida
    
    OA_ValentiaElectrico(handles.OA,0)
    pause(.5)
    OA_ValentiaEstimuloI(handles.OA,0,0)
    OA_ValentiaEstimuloD(handles.OA,0,0)
    pause(.2);
    OA_CtrlDispIzqCero(handles.OA);
    drawnow;
    load('ControlTarea','CT_Ejecuta','CT_FinalizarTrasEnsayo');
    if(CT_Ejecuta==0 || CT_FinalizarTrasEnsayo==1)
        break;
    end
    if(ModoSonidoSolo==1)
        FinEnsayos=size(Secuencia,1);
    else
        FinEnsayos=str2num(get(handles.edit4,'String'));
    end
    if(Ensayo>=FinEnsayos+1)
        break
    end
    
end


set(handles.Inicio,'String','Inicio');
THabitua=str2num(get(handles.edit15,'String'));
NumCiclosHabitua=round(THabitua/0.42);

[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
EstadoPalanqueos=cmc_reiniciar_referencia_palanqueos(EstadoPalanqueos,DI,DD);

for i=1:NumCiclosHabitua
    [EstadoPalanqueos,EventosPalanqueo,NuevaI,NuevaD]=cmc_observar_palanqueos( ...
        handles.OA,EstadoPalanqueos,EventosPalanqueo,toc(R0), ...
        'habituacion_final',0,'ninguno');
    ContadorHabI=ContadorHabI+NuevaI;
    ContadorHabD=ContadorHabD+NuevaD;
    set(handles.edit20,'String',num2str(ContadorHabI));
    set(handles.edit21,'String',num2str(ContadorHabD));
    pause(0.3) %esperamos 300 ms
end

save(fullfile(cmc_state_dir(), 'OA_Resultados'), 'Resultados', 'EventosPalanqueo');
msgbox('Fin de la secuencia')



%retiramos las dos palancas
% OA_ValentiaPalanca(handles.OA,'I',2);
% OA_ValentiaPalanca(handles.OA,'D',2);




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
CT_FinalizarTrasEnsayo=0;
save('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos','CT_FinalizarTrasEnsayo');


function DetenerTrasEnsayo_Callback(hObject, eventdata, handles)
%DETENERTRASENSAYO_CALLBACK Cierra al terminar el evento actual.

load('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos');
if(CT_Ejecuta==1)
    CT_FinalizarTrasEnsayo=1;
    save('ControlTarea','CT_Ejecuta','CT_Pausa','CT_Ensayos','CT_FinalizarTrasEnsayo');
end


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
datosSesion=load(fullfile(cmc_state_dir(), 'OA_Resultados'));
Resultados=datosSesion.Resultados;
if isfield(datosSesion,'EventosPalanqueo')
    EventosPalanqueo=datosSesion.EventosPalanqueo;
else
    [~,EventosPalanqueo]=cmc_nuevo_registro_palanqueos;
end
viejo=pwd;
cd(cmc_results_dir());
[fname,pname]=uiputfile('*.mat','nombre y ruta para guardar resultados');
if isequal(fname,0)
    cd(viejo);
    return
end
cmc_guardar_resultados_sesion(fullfile(pname,fname),Resultados,EventosPalanqueo);
cd(viejo);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

RetardoRecomp=str2double(get(hObject,'String'));


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
% PelletsEvento=str2double(get(hObject,'String'));
% save('PelletsEvento','PelletsEvento');



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
cd(cmc_results_dir());

[file,path]=uigetfile('*.mat');
cd(viejo)

load(strcat(path,file));
if(size(Resultados,1)>0)
    %load(fullfile(cmc_state_dir(), 'OA_Resultados'), 'Resultados');
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
    if(size(ID,1)>1)
    hold on
    bar(1,mean(RS(ID(:,2),4)),'w')
    errorbar(1,mean(RS(ID(:,2),4)),std(RS(ID(:,2),4))/(sqrt(size(ID,1)-1)));
    xlim([0 2]);
    drawnow;
    end
    xlabel('Izq Der');
    ylabel('tiempo [s]');
    
    subplot(3,3,2)
    if(size(DI,1)>1)
    hold on
    bar(1,mean(RS(DI(:,2),4)),'w')
    errorbar(1,mean(RS(DI(:,2),4)),std(RS(DI(:,2),4))/(sqrt(size(DI,1)-1)));
    xlim([0 2]);
    drawnow;
    end
    xlabel('Der Izq');
    ylabel('tiempo [s]');
    title('Latencias de Palanca');
    
    
    cruces=[ID;DI];
    
    subplot(3,3,3)
    if(size(cruces,1)>1)
    hold on
    bar(1,mean(RS(cruces(:,2),4)),'w')
    errorbar(1,mean(RS(cruces(:,2),4)),std(RS(cruces(:,2),4))/(sqrt(size(cruces,1)-1)));
    xlim([0 2]);
    drawnow;
    etiq=strcat('Cruces :',num2str(mean(RS(cruces(:,2),4))),'+-',num2str(std(RS(cruces(:,2),4))/(sqrt(size(cruces,1)-1))));
    xlabel(etiq);
    ylabel('tiempo [s]');
    end
    
    
    Nocruces=[II;DD];
    
    
    subplot(3,3,4)
    if(size(II,1)>1)
    hold on
    bar(1,mean(RS(II(:,2),4)),'w')
    errorbar(1,mean(RS(II(:,2),4)),std(RS(II(:,2),4))/(sqrt(size(II,1)-1)));
    xlim([0 2]);
    drawnow;
    end
    xlabel('Izq Izq');
    ylabel('tiempo [s]');
    
    
    
    subplot(3,3,5)
    if(size(DD,1)>1)
    hold on
    bar(1,mean(RS(DD(:,2),4)),'w')
    errorbar(1,mean(RS(DD(:,2),4)),std(RS(DD(:,2),4))/(sqrt(size(DD,1)-1)));
    xlim([0 2]);
    drawnow;
    end
    xlabel('Der Der');
    ylabel('tiempo [s]');
    
    
    subplot(3,3,6)
    if(size(Nocruces,1)>1)
    hold on
    bar(1,mean(RS(Nocruces(:,2),4)),'w')
    errorbar(1,mean(RS(Nocruces(:,2),4)),std(RS(Nocruces(:,2),4))/(sqrt(size(Nocruces,1)-1)));
    xlim([0 2]);
    drawnow;
    etiq2=strcat('No cruces :',num2str(mean(RS(Nocruces(:,2),4))),'+-',num2str(std(RS(Nocruces(:,2),4))/(sqrt(size(Nocruces,1)-1))));
    xlabel(etiq2);
    ylabel('tiempo [s]');
    end
    
    
    
    
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
    if(size(ID,1)>1)
    hold on
    bar(1,mean(RS(ID(:,2),4)),'w')
    errorbar(1,mean(RS(ID(:,2),4)),std(RS(ID(:,2),4))/(sqrt(size(ID,1)-1)));
    xlim([0 2]);
    drawnow;
    end
    xlabel('Izq Der');
    ylabel('tiempo [s]');
    
    subplot(3,3,2)
    if(size(DI,1)>1)
    hold on
    bar(1,mean(RS(DI(:,2),4)),'w')
    errorbar(1,mean(RS(DI(:,2),4)),std(RS(DI(:,2),4))/(sqrt(size(DI,1)-1)));
    xlim([0 2]);
    end
    drawnow;
    xlabel('Der Izq');
    ylabel('tiempo [s]');
    title('Latencias de Desplazamiento');
    
    cruces=[ID;DI];
    
    subplot(3,3,3)
    if(size(cruces,1)>1)
    hold on
    bar(1,mean(RS(cruces(:,2),4)),'w')
    errorbar(1,mean(RS(cruces(:,2),4)),std(RS(cruces(:,2),4))/(sqrt(size(cruces,1)-1)));
    xlim([0 2]);
    drawnow;
    etiq=strcat('Cruces :',num2str(mean(RS(cruces(:,2),4))),'+-',num2str(std(RS(cruces(:,2),4))/(sqrt(size(cruces,1)-1))));
    xlabel(etiq);
    ylabel('tiempo [s]');
    end
    
    
    Nocruces=[II;DD];
    
    
    subplot(3,3,4)
    if(size(II,1)>1)
    hold on
    bar(1,mean(RS(II(:,2),4)),'w')
    errorbar(1,mean(RS(II(:,2),4)),std(RS(II(:,2),4))/(sqrt(size(II,1)-1)));
    xlim([0 2]);
    drawnow;
    end
    xlabel('Izq Izq');
    ylabel('tiempo [s]');
    
    
    
    subplot(3,3,5)
    if(size(DD,1)>1)
    hold on
    bar(1,mean(RS(DD(:,2),4)),'w')
    errorbar(1,mean(RS(DD(:,2),4)),std(RS(DD(:,2),4))/(sqrt(size(DD,1)-1)));
    xlim([0 2]);
    drawnow;
    end
    xlabel('Der Der');
    ylabel('tiempo [s]');
    
    
    subplot(3,3,6)
    if(size(Nocruces,1)>1)
    hold on
    bar(1,mean(RS(Nocruces(:,2),4)),'w')
    errorbar(1,mean(RS(Nocruces(:,2),4)),std(RS(Nocruces(:,2),4))/(sqrt(size(Nocruces,1)-1)));
    xlim([0 2]);
    drawnow;
    etiq2=strcat('No cruces :',num2str(mean(RS(Nocruces(:,2),4))),'+-',num2str(std(RS(Nocruces(:,2),4))/(sqrt(size(Nocruces,1)-1))));
    xlabel(etiq2);
    ylabel('tiempo [s]');
    end
    
    
    
    
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


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3



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
% PelletsEventoRiesgo=str2double(get(hObject,'String'));
% save('PelletsEventoRiesgo','PelletsEventoRiesgo');

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


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox11


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12



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


function Fila = cmc_fila_resultado(Ensayo,Lado,Electrico,Latencia,TiempoAbs,ContadorTI,ContadorTD,Desplazamiento,TipoEvento,ModoSonidoSolo)
% ModoSonidoSolo se conserva como argumento por compatibilidad con llamadas previas.
% Desde v2.0.0-rc.3 todos los resultados llevan TipoEvento en la columna 9.
Fila = [Ensayo Lado Electrico Latencia TiempoAbs ContadorTI ContadorTD Desplazamiento TipoEvento];
