function varargout = ControlExperimento(varargin)
% CONTROLEXPERIMENTO M-file for ControlExperimento.fig
%      CONTROLEXPERIMENTO, by itself, creates a new CONTROLEXPERIMENTO or raises the existing
%      singleton*.
%
%      H = CONTROLEXPERIMENTO returns the handle to a new CONTROLEXPERIMENTO or the handle to
%      the existing singleton*.
%
%      CONTROLEXPERIMENTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROLEXPERIMENTO.M with the given input arguments.
%
%      CONTROLEXPERIMENTO('Property','Value',...) creates a new CONTROLEXPERIMENTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ControlExperimento_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ControlExperimento_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ControlExperimento

% Last Modified by GUIDE v2.5 07-Jun-2012 19:01:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ControlExperimento_OpeningFcn, ...
                   'gui_OutputFcn',  @ControlExperimento_OutputFcn, ...
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


% --- Executes just before ControlExperimento is made visible.
function ControlExperimento_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ControlExperimento (see VARARGIN)

% Choose default command line output for ControlExperimento
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ControlExperimento wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ControlExperimento_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
