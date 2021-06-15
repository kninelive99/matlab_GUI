function varargout = LorenzSysGui(varargin)
% LORENZSYSGUI MATLAB code for LorenzSysGui.fig
%      LORENZSYSGUI, by itself, creates a new LORENZSYSGUI or raises the existing
%      singleton*.
%
%      H = LORENZSYSGUI returns the handle to a new LORENZSYSGUI or the handle to
%      the existing singleton*.
%
%      LORENZSYSGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LORENZSYSGUI.M with the given input arguments.
%
%      LORENZSYSGUI('Property','Value',...) creates a new LORENZSYSGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LorenzSysGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LorenzSysGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LorenzSysGui

% Last Modified by GUIDE v2.5 15-Mar-2021 07:30:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LorenzSysGui_OpeningFcn, ...
                   'gui_OutputFcn',  @LorenzSysGui_OutputFcn, ...
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


% --- Executes just before LorenzSysGui is made visible.
function LorenzSysGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LorenzSysGui (see VARARGIN)

handles.parameters = [10 2.666666 28];
handles.control = [30 0.02];
handles.initialcon = [1.0 1.0 1.0];
handles.mods = 'Euler';

set(handles.checkbox_1Dplot,'value',0)
set(handles.axes_1D_xyz,'visible','off')
set(handles.axes_1D_x,'visible','off')
set(handles.axes_1D_y,'visible','off')
set(handles.axes_1D_z,'visible','off')

[~,~,alpha] = imread('EWaC-logo.png');
handles.logo = imread('EWaC-logo.jpg');
image(handles.axes7,handles.logo,'alphadata',alpha)
set(handles.axes7,'visible','off')

sigma = handles.parameters(1);
beta = handles.parameters(2);
rho = handles.parameters(3);
t = handles.control(1);
dt = handles.control(2);
x1 = handles.initialcon(1);
y1 = handles.initialcon(2);
z1 = handles.initialcon(3);
n = ceil(t/dt);

[x,y,z] = LS_E(sigma,beta,rho,n,dt,x1,y1,z1);

p = plot3(x,y,z);
xlabel('X'); ylabel('Y'); zlabel('Z')
grid on

% Choose default command line output for LorenzSysGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LorenzSysGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LorenzSysGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_sigma as a double

handles.parameters(1) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beta as text
%        str2double(get(hObject,'String')) returns contents of edit_beta as a double

handles.parameters(2) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double

handles.parameters(3) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_sigma.
function pushbutton_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_set.
function pushbutton_set_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_rho.
function pushbutton_rho_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_timeint.
function pushbutton_timeint_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_timeint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_time.
function pushbutton_time_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit_timeint_Callback(hObject, eventdata, handles)
% hObject    handle to edit_timeint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_timeint as text
%        str2double(get(hObject,'String')) returns contents of edit_timeint as a double

handles.control(2) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_timeint_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_timeint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_steps_Callback(hObject, eventdata, handles)
% hObject    handle to edit_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_steps as text
%        str2double(get(hObject,'String')) returns contents of edit_steps as a double

handles.control(1) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_integration2.
function popupmenu_integration2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_integration2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_integration2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_integration2

str = get(hObject,'string');
val = get(hObject,'value');

switch str{val}
    case 'Euler'
        handles.mods = 'Euler';
    case 'RK4'
        handles.mods = 'RK4';
    case 'AB3'
        handles.mods = 'AB3';
end

% save handles structure
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popupmenu_integration2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_integration2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_style.
function popupmenu_style_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_style contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_style


% --- Executes during object creation, after setting all properties.
function popupmenu_style_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_creat.
function pushbutton_creat_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_creat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function [x,y,z] = LS_E(sigma,beta,rho,n,dt,x1,y1,z1)
% LorenzSystem: Euler's schemes

