function varargout = OA_ValentiaEntrenaDer(varargin)
% OA_VALENTIAENTRENADER M-file for OA_ValentiaEntrenaDer.fig
%      OA_VALENTIAENTRENADER, by itself, creates a new OA_VALENTIAENTRENADER or raises the existing
%      singleton*.
%
%      H = OA_VALENTIAENTRENADER returns the handle to a new OA_VALENTIAENTRENADER or the handle to
%      the existing singleton*.
%
%      OA_VALENTIAENTRENADER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIAENTRENADER.M with the given input arguments.
%
%      OA_VALENTIAENTRENADER('Property','Value',...) creates a new OA_VALENTIAENTRENADER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaEntrenaDer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaEntrenaDer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaEntrenaDer

% Last Modified by GUIDE v2.5 21-Nov-2012 13:13:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_ValentiaEntrenaDer_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_ValentiaEntrenaDer_OutputFcn, ...
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


% --- Executes just before OA_ValentiaEntrenaDer is made visible.
function OA_ValentiaEntrenaDer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaEntrenaDer (see VARARGIN)

% Choose default command line output for OA_ValentiaEntrenaDer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaEntrenaDer wait for user response (see UIRESUME)
% uiwait(handles.figure1);
daqreset
handles.OA = OA_ValentiaInicio;
handles.Luz=0;
handles.Sonido=0;
handles.SonidoInt=0;
handles.LuzInt=0;
guidata(hObject, handles);

cd('C:\Users\fsotres\Documents\MATLAB\Valentia\')

RD=[0 1];RI=[0 1];
save('C:\Users\fsotres\Documents\MATLAB\Valentia\DatosValentia','RD','RI');


% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaEntrenaDer_OutputFcn(hObject, eventdata, handles) 
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

OA_ValentiaEstimulo(handles.OA,'D',EstimS,EstimL)
pause(.5);
OA_ValentiaPalanca(handles.OA,'D',1); 
OA_ValentiaResetPalancas(handles.OA);  %no usar ResetPalanca antes de Palanca

Control=1;
Contador=0;
save('controlEnt','Control')
[DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
DDA=DD;
while(1)
    [DI,DD]=OA_ValentiaRevisaPalanca(handles.OA);
    if(DD~=DDA)
        OA_ValentiaRecompensaD(handles.OA);
        Contador=Contador+1
    end
    DDA=DD;
    pause(.1)
    load('controlPellet','Pellet')
    if(Pellet==1)
       OA_ValentiaRecompensaD(handles.OA);
       Pellet=0;
       save('controlPellet','Pellet')
    end   
    load('controlEnt')
    if(Control==0)
        break
    end    
end 

OA_ValentiaEstimulo(handles.OA,'D',0,0)




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Control=0;
save('controlEnt','Control')
OA_ValentiaEstimulo(handles.OA,'D',0,0)


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
