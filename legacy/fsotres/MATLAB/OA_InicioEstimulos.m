function varargout = OA_InicioEstimulos(varargin)
% OA_INICIOESTIMULOS MATLAB code for OA_InicioEstimulos.fig
%      OA_INICIOESTIMULOS, by itself, creates a new OA_INICIOESTIMULOS or raises the existing
%      singleton*.
%
%      H = OA_INICIOESTIMULOS returns the handle to a new OA_INICIOESTIMULOS or the handle to
%      the existing singleton*.
%
%      OA_INICIOESTIMULOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_INICIOESTIMULOS.M with the given input arguments.
%
%      OA_INICIOESTIMULOS('Property','Value',...) creates a new OA_INICIOESTIMULOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_InicioEstimulos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_InicioEstimulos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_InicioEstimulos

% Last Modified by GUIDE v2.5 17-Jan-2017 17:31:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_InicioEstimulos_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_InicioEstimulos_OutputFcn, ...
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


% --- Executes just before OA_InicioEstimulos is made visible.
function OA_InicioEstimulos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_InicioEstimulos (see VARARGIN)

% Choose default command line output for OA_InicioEstimulos
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

daqreset
handles.GS=OA_PreparaSonidos;
handles.OA = OA_ValentiaInicio;
%cambiamos de directorio de trabajo
cd('C:\Users\fsotres\Documents\MATLAB\Valentia\')


% UIWAIT makes OA_InicioEstimulos wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%fijamos los valores iniciales
set(handles.edit1,'String',10) %numero de repeticiones
set(handles.edit2,'String',2) %duracion de la alerta
set(handles.edit3,'String',1) %minimo intervalo varaible
set(handles.edit4,'String',10) %maximo intervalo variable
set(handles.edit5,'String',0) % contador de repeticiones
set(handles.edit11,'String',0.5) %duracion del pulso electrico
set(handles.edit12,'String',5000); %frecuencia auditiva
set(handles.edit13,'String',300); %tiempo de habituacion

DetenerC=0;
save('DetenerC','DetenerC');


guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = OA_InicioEstimulos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%cuando se presiona el boton de inicio obtenemos los valores de las
%casillas
nEventos=str2num(get(handles.edit1,'String'));
DuracionA=str2num(get(handles.edit2,'String'));
minI=str2num(get(handles.edit3,'String'));
maxI=str2num(get(handles.edit4,'String'));
DuracionEE=str2num(get(handles.edit11,'String'));
freqA=str2num(get(handles.edit12,'String'));


DetenerC=0;
save('DetenerC','DetenerC');

set(handles.pushbutton1,'BackgroundColor',[1 0 0]);	

THabitua=str2num(get(handles.edit13,'String'));
pause(THabitua);

%hacemos un ciclo que se repetira n veces

'Inician ciclos'
nEventos=str2num(get(handles.edit1,'String'));
for i=1:nEventos
    i
    nAle=rand(1,1);
    set(handles.edit5,'String',num2str(i));
    intervalo=minI+((maxI-minI)*rand(1,1));
    if(i>1)
    pause(intervalo);
    end
    
    TAzar=(DuracionA-DuracionEE)*rand(1,1)
    
   % OA_Sonidos(handles.GS,DuracionA+DuracionEE+2,freqA,1,freqA,1); %mandamos la frecuencia a ambos lados
    OA_Sonidos(handles.GS,DuracionA+2,freqA,1,freqA,1); %mandamos la frecuencia a ambos lados
    %prendemos los estimulos auditivos y luces
%     if(nAle>0.5)
%         OA_ValentiaEstimuloI(handles.OA,0,0);
%         OA_ValentiaEstimuloD(handles.OA,0,0);
%     end
%     if(nAle<=0.5)
%         OA_ValentiaEstimuloD(handles.OA,0,0);
%         OA_ValentiaEstimuloI(handles.OA,0,0);
%     end

   if(get(handles.checkbox1,'Value')==1)
    OA_ValentiaEstimuloD(handles.OA,2,2);
    OA_ValentiaEstimuloI(handles.OA,2,2);
   end  
   if(get(handles.checkbox1,'Value')==0)
    OA_ValentiaEstimuloD(handles.OA,2,0);
    OA_ValentiaEstimuloI(handles.OA,2,0);
   end  

    
    %esperamos a que termine el periodo previo a la estimulacion menos la
    %duracion del estimulo electrico
    tic
   %  pause(DuracionA-DuracionEE)
   
    pause(TAzar)
    %prendemos el estimulo electrico
    OA_ValentiaElectrico(handles.OA,1)
    %esperamos a que termine el periodo de estimulación
    pause(DuracionEE)
    toc
    %apagamos estimulos electrico auditivo y visual 
    OA_ValentiaElectrico(handles.OA,0)
    
    pause(DuracionA-(TAzar+DuracionEE))
    
    stop(handles.GS);
    if(nAle>0.5)
        OA_ValentiaEstimuloI(handles.OA,0,0);
        OA_ValentiaEstimuloD(handles.OA,0,0);
    end
    if(nAle<=0.5)
        OA_ValentiaEstimuloD(handles.OA,0,0);
        OA_ValentiaEstimuloI(handles.OA,0,0);
    end
    load('DetenerC','DetenerC');
    if(DetenerC==1)
        break
    end 

end    
    
set(handles.pushbutton1,'BackgroundColor',[1 1 1]);	
    
    



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%varaible de control para detener el proceso
DetenerC=1;
save('DetenerC','DetenerC');



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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