x = zeros(1,n); y = zeros(1,n); z = zeros(1,n); 
x(1) = x1; y(1) = y1; z(1) = z1;
for i=2:n
    x(i) = x(i-1)+sigma*(y(i-1)-x(i-1))*dt;
    y(i) = y(i-1)+(rho*x(i-1)-x(i-1)*z(i-1)-y(i-1))*dt;
    z(i) = z(i-1)+(x(i-1)*y(i-1)-beta*z(i-1))*dt;
end


function [x,y,z] = LS_R(sigma,beta,rho,n,dt,x1,y1,z1)
% LorenzSystem: RK schemes

x = zeros(1,n); y = zeros(1,n); z = zeros(1,n); 
x(1) = x1; y(1) = y1; z(1) = z1;
for i=2:n
    [x(i),y(i),z(i)] = LS_rk4(sigma,beta,rho,dt,x(i-1),y(i-1),z(i-1));
end

function [xn,yn,zn] = LS_rk4(sigma,beta,rho,dt,x1,y1,z1)
% compute RK4

% f1
xf1 = sigma*(y1-x1);
yf1 = rho*x1-z1*x1-y1;
zf1 = x1*y1-beta*z1;

% f2
x2 = x1+0.5*dt*xf1;
y2 = y1+0.5*dt*yf1;
z2 = z1+0.5*dt*zf1;
xf2 = sigma*(y2-x2);
yf2 = rho*x2-z2*x2-y2;
zf2 = x2*y2-beta*z2;

% f3
x3 = x1+0.5*dt*xf2;
y3 = y1+0.5*dt*yf2;
z3 = z1+0.5*dt*zf2;
xf3 = sigma*(y3-x3);
yf3 = rho*x3-z3*x3-y3;
zf3 = x3*y3-beta*z3;

% f4
x4 = x1+dt*xf3;
y4 = y1+dt*yf3;
z4 = z1+dt*zf3;
xf4 = sigma*(y4-x4);
yf4 = rho*x4-z4*x4-y4;
zf4 = x4*y4-beta*z4;

% combine
xn = x1+(dt/6)*(xf1+2*xf2+2*xf3+xf4);
yn = y1+(dt/6)*(yf1+2*yf2+2*yf3+yf4);
zn = z1+(dt/6)*(zf1+2*zf2+2*zf3+zf4);

function [x,y,z] = LS_A(sigma,beta,rho,n,dt,x1,y1,z1)
% LorenzSystem: AB schemes

x = zeros(1,n+2); y = zeros(1,n+2); y = zeros(1,n+2);
x(3) = x1; y(3) = y1; z(3) = z1;

xf0 = sigma*(y1-x1);
yf0 = rho*x1-z1*x1-y1;
zf0 = x1*y1-beta*z1;

x_1 = x1-dt*xf0;
y_1 = y1-dt*yf0;
z_1 = z1-dt*zf0;
x(2) = x_1; y(2) = y_1; z(2) = z_1; 

xf1 = sigma*(y_1-x_1);
yf1 = rho*x_1-z_1*x_1-y_1;
zf1 = x_1*y_1-beta*z_1;

x_2 = x_1-dt*sigma*(y_1-x_1);
y_2 = y_1-dt*(rho*x_1-z_1*x_1-y_1);
z_2 = z_1-dt*(x_1*y_1-beta*z_1);
x(1) = x_2; y(1) = y_2; z(1) = z_2; 

for i=4:n+2
    xf0 = sigma*(y(i-1)-x(i-1));
    yf0 = rho*x(i-1)-z(i-1)*x(i-1)-y(i-1);
    zf0 = x(i-1)*y(i-1)-beta*z(i-1);
    
    xf1 = sigma*(y(i-2)-x(i-2));
    yf1 = rho*x(i-2)-z(i-2)*x(i-2)-y(i-2);
    zf1 = x(i-2)*y(i-2)-beta*z(i-2);
    
    xf2 = sigma*(y(i-3)-x(i-3));
    yf2 = rho*x(i-3)-z(i-3)*x(i-3)-y(i-3);
    zf2 = x(i-3)*y(i-3)-beta*z(i-3);
    
    x(i) = x(i-1)+(dt/12)*(23*xf0-16*xf1+5*xf2);
    y(i) = y(i-1)+(dt/12)*(23*yf0-16*yf1+5*yf2);
    z(i) = z(i-1)+(dt/12)*(23*zf0-16*zf1+5*zf2);
