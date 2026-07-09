function varargout = OA_ValentiaGPosicion(varargin)
% OA_VALENTIAGPOSICION M-file for OA_ValentiaGPosicion.fig
%      OA_VALENTIAGPOSICION, by itself, creates a new OA_VALENTIAGPOSICION or raises the existing
%      singleton*.
%
%      H = OA_VALENTIAGPOSICION returns the handle to a new OA_VALENTIAGPOSICION or the handle to
%      the existing singleton*.
%
%      OA_VALENTIAGPOSICION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_VALENTIAGPOSICION.M with the given input arguments.
%
%      OA_VALENTIAGPOSICION('Property','Value',...) creates a new OA_VALENTIAGPOSICION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_ValentiaGPosicion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_ValentiaGPosicion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_ValentiaGPosicion

% Last Modified by GUIDE v2.5 10-Nov-2012 20:05:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_ValentiaGPosicion_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_ValentiaGPosicion_OutputFcn, ...
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


% --- Executes just before OA_ValentiaGPosicion is made visible.
function OA_ValentiaGPosicion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_ValentiaGPosicion (see VARARGIN)

% Choose default command line output for OA_ValentiaGPosicion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_ValentiaGPosicion wait for user response (see UIRESUME)
% uiwait(handles.figure1);

daqreset
handles.OA = OA_ValentiaInicio;
guidata(hObject, handles);

   


% --- Outputs from this function are returned to the command line.
function varargout = OA_ValentiaGPosicion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
get(hObject,'Min')
get(hObject,'Max')
get(hObject,'Value')

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vT=[];
for i=1:100
[P]=OA_ValentiaBuscaIzquierda(handles.OA)
end 





