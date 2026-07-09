function varargout = OA_ValentiaEntrenaDual(varargin)
% OA_VALENTIAENTRENADUAL M-file for OA_ValentiaEntrenaDual.fig
%      OA_VALENTIAENTRENADUAL, by itself, creates a new OA_VALENTIAENTRENADUAL or raises the existing
%      singleton*.
%
%      H = OA_VALENTIAENTRENADUAL returns the handle to a new OA_VALENTIAENTRENADUAL or the handle to
%      the existing singleton*.
%
%      OA_VALENTIAENTRENADUAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIAENTRENADUAL.M with the given input arguments.
%
%      OA_VALENTIAENTRENADUAL('Property','Value',...) creates a new OA_VALENTIAENTRENADUAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaEntrenaDual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaEntrenaDual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaEntrenaDual

% Last Modified by GUIDE v2.5 21-Nov-2012 13:09:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_ValentiaEntrenaDual_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_ValentiaEntrenaDual_OutputFcn, ...
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


% --- Executes just before OA_ValentiaEntrenaDual is made visible.
function OA_ValentiaEntrenaDual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaEntrenaDual (see VARARGIN)

% Choose default command line output for OA_ValentiaEntrenaDual
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaEntrenaDual wait for user response (see UIRESUME)
% uiwait(handles.figure1);
daqreset
handles.OA = OA_ValentiaInicio;

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

handles.ContadorI=0;
handles.ContadorD=0;

guidata(hObject, handles);

cd('C:\Users\fsotres\Documents\MATLAB\Valentia\')

RD=[0 1];RI=[0 1];
save('C:\Users\fsotres\Documents\MATLAB\Valentia\DatosValentia','RD','RI');


% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaEntrenaDual_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EstimS=handles.Sonido+handles.Sonido*handles.SonidoInt;
EstimL=handles.Luz+handles.Luz*handles.LuzInt;

OA_ValentiaEstimulo(handles.OA,'I',EstimS,EstimL);
pause(.5)
OA_ValentiaPalanca(handles.OA,'I',1); 
OA_ValentiaResetPalancas(handles.OA)

Control=1;

save('controlEnt','Control')
[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
DDA=DI;
while(1)
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
    if(DI~=DDA)
        OA_ValentiaRecompensaI_est(handles.OA,EstimS,EstimL)
        handles.ContadorI=handles.ContadorI+1;
        set(handles.edit1,'String',num2str(handles.ContadorI));
    end
    DDA=DI;
    pause(.1)
    load('controlPellet','Pellet')
    if(Pellet==1)
       OA_ValentiaRecompensaI_est(handles.OA,EstimS,EstimL)
       Pellet=0;
       save('controlPellet','Pellet')
    end   
    load('controlEnt')
    if(Control==0)
        break
    end    
end 

OA_ValentiaEstimulo(handles.OA,'I',0,0)
guidata(hObject, handles);



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Control=0;
save('controlEnt','Control')
OA_ValentiaEstimulo(handles.OA,'I',0,0)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Pellet=1;
save('controlPellet','Pellet')


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaEstimulo(handles.OA,'D',0,0)
OA_ValentiaEstimulo(handles.OA,'I',0,0)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Luz=get(hObject,'Value'); 
guidata(hObject, handles);
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Sonido=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.LuzInt=get(hObject,'Value'); 
guidata(hObject, handles);



% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.SonidoInt=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.LuzD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.SonidoD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.LuzIntD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.SonidoIntD=get(hObject,'Value'); 
guidata(hObject, handles);


% --- Executes on button press in pushbutton12. Usar Derecha
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EstimS=handles.SonidoD+handles.SonidoD*handles.SonidoIntD;
EstimL=handles.LuzD+handles.LuzD*handles.LuzIntD;

OA_ValentiaEstimulo(handles.OA,'D',EstimS,EstimL)
pause(.5)
OA_ValentiaPalanca(handles.OA,'D',1); 
OA_ValentiaResetPalancas(handles.OA) %no usar ResetPalanca antes de Palanca

Control=1;
save('controlEntD','Control')
Contador=0;

[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
DDA=DD;
while(1)
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
    if(DD~=DDA)
        OA_ValentiaRecompensaD(handles.OA);
        handles.ContadorD=handles.ContadorD+1;
        set(handles.edit2,'String',num2str(handles.ContadorD));
    end
    DDA=DD;
    pause(.1)
    load('controlPelletD','Pellet')
    if(Pellet==1)
       OA_ValentiaRecompensaD(handles.OA);
       Pellet=0;
       save('controlPelletD','Pellet')
    end   
    load('controlEntD')
    if(Control==0)
        break
    end    
end 

OA_ValentiaEstimulo(handles.OA,'D',0,0)
guidata(hObject, handles);



% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Pellet=1;
save('controlPelletD','Pellet')


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Control=0;
save('controlEntD','Control')
OA_ValentiaEstimulo(handles.OA,'D',0,0)



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
set(hObject,'String','0');


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
OA_ValentiaEstimulo(handles.OA,'D',0,0)
OA_ValentiaEstimulo(handles.OA,'I',0,0)
daqreset
delete(hObject);