end
nn = length(x);
x = x(3:nn); y = y(3:nn); z = z(3:nn);


% --- Executes during object creation, after setting all properties.
function axes_3D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_3D


% --- Executes on button press in pushbutton_euler.
function pushbutton_euler_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_euler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sigma = handles.parameters(1);
beta = handles.parameters(2);
rho = handles.parameters(3);
n = handles.control(1);
dt = handles.control(2);
x1 = handles.initialcon(1);
y1 = handles.initialcon(2);
z1 = handles.initialcon(3);

[x,y,z] = LS_E(sigma,beta,rho,n,dt,x1,y1,z1);

if get(handles.checkbox_1Dplot,'value') == 0
    set(handles.axes_3D,'visible','on')
    set(handles.axes_1D_xyz,'visible','off')
    set(handles.axes_1D_x,'visible','off')
    set(handles.axes_1D_y,'visible','off')
    set(handles.axes_1D_z,'visible','off')
    cla(handles.axes_1D_xyz)
    cla(handles.axes_1D_x)
    cla(handles.axes_1D_y)
    cla(handles.axes_1D_z)
else
    set(handles.axes_3D,'visible','off')
    cla(handles.axes_3D)
    set(handles.axes_1D_xyz,'visible','on')
    set(handles.axes_1D_x,'visible','on')
    set(handles.axes_1D_y,'visible','on')
    set(handles.axes_1D_z,'visible','on')
end

if get(handles.checkbox_1Dplot,'value') == 0
    axes(handles.axes_3D)
    plot3(x,y,z)
    grid on
else
    t = linspace(1,n,n);
    axes(handles.axes_1D_xyz)
    plot3(x,y,z)
    grid on
    axes(handles.axes_1D_x)
    plot(t,x)
    grid on
    axes(handles.axes_1D_y)
    plot(t,y)
    grid on
    axes(handles.axes_1D_z)
    plot(t,z)
    grid on
end


% --- Executes on button press in pushbutton_rk.
function pushbutton_rk_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sigma = handles.parameters(1);
beta = handles.parameters(2);
rho = handles.parameters(3);
n = handles.control(1);
dt = handles.control(2);
x1 = handles.initialcon(1);
y1 = handles.initialcon(2);
z1 = handles.initialcon(3);

[x,y,z] = LS_R(sigma,beta,rho,n,dt,x1,y1,z1);

if get(handles.checkbox_1Dplot,'value') == 0
    set(handles.axes_3D,'visible','on')
    set(handles.axes_1D_xyz,'visible','off')
    set(handles.axes_1D_x,'visible','off')
    set(handles.axes_1D_y,'visible','off')
    set(handles.axes_1D_z,'visible','off')
    cla(handles.axes_1D_xyz)
    cla(handles.axes_1D_x)
    cla(handles.axes_1D_y)
    cla(handles.axes_1D_z)
else
    set(handles.axes_3D,'visible','off')
    cla(handles.axes_3D)
    set(handles.axes_1D_xyz,'visible','on')
    set(handles.axes_1D_x,'visible','on')
    set(handles.axes_1D_y,'visible','on')
    set(handles.axes_1D_z,'visible','on')
end

if get(handles.checkbox_1Dplot,'value') == 0
    axes(handles.axes_3D)
    plot3(x,y,z)
    grid on
else
    t = linspace(1,n,n);
    axes(handles.axes_1D_xyz)
    plot3(x,y,z)
    grid on
    axes(handles.axes_1D_x)
    plot(t,x)
    grid on
    axes(handles.axes_1D_y)
    plot(t,y)
    grid on
    axes(handles.axes_1D_z)
    plot(t,z)
    grid on
