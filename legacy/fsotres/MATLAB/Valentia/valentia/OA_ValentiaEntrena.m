function varargout = OA_ValentiaEntrena(varargin)
% OA_VALENTIAENTRENA M-file for OA_ValentiaEntrena.fig
%      OA_VALENTIAENTRENA, by itself, creates a new OA_VALENTIAENTRENA or raises the existing
%      singleton*.
%
%      H = OA_VALENTIAENTRENA returns the handle to a new OA_VALENTIAENTRENA or the handle to
%      the existing singleton*.
%
%      OA_VALENTIAENTRENA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIAENTRENA.M with the given input arguments.
%
%      OA_VALENTIAENTRENA('Property','Value',...) creates a new OA_VALENTIAENTRENA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaEntrena_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaEntrena_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaEntrena

% Last Modified by GUIDE v2.5 12-Nov-2012 11:49:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_ValentiaEntrena_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_ValentiaEntrena_OutputFcn, ...
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


% --- Executes just before OA_ValentiaEntrena is made visible.
function OA_ValentiaEntrena_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaEntrena (see VARARGIN)

% Choose default command line output for OA_ValentiaEntrena
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaEntrena wait for user response (see UIRESUME)
% uiwait(handles.figure1);
daqreset
handles.OA = OA_ValentiaInicio;
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaEntrena_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaEstimulo(handles.OA,'I',2,2);
OA_ValentiaPalanca(handles.OA,'I',1); 



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaEstimulo(handles.OA,'I',0,0);
OA_ValentiaPalanca(handles.OA,'I',2); 



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

OA_ValentiaRecompensaI(handles.OA);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaEstimulo(handles.OA,'D',2,2)
OA_ValentiaPalanca(handles.OA,'D',1); 


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaEstimulo(handles.OA,'D',0,0)
OA_ValentiaPalanca(handles.OA,'D',2); 



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaRecompensaD(handles.OA);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaElectrico(handles.OA,1)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OA_ValentiaElectrico(handles.OA,0)

