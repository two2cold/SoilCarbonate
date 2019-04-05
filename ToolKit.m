function varargout = ToolKit(varargin)
% TOOLKIT MATLAB code for ToolKit.fig
%      TOOLKIT, by itself, creates a new TOOLKIT or raises the existing
%      singleton*.
%
%      H = TOOLKIT returns the handle to a new TOOLKIT or the handle to
%      the existing singleton*.
%
%      TOOLKIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOOLKIT.M with the given input arguments.
%
%      TOOLKIT('Property','Value',...) creates a new TOOLKIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ToolKit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ToolKit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ToolKit

% Last Modified by GUIDE v2.5 09-Nov-2018 17:02:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ToolKit_OpeningFcn, ...
                   'gui_OutputFcn',  @ToolKit_OutputFcn, ...
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


% --- Executes just before ToolKit is made visible.
function ToolKit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ToolKit (see VARARGIN)

% Initialize static text
set(handles.text2,'String','The CQ model','fontsize',18,'FontName','Times New Roman');
set(handles.text3,'String','The DIFF model','fontsize',18,'FontName','Times New Roman');
set(handles.text4,'String','The DR model','fontsize',18,'FontName','Times New Roman');
set(handles.text5,'String','Surface flux:','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text6,'String','Surface flux:','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text7,'String','Surface flux:','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text8,'String','Please enter the full directory of your excel file:', ...
    'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text9,'String','Please enter sheet name (eg Sheet1)','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text10,'String','d13C depth [cm] (eg A1:A6)','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text11,'String','d13C range (eg B1:B6)','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text13,'String','d13C of vegetation','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text14,'String','Respiration rate [ugC/cm3/h]','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text15,'String','Respiration peak [-]','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text17,'String','Temperature [K]','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text12,'String','Moisture depth [cm] (eg C1:C6)','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.text16,'String','Moisture range (eg D1:D6)','fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');

% Initialize edit text
set(handles.edit1,'String','~/Documents/Works/Papers/4. How does changing soil moisture/Oerter&Amundson.xlsx', ...
    'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit2,'String','Soil CO2 profiles', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit3,'String','B3:B14', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit4,'String','D3:D14', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit5,'String','A35:A38', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit6,'String','-17.0', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit7,'String','2.00', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit8,'String','0.61', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit9,'String','F35:F38', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');
set(handles.edit10,'String','293', 'fontsize',18,'FontName','Times New Roman','HorizontalAlignment','left');

% Initialize push button
set(handles.pushbutton1,'String','Start','fontsize',18,'FontName','Times New Roman');

% Initialize pop-up menu
set(handles.popupmenu1,'String',{'CO2 gas','Soil carbonate'},'fontsize',18,'FontName','Times New Roman');

% Initialize figures 
set(handles.axes1,'ydir','reverse');
set(handles.axes1,'fontsize',12);
set(handles.axes1, 'FontName', 'Times New Roman');
xlabel(handles.axes1,'d13C','FontSize',15);
ylabel(handles.axes1,'Depth','FontSize',15);
set(handles.axes1,'XColor','k');
set(handles.axes1,'YColor','k');
set(handles.axes1,'box','off');

set(handles.axes2,'ydir','reverse');
set(handles.axes2,'fontsize',12);
set(handles.axes2, 'FontName', 'Times New Roman');
xlabel(handles.axes2,'d13C','FontSize',15);
ylabel(handles.axes2,'Depth','FontSize',15);
set(handles.axes2,'XColor','k');
set(handles.axes2,'YColor','k');
set(handles.axes2,'box','off');

set(handles.axes3,'ydir','reverse');
set(handles.axes3,'fontsize',12);
set(handles.axes3, 'FontName', 'Times New Roman');
xlabel(handles.axes3,'d13C','FontSize',15);
ylabel(handles.axes3,'Depth','FontSize',15);
set(handles.axes3,'XColor','k');
set(handles.axes3,'YColor','k');
set(handles.axes3,'box','off');

% Choose default command line output for ToolKit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ToolKit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ToolKit_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -------------------------------------------------------------------------
% Read in depth and carbonate d13C data from excel sheet
% -------------------------------------------------------------------------
fileDir = get(handles.edit1,'String');
sheet = get(handles.edit2,'String');
d13Crange = get(handles.edit4,'String');
depthrange = get(handles.edit3,'String');
moistureDepthRange = get(handles.edit5,'String');
moistureValueRange = get(handles.edit9,'String');
d13Ccarb = xlsread(char(fileDir),char(sheet),char(d13Crange));
depth = xlsread(char(fileDir),char(sheet),char(depthrange));
moistureDepth = xlsread(char(fileDir),char(sheet),char(moistureDepthRange));
moistureValue = xlsread(char(fileDir),char(sheet),char(moistureValueRange));
size_d13Ccarb = size(d13Ccarb);
size_depth = size(depth);
if size_d13Ccarb(1) ~= 1 && size_d13Ccarb(2) ~= 1
    error('The d13C data must be ONE row');
elseif size_d13Ccarb(2) == 1
    d13Ccarb = d13Ccarb';
end
if size_depth(1) ~= 1 && size_depth(2) ~= 1
    error('The depth of d13C data must be ONE row');
elseif size_depth(2) == 1
    depth = depth';
end
if length(d13Ccarb) ~= length(depth)
    error('The scale of d13C profile data must be consistant with the scale of depth profile data');
end
% -------------------------------------------------------------------------
% Check if input d13C values are carbonates' or CO2 gas'
% If they are carbonate d13C, use equilibrium fractionation between CO2 and
% calcite to convert it to CO2 gas d13C
% -------------------------------------------------------------------------
temperature = str2double(get(handles.edit10,'String'));
peakPosition = str2double(get(handles.edit8,'String'));
peakValue = str2double(get(handles.edit7,'String'));
    
if get(handles.popupmenu1,'Value') == 2
    d13Ccarb = (d13Ccarb + 1000)/((11.98 - 0.12*(temperature - 273))/1000 + 1) - 1000;
end
% -------------------------------------------------------------------------
% Other parameters
% -------------------------------------------------------------------------
porosity = 0.4;
concAir = 400;
d13CAir = -6.5;
d13CVegetation = str2double(get(handles.edit6,'String'));
peakPosition = str2double(get(handles.edit8,'String'));
peakValue = str2double(get(handles.edit7,'String'));
% -------------------------------------------------------------------------
% Calculation using function diffusion_with_two_isotopes_func.m
% -------------------------------------------------------------------------
[CO2CalculatedCQ,CO2IsotopeCalculatedCQ,surfaceFluxCQ] = ...
    diffusion_with_two_isotopes_func(moistureDepth,moistureValue/porosity,concAir,d13CAir,d13CVegetation,peakPosition,peakValue,0,2);
[CO2CalculatedDR,CO2IsotopeCalculatedDR,surfaceFluxDR] = ...
    diffusion_with_two_isotopes_func(moistureDepth,moistureValue/porosity,concAir,d13CAir,d13CVegetation,peakPosition,peakValue,0,1);
[CO2CalculatedDO,CO2IsotopeCalculatedDO,surfaceFluxDO] = ...
    diffusion_with_two_isotopes_func(moistureDepth,moistureValue/porosity,concAir,d13CAir,d13CVegetation,peakPosition,peakValue,0,3);
% -------------------------------------------------------------------------
% Update surface flux text
% -------------------------------------------------------------------------
surfaceFluxCQ = surfaceFluxCQ;
surfaceFluxDO = surfaceFluxDO;
surfaceFluxDR = surfaceFluxDR;
inteCQ = sprintf('Surface flux: %.2f gC/m2/yr',surfaceFluxCQ);
inteDO = sprintf('Surface flux: %.2f gC/m2/yr',surfaceFluxDO);
inteDR = sprintf('Surface flux: %.2f gC/m2/yr',surfaceFluxDR);
set(handles.text5,'String',inteCQ,'fontsize',18,'FontName','Times New Roman');
set(handles.text6,'String',inteDO,'fontsize',18,'FontName','Times New Roman');
set(handles.text7,'String',inteDR,'fontsize',18,'FontName','Times New Roman');
% -------------------------------------------------------------------------
% Plotting
% -------------------------------------------------------------------------
plot(handles.axes1,d13Ccarb,depth,'*','LineWidth',2); hold(handles.axes1);
plot(handles.axes1,CO2IsotopeCalculatedCQ,1:max(moistureDepth),'--','LineWidth',2);
set(handles.axes1,'ydir','reverse');
set(handles.axes1,'fontsize',12);
set(handles.axes1, 'FontName', 'Times New Roman');
xlabel(handles.axes1,'Respiration rate [gC/m3/hour] (C&Q model)','FontSize',15);
ylabel(handles.axes1,'Depth','FontSize',15);
set(handles.axes1,'XColor','k');
set(handles.axes1,'YColor','k');
set(handles.axes1,'box','off');
hold(handles.axes1,'off');

plot(handles.axes2,d13Ccarb,depth,'*','LineWidth',2); hold(handles.axes2);
plot(handles.axes2,CO2IsotopeCalculatedDO,1:max(moistureDepth),'--','LineWidth',2);
set(handles.axes2,'ydir','reverse');
set(handles.axes2,'fontsize',12);
set(handles.axes2, 'FontName', 'Times New Roman');
xlabel(handles.axes2,'Respiration rate [gC/m3/hour] (C&Q model)','FontSize',15);
ylabel(handles.axes2,'Depth','FontSize',15);
set(handles.axes2,'XColor','k');
set(handles.axes2,'YColor','k');
set(handles.axes2,'box','off');
hold(handles.axes2,'off');

plot(handles.axes3,d13Ccarb,depth,'*','LineWidth',2); hold(handles.axes3);
plot(handles.axes3,CO2IsotopeCalculatedDR,1:max(moistureDepth),'--','LineWidth',2);
set(handles.axes3,'ydir','reverse');
set(handles.axes3,'fontsize',12);
set(handles.axes3, 'FontName', 'Times New Roman');
xlabel(handles.axes3,'Respiration rate [gC/m3/hour] (C&Q model)','FontSize',15);
ylabel(handles.axes3,'Depth','FontSize',15);
set(handles.axes3,'XColor','k');
set(handles.axes3,'YColor','k');
set(handles.axes3,'box','off');
hold(handles.axes3,'off');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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