end


% --- Executes on button press in pushbutton_ab.
function pushbutton_ab_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sigma = handles.parameters(1);
beta = handles.parameters(2);
rho = handles.parameters(3);
n = handles.control(1);
dt = handles.control(2);
x1 = handles.initialcon(1);
y1 = handles.initialcon(2);
z1 = handles.initialcon(3);

[x,y,z] = LS_A(sigma,beta,rho,n,dt,x1,y1,z1);

if get(handles.checkbox_1Dplot,'value') == 0
    set(handles.axes_3D,'visible','on')
    set(handles.axes_1D_xyz,'visible','off')
    set(handles.axes_1D_x,'visible','off')
    set(handles.axes_1D_y,'visible','off')
    set(handles.axes_1D_z,'visible','off')
    cla(handles.axes_1D_xyz)
    cla(handles.axes_1D_x)
    cla(handles.axes_1D_y)
    cla(handles.axes_1D_z)
else
    set(handles.axes_3D,'visible','off')
    cla(handles.axes_3D)
    set(handles.axes_1D_xyz,'visible','on')
    set(handles.axes_1D_x,'visible','on')
    set(handles.axes_1D_y,'visible','on')
    set(handles.axes_1D_z,'visible','on')
end

if get(handles.checkbox_1Dplot,'value') == 0
    axes(handles.axes_3D)
    plot3(x,y,z)
    grid on
else
    t = linspace(1,n,n);
    axes(handles.axes_1D_xyz)
    plot3(x,y,z)
    grid on
    axes(handles.axes_1D_x)
    plot(t,x)
    grid on
    axes(handles.axes_1D_y)
    plot(t,y)
    grid on
    axes(handles.axes_1D_z)
    plot(t,z)
    grid on
end


% --- Executes on button press in checkbox_1Dplot.
function checkbox_1Dplot_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_1Dplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_1Dplot

% if get(hObject,'value') == 0
%     set(handles.axes_3D,'visible','on')
%     set(handles.axes_1D_xyz,'visible','off')
%     set(handles.axes_1D_x,'visible','off')
%     set(handles.axes_1D_y,'visible','off')
%     set(handles.axes_1D_z,'visible','off')
% else
%     set(handles.axes_3D,'visible','off')
%     set(handles.axes_1D_xyz,'visible','on')
%     set(handles.axes_1D_x,'visible','on')
%     set(handles.axes_1D_y,'visible','on')
%     set(handles.axes_1D_z,'visible','on')
% end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.parameters = [10 2.666666 28];
handles.control = [30 0.02];
handles.initialcon = [1.0 1.0 1.0];
handles.mods = 'Euler';

guidata(hObject,handles)

set(handles.checkbox_1Dplot,'value',0)
set(handles.axes_3D,'visible','on')
set(handles.axes_1D_xyz,'visible','off')
set(handles.axes_1D_x,'visible','off')
set(handles.axes_1D_y,'visible','off')
set(handles.axes_1D_z,'visible','off')
cla(handles.axes_1D_xyz)
cla(handles.axes_1D_x)
cla(handles.axes_1D_y)
cla(handles.axes_1D_z)

set(handles.edit_sigma,'string','10')
set(handles.edit_beta,'string','2.666666')
set(handles.edit_rho,'string','28')
set(handles.edit_steps,'string','30')
set(handles.edit_timeint,'string','0.02')
set(handles.edit_x,'string','1.0')
set(handles.edit_y,'string','1.0')
set(handles.edit_z,'string','1.0')
set(handles.popupmenu_integration2,'value',1)

sigma = handles.parameters(1);
beta = handles.parameters(2);
rho = handles.parameters(3);
t = handles.control(1);
dt = handles.control(2);
x1 = handles.initialcon(1);
y1 = handles.initialcon(2);
z1 = handles.initialcon(3);
n = ceil(t/dt);

