function varargout = net_gui(varargin)
    % NET_GUI MATLAB code for net_gui.fig
    %      NET_GUI, by itself, creates a new NET_GUI or raises the existing
    %      singleton*.
    %
    %      H = NET_GUI returns the handle to a new NET_GUI or the handle to
    %      the existing singleton*.
    %
    %      NET_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in NET_GUI.M with the given input arguments.
    %
    %      NET_GUI('Property','Value',...) creates a new NET_GUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before net_gui_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to net_gui_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help net_gui

    % Last Modified by GUIDE v2.5 26-Mar-2017 19:50:32

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @net_gui_OpeningFcn, ...
                       'gui_OutputFcn',  @net_gui_OutputFcn, ...
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
end

% --- Executes just before net_gui is made visible.
function net_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to net_gui (see VARARGIN)

    %Data to plot
    handles.index = 1;

    % Choose default command line output for net_gui
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes net_gui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = net_gui_OutputFcn(hObject, eventdata, handles)
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
        varargout{1} = handles.output;
end

function distr = getdist(mu, sigma)
	distr = makedist('Normal');
	distr.mu = mu;
	distr.sigma = sigma;
end

% --- Executes on button press in resetbutton.
function resetbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resetbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	w_init = getdist(0, 8);
	t_init = getdist(2.75, 1.5);
	b_init = getdist(0, 3);

	weights = zeros(10);
    for i = 1:10
        for j = 1:10
            val = random(w_init);
            %cap values
            if val < -16 
                val = -16;
            end
            if val > 16
                val = 16;
            end
            
            weights(i, j) = val;
        end
    end
	disp(handles.statictext);
	disp(hObject);

    handles.statictext.String = mat2str(weights);

    n = 1;
    data = zeros(1, 100);
    data2 = zeros(1, 100);
    x = linspace(0, 100);

    while n < 100
        data = [data(2:end), sin(n)];
        data2 = [data2(2:end), 10+cos(n)];

        pause(0.02);
        plot( x, data, ...
              x, data2);
        n = n+1;
    end
end
