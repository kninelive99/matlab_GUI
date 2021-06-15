function varargout = LorenzSys_c(varargin)
% LORENZSYS_C MATLAB code for LorenzSys_c.fig
%      LORENZSYS_C, by itself, creates a new LORENZSYS_C or raises the existing
%      singleton*.
%
%      H = LORENZSYS_C returns the handle to a new LORENZSYS_C or the handle to
%      the existing singleton*.
%
%      LORENZSYS_C('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LORENZSYS_C.M with the given input arguments.
%
%      LORENZSYS_C('Property','Value',...) creates a new LORENZSYS_C or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LorenzSys_c_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LorenzSys_c_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LorenzSys_c

% Last Modified by GUIDE v2.5 10-May-2021 00:07:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LorenzSys_c_OpeningFcn, ...
                   'gui_OutputFcn',  @LorenzSys_c_OutputFcn, ...
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


% --- Executes just before LorenzSys_c is made visible.
function LorenzSys_c_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LorenzSys_c (see VARARGIN)

handles.parameters = [10 2.666666 28];
handles.control = [30 0.02];
handles.initialcon = [1.0 1.0 1.0];
handles.integration1 = 'RK4';
handles.integration2 = 'Euler';
handles.mods = 1.0;
handles.t00 = 15;

[~,~,alpha] = imread('EWaC-logo.png');
handles.logo = imread('EWaC-logo.jpg');
image(handles.axes8,handles.logo,'alphadata',alpha)
set(handles.axes8,'visible','off')

set(handles.axes1,'visible','off')
set(handles.axes2,'visible','off')
set(handles.axes3,'visible','off')
set(handles.axes4,'visible','off')
set(handles.axes5,'visible','off')
set(handles.axes6,'visible','off')
set(handles.axes7,'visible','off')

set(handles.radiobutton4,'value',1.0)
set(handles.radiobutton1,'value',1.0)
set(handles.radiobutton7,'value',1.0)

set(handles.uibuttongroup2,'visible','on')
set(handles.uibuttongroup4,'visible','off')
set(handles.uibuttongroup5,'visible','off')

set(handles.text12,'string','Hello World !')
set(handles.text13,'string','mod 1: 3D plot & the absolute distance of two endpoints.')
set(handles.text14,'string','mod 2: compute error or deviation on each time.')
set(handles.text15,'string','mod 3: computation time or RMSE with different dt.')

% Choose default command line output for LorenzSys_c
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LorenzSys_c wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LorenzSys_c_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

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

x = zeros(1,n+2); y = zeros(1,n+2); z = zeros(1,n+2);
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

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

handles.initialcon(1) = str2num(get(hObject,'string'));
guidata(hObject,handles)

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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double

handles.initialcon(2) = str2num(get(hObject,'string'));
guidata(hObject,handles)

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

handles.initialcon(3) = str2num(get(hObject,'string'));
guidata(hObject,handles)

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

handles.control(1) = str2num(get(hObject,'string'));
guidata(hObject,handles)

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

handles.control(2) = str2num(get(hObject,'string'));
guidata(hObject,handles)

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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

str = get(hObject,'string');
val = get(hObject,'value');

switch str{val}
    case 'Euler'
        handles.integration1 = 'Euler';
    case 'RK4'
        handles.integration1 = 'RK4';
    case 'AB3'
        handles.integration1 = 'AB3';
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

str = get(hObject,'string');
val = get(hObject,'value');

switch str{val}
    case 'Euler'
        handles.integration2 = 'Euler';
    case 'RK4'
        handles.integration2 = 'RK4';
    case 'AB3'
        handles.integration2 = 'AB3';
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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

handles.t00 = str2num(get(hObject,'string'));
guidata(hObject,handles)

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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


function c = m_c(n)

switch n
    case 1
        c = [0 0.4470 0.7410];
    case 2
        c = [0.8500 0.3250 0.0980];
    case 3
        c = [0.9290 0.6940 0.1250];
    case 4
        c = [0.4940 0.1840 0.5560];
    case 5
        c = [0.4660 0.6740 0.1880];
    case 6
        c = [0.3010 0.7450 0.9330];
    case 7
        c = [0.6350 0.0780 0.1840];
    otherwise
        c = nan;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

sigma = handles.parameters(1);
beta = handles.parameters(2);
rho = handles.parameters(3);
t = handles.control(1);
dt = handles.control(2);
x0 = handles.initialcon(1);
y0 = handles.initialcon(2);
z0 = handles.initialcon(3);
n = ceil(t/dt);
t00 = handles.t00;
iname1 = handles.integration1;
iname2 = handles.integration2;
cla(handles.axes1,'reset')
cla(handles.axes2,'reset')
cla(handles.axes3,'reset')
cla(handles.axes4,'reset')
cla(handles.axes5,'reset')
cla(handles.axes6,'reset')
cla(handles.axes7,'reset')
set(handles.axes1,'visible','off')
set(handles.axes2,'visible','off')
set(handles.axes3,'visible','off')
set(handles.axes4,'visible','off')
set(handles.axes5,'visible','off')
set(handles.axes6,'visible','off')
set(handles.axes7,'visible','off')

switch handles.integration1
    case 'Euler'
        i_num1 = 1;
    case 'RK4'
        i_num1 = 2;
    case 'AB3'
        i_num1 = 3;
end

switch handles.integration2
    case 'Euler'
        i_num2 = 1;
    case 'RK4'
        i_num2 = 2;
    case 'AB3'
        i_num2 = 3;
end

if i_num1 == i_num2
    post = 'please choose 2 different integration';
    set(handles.text12,'string',post)
    set(handles.text13,'string','')
    set(handles.text14,'string','')
    set(handles.text15,'string','')
else
    i_num = i_num1+i_num2;
    set(handles.text12,'string','')
    
    switch handles.mods
        case 1.0
            modc1 = get(handles.radiobutton1,'value');
            [str1,str2,str3,str4,x1,x2,y1,y2,z1,z2,n1] = mod1(sigma,beta,rho,t,dt,x0,y0,z0,t00,i_num,modc1,iname1,iname2);
            set(handles.text12,'string',str1)
            set(handles.text13,'string',str2)
            set(handles.text14,'string',str3)
            set(handles.text15,'string',str4)
            set(handles.axes1,'visible','on')
            
            switch modc1
                case 1.0
                    axes(handles.axes1)
                    p1 = plot3(x1,y1,z1,'color',m_c(1));
                    hold on
                    p2 = plot3(x2,y2,z2,'color',m_c(5));
                    pp = plot3([x1(end) x2(end)],[y1(end) y2(end)],[z1(end) z2(end)],'color','r');
                    xlabel('X'); ylabel('Y'); zlabel('Z')
                    legend([p1 p2 pp],{iname1,iname2,'line of endpoints'},'fontsize',12,'location','northeast')
                    grid on
                case 0.0
                    axes(handles.axes1)
                    p1f = plot3(x1(1:n1),y1(1:n1),z1(1:n1),'--','color',m_c(1));
                    hold on
                    p1s = plot3(x1(n1+1:end),y1(n1+1:end),z1(n1+1:end),'color','b');
                    p2f = plot3(x2(1:n1),y2(1:n1),z2(1:n1),'--','color',m_c(5));
                    p2s = plot3(x2(n1+1:end),y2(n1+1:end),z2(n1+1:end),'color','g');
                    pp = plot3([x1(end) x2(end)],[y1(end) y2(end)],[z1(end) z2(end)],'color','r');
                    xlabel('X'); ylabel('Y'); zlabel('Z')
                    legend([p1f p1s p2f p2s pp],{[iname1 ' part I'],[iname1 ' part II'],[iname2 ' part I'],[iname2 ' part II'],'line of endpoints'},'fontsize',12,'location','northeast')
                    grid on
            end
            set(handles.text2,'string',[iname1 ' v.s ' iname2])
            text(0.03,0.9,0.9,{'Draw integration 1. with blue color ;','Draw integration 2. with green color.'},'units','normalized','fontsize',14)
        case 2.0
            [error,emean,tt1,tt2,xee,yee,zee] = mod2(sigma,beta,rho,t,dt,x0,y0,z0,i_num);
            modc2 = get(handles.radiobutton10,'value');
            tplot = linspace(0,t,n);
            switch modc2
                case 1.0
                    set(handles.axes2,'visible','on')
                    set(handles.axes3,'visible','on')
                    
                    axes(handles.axes2)
                    plot(tplot,error)
                    xlabel('time'); ylabel('error')
                    title('error','fontsize',14)
                    grid on
                    
                    axes(handles.axes3)
                    plot(tplot,emean)
                    xlabel('time'); ylabel('mean square error')
                    title('mean error of times','fontsize',14)
                    grid on
                case 0.0
                    set(handles.axes4,'visible','on')
                    set(handles.axes5,'visible','on')
                    set(handles.axes6,'visible','on')
                    set(handles.axes7,'visible','on')
                    
                    axes(handles.axes4)
                    plot(tplot,xee)
                    xlabel('time'); ylabel('deviation')
                    text(0.04,0.9,'t-X','units','normalized','fontweight','bold','edgecolor','k','backgroundcolor','w','fontsize',12)
                    grid on
                    
                    axes(handles.axes5)
                    plot(tplot,yee)
                    xlabel('time'); ylabel('deviation')
                    text(0.04,0.9,'t-Y','units','normalized','fontweight','bold','edgecolor','k','backgroundcolor','w','fontsize',12)
                    grid on
                    
                    axes(handles.axes6)
                    plot(tplot,zee)
                    xlabel('time'); ylabel('deviation')
                    text(0.04,0.9,'t-Z','units','normalized','fontweight','bold','edgecolor','k','backgroundcolor','w','fontsize',12)
                    grid on
                    
                    axes(handles.axes7)
                    plot(tplot,error)
                    xlabel('time'); ylabel('error')
                    text(0.04,0.9,'3D err.','units','normalized','fontweight','bold','edgecolor','k','backgroundcolor','w','fontsize',12)
                    grid on
            end
%             set(handles.text12,'string','computation time: (ms)')
%             set(handles.text13,'string',[iname1 ' : ' num2str(tt1)])
%             set(handles.text14,'string',[iname2 ' : ' num2str(tt2)])
%             set(handles.text15,'string','')
            set(handles.text2,'string',[iname1 ' - ' iname2])
            
            set(handles.text12,'string',['The absolute distance(' iname1 '-' iname2 ') is defined as "error",'])
            set(handles.text13,'string','and the difference in single dimension is defined as')
            set(handles.text14,'string','"deviatoin".')
            set(handles.text15,'string',['Computation time (ms): ' iname1 ': ' num2str(tt1,'%.3f') ' // ' iname2 ': ' num2str(tt2,'%.3f')])
        case 3.0
            linear_r = get(handles.checkbox1,'value');
            set(handles.axes1,'visible','on')
            axes(handles.axes1)
            modc3 = get(handles.radiobutton7,'value');
            switch modc3
                case 1.0
                    [tnn,te1,te2] = mod3_t(sigma,beta,rho,t,x0,y0,z0,i_num,i_num1);
                    yyaxis left
                    pe1 = plot(tnn,te1,'-','color',m_c(1));
                    xlabel('dt')
                    ylabel('computation time (10^-^3 sec)')
                    xticks(0:0.0025:0.025)
                    xlim([0 0.021])
                    set(gca,'ycolor','k')
                    grid on
                    hold on
                    pe2 = plot(tnn,te2,'-','color',m_c(2));
                    yyaxis right
                    ped = plot(tnn,te1-te2,'--','color',m_c(4));
                    ylabel('deviation (10^-^3 sec)')
                    legend([pe1 pe2 ped],{iname1,iname2,[iname1 '-' iname2]},'fontsize',12)
                    set(gca,'ycolor',m_c(4))
                    set(handles.text12,'string','')
                    set(handles.text13,'string','')
                    set(handles.text14,'string','')
                    set(handles.text15,'string','')
                    set(handles.text2,'string',[iname1 ' v.s ' iname2])
                case 0.0
                    [tnn,error,cc,m] = mod3_e(sigma,beta,rho,t,x0,y0,z0,i_num);
                    plot(tnn,error,'color',m_c(1));
                    xlabel('dt')
                    ylabel('error')
                    xticks(0:0.0025:0.025)
                    xlim([0 0.021])
                    grid on
                    if linear_r == 1.0
                        hold on
                        plot(tnn,cc,'--','color',m_c(1))
                        hold off
                        set(handles.text12,'string',['Slope = ' mat2str(m)])
                    else
                        set(handles.text12,'string','')
                    end
                    set(handles.text13,'string','')
                    set(handles.text14,'string','')
                    set(handles.text15,'string','')
                    set(handles.text2,'string',[iname1 ' v.s ' iname2])
            end
    end
end
guidata(hObject,handles)

function [str1,str2,str3,str4,x1,x2,y1,y2,z1,z2,n1] = mod1(sigma,beta,rho,t,dt,x0,y0,z0,t00,i_num,modc1,iname1,iname2)
n = ceil(t/dt);
n1 = ceil(t00/dt);
n2 = n-n1;
x1 = nan(n,1); y1 = x1; z1 = x1;
x2 = x1; y2 = x1; z2 = x1;
switch modc1
    case 1.0
        switch i_num
            case 3
                [x1,y1,z1] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
                [x2,y2,z2] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
            case 4
                [x1,y1,z1] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
                [x2,y2,z2] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
            case 5
                [x1,y1,z1] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
                [x2,y2,z2] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
        end
    case 0.0
        switch i_num
            case 3
                [x1(1:n1),y1(1:n1),z1(1:n1)] = LS_E(sigma,beta,rho,n1,dt,x0,y0,z0);
                [x1(n1+1:end),y1(n1+1:end),z1(n1+1:end)] = LS_E(sigma,beta,rho,n2,dt,x1(n1),y1(n1),z1(n1));
                [x2(1:n1),y2(1:n1),z2(1:n1)] = LS_R(sigma,beta,rho,n1,dt,x0,y0,z0);
                [x2(n1+1:end),y2(n1+1:end),z2(n1+1:end)] = LS_R(sigma,beta,rho,n2,dt,x2(n1),y2(n1),z2(n1));
            case 4
                [x1(1:n1),y1(1:n1),z1(1:n1)] = LS_E(sigma,beta,rho,n1,dt,x0,y0,z0);
                [x1(n1+1:end),y1(n1+1:end),z1(n1+1:end)] = LS_E(sigma,beta,rho,n2,dt,x1(n1),y1(n1),z1(n1));
                [x2(1:n1),y2(1:n1),z2(1:n1)] = LS_A(sigma,beta,rho,n1,dt,x0,y0,z0);
                [x2(n1+1:end),y2(n1+1:end),z2(n1+1:end)] = LS_A(sigma,beta,rho,n2,dt,x2(n1),y2(n1),z2(n1));
            case 5
                [x1(1:n1),y1(1:n1),z1(1:n1)] = LS_R(sigma,beta,rho,n1,dt,x0,y0,z0);
                [x1(n1+1:end),y1(n1+1:end),z1(n1+1:end)] = LS_R(sigma,beta,rho,n2,dt,x1(n1),y1(n1),z1(n1));
                [x2(1:n1),y2(1:n1),z2(1:n1)] = LS_A(sigma,beta,rho,n1,dt,x0,y0,z0);
                [x2(n1+1:end),y2(n1+1:end),z2(n1+1:end)] = LS_A(sigma,beta,rho,n2,dt,x2(n1),y2(n1),z2(n1));
        end
end

distance = power((x1(end)-x2(end))^2+(y1(end)-y2(end))^2+(z1(end)-z2(end))^2,0.5);
% str1 = ['(1) = ' iname1 ' // ' '(2) = ' iname2 '   (x,y,z) = endpoint located on'];
% str2 = ['x1 = ' num2str(x1(end),'%.2f') ' // x2 = ' num2str(x2(end),'%.2f') ' // error = ' num2str(distance,'%.2f')];
% str3 = ['y1 = ' num2str(y1(end),'%.2f') ' // y2 = ' num2str(y2(end),'%.2f')];
% str4 = ['z1 = ' num2str(z1(end),'%.2f') ' // z2 = ' num2str(z2(end),'%.2f')];

str1 = '*(x,y,z) : position coordinate of endpoint.';
str2 = ['(1) ' iname1 ' : (' num2str(x1(end),'%.2f') ' , ' num2str(y1(end),'%.2f') ' , ' num2str(z1(end),'%.2f') ')'];
str3 = ['(2) ' iname2 ' : (' num2str(x2(end),'%.2f') ' , ' num2str(y2(end),'%.2f') ' , ' num2str(z2(end),'%.2f') ')'];
str4 = ['Absolute distance of two endpoints : ' num2str(distance,'%.2f')];

function [error,emean,tt1,tt2,xee,yee,zee] = mod2(sigma,beta,rho,t,dt,x0,y0,z0,i_num)
n = ceil(t/dt);
x1 = nan(n,1); y1 = x1; z1 = x1;
x2 = x1; y2 = x1; z2 = x1;
switch i_num
    case 3
        t1 = tic;
        [x1,y1,z1] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
        tt1 = toc(t1)*1000;
        
        t2 = tic;
        [x2,y2,z2] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
        tt2 = toc(t2)*1000;
    case 4
        t1 = tic;
        [x1,y1,z1] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
        tt1 = toc(t1)*1000;
        
        t2 = tic;
        [x2,y2,z2] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
        tt2 = toc(t2)*1000;
    case 5
        t1 = tic;
        [x1,y1,z1] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
        tt1 = toc(t1)*1000;
        
        t2 = tic;
        [x2,y2,z2] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
        tt2 = toc(t2)*1000;
end

error = nan(n,1);
emean = error;
xee = nan(n,1); yee = xee; zee = xee;
for i = 1:n
    xee(i) = x1(i)-x2(i);
    yee(i) = y1(i)-y2(i);
    zee(i) = z1(i)-z2(i);
    xe = power(xee(i),2);
    ye = power(yee(i),2);
    ze = power(zee(i),2);
    error(i) = power(xe+ye+ze,0.5);
    emean(i) = sum(error(1:i))/i;
end

function [tnn,pe1,pe2] = mod3_t(sigma,beta,rho,t,x0,y0,z0,i_num,i_num1)
tnn = 0.0005:0.0005:0.02; nn = length(tnn);
te1 = zeros(nn,1); te2 = te1;
for i = 1:nn
    dt = tnn(i);
    n = ceil(t/dt);
    switch i_num
        case 3
            ts1 = tic;
            [~,~,~] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
            te1(i) = toc(ts1)*1000;
            
            ts2 = tic;
            [~,~,~] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
            te2(i) = toc(ts2)*1000;
            
            switch i_num1
                case 1
                    pe1 = te1;
                    pe2 = te2;
                case 2
                    pe1 = te2;
                    pe2 = te1;
            end
        case 4
            ts1 = tic;
            [~,~,~] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
            te1(i) = toc(ts1)*1000;
            
            ts2 = tic;
            [~,~,~] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
            te2(i) = toc(ts2)*1000;
            
            switch i_num1
                case 1
                    pe1 = te1;
                    pe2 = te2;
                case 3
                    pe1 = te2;
                    pe2 = te1;
            end
        case 5
            ts1 = tic;
            [~,~,~] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
            te1(i) = toc(ts1)*1000;
            
            ts2 = tic;
            [~,~,~] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
            te2(i) = toc(ts2)*1000;
            
            switch i_num1
                case 2
                    pe1 = te1;
                    pe2 = te2;
                case 3
                    pe1 = te2;
                    pe2 = te1;
            end
    end
end

function [tnn,error,cc,m] = mod3_e(sigma,beta,rho,t,x0,y0,z0,i_num)
tnn = 0.0005:0.0005:0.02; nn = length(tnn);
error = zeros(nn,1);

for i = 1:nn
    dt = tnn(i);
    n = ceil(t/dt);
    switch i_num
        case 3
            [x1,y1,z1] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
            [x2,y2,z2] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
        case 4
            [x1,y1,z1] = LS_E(sigma,beta,rho,n,dt,x0,y0,z0);
            [x2,y2,z2] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
        case 5
            [x1,y1,z1] = LS_R(sigma,beta,rho,n,dt,x0,y0,z0);
            [x2,y2,z2] = LS_A(sigma,beta,rho,n,dt,x0,y0,z0);
    end
    
    for j = 1:n
        xe = power(x1(j)-x2(j),2);
        ye = power(y1(j)-y2(j),2);
        ze = power(z1(j)-z2(j),2);
        er = power(xe+ye+ze,0.5);
        error(i) = error(i)+er;
    end
    error(i) = error(i)/n;
end
[~,cc,m] = cc0107(tnn,error);
m = round(m,2);

function [x,y,a] = cc0107(xs,ys)
% correlation
xbar = mean(xs);
ybar = mean(ys);
nn = length(xs);
xy = 0; xx = 0; yy = 0;
for i=1:nn
    xy = xy+(xs(i)-xbar)*(ys(i)-ybar);
    xx = xx+power(xs(i)-xbar,2);
    yy = yy+power(ys(i)-ybar,2);
end

r = round(xy/(power(xx,0.5)*power(yy,0.5)),4);

% y = ax+b
a = xy/xx;
b = ybar-a*xbar;

x = xs;
y = a*x+b;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.parameters = [10 2.666666 28];
handles.control = [30 0.02];
handles.initialcon = [1.0 1.0 1.0];
handles.integration1 = 'RK4';
handles.integration2 = 'Euler';
handles.mods = 1.0;
handles.t00 = 15;

guidata(hObject,handles)

cla(handles.axes1,'reset')
cla(handles.axes2,'reset')
cla(handles.axes3,'reset')
cla(handles.axes4,'reset')
cla(handles.axes5,'reset')
cla(handles.axes6,'reset')
cla(handles.axes7,'reset')
set(handles.axes1,'visible','off')
set(handles.axes2,'visible','off')
set(handles.axes3,'visible','off')
set(handles.axes4,'visible','off')
set(handles.axes5,'visible','off')
set(handles.axes6,'visible','off')
set(handles.axes7,'visible','off')

set(handles.radiobutton4,'value',1.0)
set(handles.radiobutton1,'value',1.0)
set(handles.radiobutton7,'value',1.0)
set(handles.radiobutton10,'value',1.0)

set(handles.edit1,'string','1.0')
set(handles.edit4,'string','1.0')
set(handles.edit5,'string','1.0')
set(handles.popupmenu1,'value',2)
set(handles.popupmenu2,'value',1)
set(handles.edit6,'string','30')
set(handles.edit7,'string','0.02')
set(handles.edit8,'string','15')
set(handles.checkbox1,'value',0)

set(handles.uibuttongroup2,'visible','on')
set(handles.uibuttongroup4,'visible','off')
set(handles.uibuttongroup5,'visible','off')

set(handles.text12,'string','Hello World !')
set(handles.text13,'string','mod 1: 3D plot & the absolute distance of two endpoints.')
set(handles.text14,'string','mod 2: compute error or deviation on each time.')
set(handles.text15,'string','mod 3: computation time or RMSE with different dt.')

set(handles.text2,'string','Comparison Test')
guidata(hObject,handles)

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

switch get(hObject,'value')
    case 1.0
        set(handles.uibuttongroup2,'visible','on')
        set(handles.uibuttongroup4,'visible','off')
        set(handles.uibuttongroup5,'visible','off')
        handles.mods = 1.0;
    case 0.0
        set(handles.uibuttongroup2,'visible','off')
end

guidata(hObject,handles)

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6

switch get(hObject,'value')
    case 1.0
        set(handles.uibuttongroup2,'visible','off')
        set(handles.uibuttongroup4,'visible','on')
        set(handles.uibuttongroup5,'visible','off')
        handles.mods = 3.0;
    case 0.0
        set(handles.uibuttongroup4,'visible','off')
end

guidata(hObject,handles)

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5

switch get(hObject,'value')
    case 1.0
        set(handles.uibuttongroup2,'visible','off')
        set(handles.uibuttongroup4,'visible','off')
        set(handles.uibuttongroup5,'visible','on')
        handles.mods = 2.0;
    case 0.0
        set(handles.uibuttongroup5,'visible','off')
end

guidata(hObject,handles)


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