[x,y,z] = LS_E(sigma,beta,rho,n,dt,x1,y1,z1);

axes(handles.axes_3D)
p = plot3(x,y,z);
xlabel('X'); ylabel('Y'); zlabel('Z')
grid on


function edit_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z as text
%        str2double(get(hObject,'String')) returns contents of edit_z as a double

handles.initialcon(3) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double

handles.initialcon(1) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y as text
%        str2double(get(hObject,'String')) returns contents of edit_y as a double

handles.initialcon(2) = str2num(get(hObject,'string'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_integration2.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_integration2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_integration2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_integration2

% str = get(hObject,'string');
% val = get(hObject,'value');
% 
% switch str(val)
%     case 'Euler'
% %         handles.
%     case 'RK4'
% %         handles.
%     case 'AB3'
% %         handles.
% end
% 
% guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_integration2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_run.
function pushbutton_run_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sigma = handles.parameters(1);
beta = handles.parameters(2);
rho = handles.parameters(3);
t = handles.control(1);
dt = handles.control(2);
x1 = handles.initialcon(1);
y1 = handles.initialcon(2);
z1 = handles.initialcon(3);
n = ceil(t/dt);

if get(handles.checkbox_1Dplot,'value') == 0
    set(handles.axes_3D,'visible','on')
    set(handles.axes_1D_xyz,'visible','off')
    set(handles.axes_1D_x,'visible','off')
    set(handles.axes_1D_y,'visible','off')
    set(handles.axes_1D_z,'visible','off')
    cla(handles.axes_1D_xyz)
    cla(handles.axes_1D_x)
    cla(handles.axes_1D_y)
    cla(handles.axes_1D_z)
else
    set(handles.axes_3D,'visible','off')
    cla(handles.axes_3D)
    set(handles.axes_1D_xyz,'visible','on')
    set(handles.axes_1D_x,'visible','on')
    set(handles.axes_1D_y,'visible','on')
    set(handles.axes_1D_z,'visible','on')
end

switch handles.mods
    case 'Euler'
        [x,y,z] = LS_E(sigma,beta,rho,n,dt,x1,y1,z1);
    case 'RK4'
        [x,y,z] = LS_R(sigma,beta,rho,n,dt,x1,y1,z1);
    case 'AB3'
        [x,y,z] = LS_A(sigma,beta,rho,n,dt,x1,y1,z1);
end

if get(handles.checkbox_1Dplot,'value') == 0
    axes(handles.axes_3D)
    plot3(x,y,z)
    xlabel('X'); ylabel('Y'); zlabel('Z')
    grid on
else
    t = linspace(1,n,n);
    axes(handles.axes_1D_xyz)
    plot3(x,y,z)
    xlabel('X'); ylabel('Y'); zlabel('Z')
    grid on
    axes(handles.axes_1D_x)
    plot(t,x)
    xlabel('t'); ylabel('X')
    grid on
    text(0.5,0.92,'t-X','units','normalized','fontweight','bold','fontsize',12,'backgroundcolor','w','edgecolor','k','horizontalalignment','center')
    axes(handles.axes_1D_y)
    plot(t,y)
    xlabel('t'); ylabel('Y')
    grid on
    text(0.5,0.92,'t-Y','units','normalized','fontweight','bold','fontsize',12,'backgroundcolor','w','edgecolor','k','horizontalalignment','center')
    axes(handles.axes_1D_z)
    plot(t,z)
    xlabel('t'); ylabel('Z')
    grid on
    text(0.5,0.92,'t-Z','units','normalized','fontweight','bold','fontsize',12,'backgroundcolor','w','edgecolor','k','horizontalalignment','center')
end



% --- Executes on selection change in popupmenu_rotate.
function popupmenu_rotate_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_rotate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_rotate


% --- Executes during object creation, after setting all properties.
function popupmenu_rotate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
