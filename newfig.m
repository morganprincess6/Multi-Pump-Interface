function [F] = newfig(varargin)
% Function Information
% Parent - Various
% Description - Pop panels out as new figures and pops panels back in

U = varargin{1};
A = varargin{2};
S = varargin{3};
K = varargin{4};
if ~strcmp(U.String,char(8599)) %if this is already a subfigure
    str = K.Tag(1:length(K.Tag)-4); %4 = length of '_fig' extension
    switch str
    case 'Asia'
        S.im.String = ('AsiaLabviewAPI/Documentation/AsiaPumpInterface_Files/SyrrisLogo.png');
        panel_switch(S,'Asia');  superstr = 'Syrris Asia Pump';
        S.pump.Value = 2;
        S.Asia.Parent = S.fig;  close(S.Asia_fig);
    case 'MrQ'
        S.im.String = ('MrQ/LTF_Logo.png');
        panel_switch(S,'MrQ');   superstr = 'Little Things Factory Mr Q.';
        S.pump.Value = 3;
        S.MrQ.Parent = S.fig;   close(S.MrQ_fig);        
    case 'Nexus'
        S.im.String = ('Chemyx_Nexus3000/ChemyxLogo.png');    
        panel_switch(S,'Nexus'); superstr = 'Chemyx Nexus 3000';
        S.pump.Value = 4;
        S.Nexus.Parent = S.fig; close(S.Nexus_fig);        
    case 'Azura'
        S.im.String = ('Knauer/KnauerLogo.png');  
        panel_switch(S,'Azura'); superstr = 'Knauer Azura P4.1S';
        S.pump.Value = 5;
        S.Azura.Parent = S.fig; close(S.Azura_fig);
    case 'Eldex'
        S.im.String = ('Eldex/EldexLogo.png');  
        panel_switch(S,'Eldex'); superstr = 'Model 3HI Eldex';
        S.pump.Value = 5;
        S.Eldex.Parent = S.fig; close(S.Eldex_fig);        
    otherwise
        disp('Subfigure tag not found');
        close all;
    end
    imshow(S.im.String);
    S.pb_quitone.Visible = 'on';
    S.lb_quitone.Visible = 'off';
    S.pb_quitone.String = strcat('QUIT',{' '},superstr);
    S.reactor.Value = 1;
    S.device.Value = 1;
    return;
end
P = get(S.pump,{'String','Val'});  
% Explanation of P
% P{1} is array of options, P{2} is cell number of picked option
% P{1}{1} would be option 1, P{1}{2} would be option 2, and so on
% In this case, P{1}{P{2}} is the pump name and company
index = find(strcmp(S.pump.String,P{1}{P{2}}));

%% Change Mainfig to Main Panel
panel_switch(S.fig,'Main');
S.pump.Value = 1;
S.im.String = ('clse.png');
imshow(S.im.String);
S.pb_quitone.Visible = 'off';
S.lb_quitone.Visible = 'on';

%% Create New fig
scrsz = get(0,'ScreenSize');
screensize_factor = 0.5;
clr = [1,1,1];  % color is dynamic
shift_horz = index*(40);    %user-defined constants
shift_vert = index*(-20);   %user-defined constants
figsize = [(scrsz(3)*(1-screensize_factor))./2 (scrsz(4)*(1-screensize_factor))./2 ...
            scrsz(3)*screensize_factor scrsz(4)*screensize_factor];
figsize(1) = shift_horz + figsize(1);
figsize(2) = shift_vert + figsize(2);

switch index
    case 2
      alt_fig = findobj('Number',2); flag = 0;
      if ~isempty(alt_fig) %Check if S.Asia_fig already exists. If so, display that one instead.
          for i = 2:30  %30 is user-defined maximum number of subfigures, can change here
              alt_fig = findobj('Number',i);
              if ~isempty(alt_fig)
                  alt_str = alt_fig.Tag(1:length(alt_fig.Tag)-4); %4 = length of '_fig' extension
                  if strcmp(alt_str,'Asia')
                      figure(alt_fig);
                      return;
                  end
              end
          end
      end
      S.Asia_fig = figure('units','pixels','Position',figsize,...
                 'menubar','none','name','Syrris Asia Pump ~ Multi-Pump Driver Interface Subfigure',...
                 'numbertitle','off','resize','on','UserData',2,...
                 'Visible',S.fig.Visible,'color',clr,'Tag','Asia_fig');
      K = S.Asia_fig;
      S.Asia_ax = axes('Parent',K,'units', 'normalized','position',[.01 .65 .25 .34],'Visible','off','ButtonDownFcn',{@logoFcn,S});
      S.Asia_im = uicontrol('Parent',K,'String','AsiaLabviewAPI/Documentation/AsiaPumpInterface_Files/SyrrisLogo.png','Visible','off');
      imshow(S.Asia_im.String);
      S.Asia_lb_quitone = uicontrol(K,'style','text','Visible','Off',...
                 'ForegroundColor',S.lb_quitone.ForegroundColor,'BackgroundColor',S.lb_quitone.BackgroundColor);
      S.Asia_pb_quitone = uicontrol(K,'style','push','units',S.lb_quitone.Units,'position',S.lb_quitone.Position,...
                 'FontUnits',S.lb_quitone.FontUnits,'ForegroundColor',S.lb_quitone.ForegroundColor,...
                 'FontWeight',S.lb_quitone.FontWeight,'string','QUIT Syrris Asia Pump',...
                 'BackgroundColor',S.lb_quitone.BackgroundColor,'callback',{@pb_call,S},'Visible','On');
      S.Asia.Parent = K;
      S.Asia.Visible = 'On';
      K = S.Asia_fig;
    case 3  
      alt_fig = findobj('Number',2); flag = 0;
      if ~isempty(alt_fig) %Check if S.MrQ_fig already exists. If so, display that one instead.
          for i = 2:30  %30 is user-defined maximum number of subfigures, can change here
              alt_fig = findobj('Number',i);
              if ~isempty(alt_fig)
                  alt_str = alt_fig.Tag(1:length(alt_fig.Tag)-4); %4 = length of '_fig' extension
                  if strcmp(alt_str,'MrQ')
                      figure(alt_fig);
                      return;
                  end
              end
          end
      end
      S.MrQ_fig = figure('units','pixels','Position',figsize,...
                 'menubar','none','name','Little Things Factory MrQ Pump ~ Multi-Pump Driver Interface Subfigure',...
                 'numbertitle','off','resize','on','UserData',2,...
                 'Visible',S.fig.Visible,'color',clr,'Tag','MrQ_fig');
      K = S.MrQ_fig;
      S.MrQ_ax = axes('Parent',K,'units', 'normalized','position',[.01 .65 .25 .34],'Visible','off','ButtonDownFcn',{@logoFcn,S});
      S.MrQ_im = uicontrol('Parent',K,'String','MrQ/LTF_Logo.png','Visible','off');
      imshow(S.MrQ_im.String);
      S.MrQ_lb_quitone = uicontrol(K,'style','text','Visible','Off',...
                 'ForegroundColor',S.lb_quitone.ForegroundColor,'BackgroundColor',S.lb_quitone.BackgroundColor);
      S.MrQ_pb_quitone = uicontrol(K,'style','push','units',S.lb_quitone.Units,'position',S.lb_quitone.Position,...
                 'FontUnits',S.lb_quitone.FontUnits,'ForegroundColor',S.lb_quitone.ForegroundColor,...
                 'FontWeight',S.lb_quitone.FontWeight,'string','QUIT Little Things Factory MrQ',...
                 'BackgroundColor',S.lb_quitone.BackgroundColor,'callback',{@pb_call,S},'Visible','On');
      S.MrQ.Parent = K;
      S.MrQ.Visible = 'On';
      K = S.MrQ_fig;
    case 4
      alt_fig = findobj('Number',2); flag = 0;
      if ~isempty(alt_fig) %Check if S.Nexus_fig already exists. If so, display that one instead.
          for i = 2:30  %30 is user-defined maximum number of subfigures, can change here
              alt_fig = findobj('Number',i);
              if ~isempty(alt_fig)
                  alt_str = alt_fig.Tag(1:length(alt_fig.Tag)-4); %4 = length of '_fig' extension
                  if strcmp(alt_str,'Nexus')
                      figure(alt_fig);
                      return;
                  end
              end
          end
      end
      S.Nexus_fig = figure('units','pixels','Position',figsize,...
                 'menubar','none','name','Chemyx Nexus 3000 Pump ~ Multi-Pump Driver Interface Subfigure',...
                 'numbertitle','off','resize','on','UserData',2,...
                 'Visible',S.fig.Visible,'color',clr,'Tag','Nexus_fig');
      K = S.Nexus_fig;
      S.Nexus_ax = axes('Parent',K,'units', 'normalized','position',[.01 .65 .25 .34],'Visible','off','ButtonDownFcn',{@logoFcn,S});
      S.Nexus_im = uicontrol('Parent',K,'String','Chemyx_Nexus3000/ChemyxLogo.png','Visible','off');
      imshow(S.Nexus_im.String);
      S.Nexus_lb_quitone = uicontrol(K,'style','text','Visible','Off',...
                 'ForegroundColor',S.lb_quitone.ForegroundColor,'BackgroundColor',S.lb_quitone.BackgroundColor);
      S.Nexus_pb_quitone = uicontrol(K,'style','push','units',S.lb_quitone.Units,'position',S.lb_quitone.Position,...
                 'FontUnits',S.lb_quitone.FontUnits,'ForegroundColor',S.lb_quitone.ForegroundColor,...
                 'FontWeight',S.lb_quitone.FontWeight,'string','QUIT Chemyx Nexus 3000',...
                 'BackgroundColor',S.lb_quitone.BackgroundColor,'callback',{@pb_call,S},'Visible','On');
      S.Nexus.Parent = K;
      S.Nexus.Visible = 'On';
      K = S.Nexus_fig;        
    case 5
      alt_fig = findobj('Number',2); flag = 0;
      if ~isempty(alt_fig) %Check if S.Azura_fig already exists. If so, display that one instead.
          for i = 2:30  %30 is user-defined maximum number of subfigures, can change here
              alt_fig = findobj('Number',i);
              if ~isempty(alt_fig)
                  alt_str = alt_fig.Tag(1:length(alt_fig.Tag)-4); %4 = length of '_fig' extension
                  if strcmp(alt_str,'Azura')
                      figure(alt_fig);
                      return;
                  end
              end
          end
      end
      S.Azura_fig = figure('units','pixels','Position',figsize,...
                 'menubar','none','name','Knauer Azura P4.1S Pump ~ Multi-Pump Driver Interface Subfigure',...
                 'numbertitle','off','resize','on','UserData',2,...
                 'Visible',S.fig.Visible,'color',clr,'Tag','Azura_fig');
      K = S.Azura_fig;
      S.Azura_ax = axes('Parent',K,'units', 'normalized','position',[.01 .65 .25 .34],'Visible','off','ButtonDownFcn',{@logoFcn,S});
      S.Azura_im = uicontrol('Parent',K,'String','Knauer/KnauerLogo.png','Visible','off');
      imshow(S.Azura_im.String);
      S.Azura_lb_quitone = uicontrol(K,'style','text','Visible','Off',...
                 'ForegroundColor',S.lb_quitone.ForegroundColor,'BackgroundColor',S.lb_quitone.BackgroundColor);
      S.Azura_pb_quitone = uicontrol(K,'style','push','units',S.lb_quitone.Units,'position',S.lb_quitone.Position,...
                 'FontUnits',S.lb_quitone.FontUnits,'ForegroundColor',S.lb_quitone.ForegroundColor,...
                 'FontWeight',S.lb_quitone.FontWeight,'string','QUIT Knauer Azura P4.1S',...
                 'BackgroundColor',S.lb_quitone.BackgroundColor,'callback',{@pb_call,S},'Visible','On');
      S.Azura.Parent = K;
      S.Azura.Visible = 'On';
      K = S.Azura_fig;    
    case 6
      alt_fig = findobj('Number',2); flag = 0;
      if ~isempty(alt_fig) %Check if S.Eldex_fig already exists. If so, display that one instead.
          for i = 2:30  %30 is user-defined maximum number of subfigures, can change here
              alt_fig = findobj('Number',i);
              if ~isempty(alt_fig)
                  alt_str = alt_fig.Tag(1:length(alt_fig.Tag)-4); %4 = length of '_fig' extension
                  if strcmp(alt_str,'Azura')
                      figure(alt_fig);
                      return;
                  end
              end
          end
      end
      S.Azura_fig = figure('units','pixels','Position',figsize,...
                 'menubar','none','name','Model 3HI Eldex ~ Multi-Pump Driver Interface Subfigure',...
                 'numbertitle','off','resize','on','UserData',2,...
                 'Visible',S.fig.Visible,'color',clr,'Tag','Azura_fig');
      K = S.Azura_fig;
      S.Azura_ax = axes('Parent',K,'units', 'normalized','position',[.01 .65 .25 .34],'Visible','off','ButtonDownFcn',{@logoFcn,S});
      S.Azura_im = uicontrol('Parent',K,'String','Eldex/EldexLogo.png','Visible','off');
      imshow(S.Azura_im.String);
      S.Azura_lb_quitone = uicontrol(K,'style','text','Visible','Off',...
                 'ForegroundColor',S.lb_quitone.ForegroundColor,'BackgroundColor',S.lb_quitone.BackgroundColor);
      S.Azura_pb_quitone = uicontrol(K,'style','push','units',S.lb_quitone.Units,'position',S.lb_quitone.Position,...
                 'FontUnits',S.lb_quitone.FontUnits,'ForegroundColor',S.lb_quitone.ForegroundColor,...
                 'FontWeight',S.lb_quitone.FontWeight,'string','QUIT Model 3HI Eldex',...
                 'BackgroundColor',S.lb_quitone.BackgroundColor,'callback',{@pb_call,S},'Visible','On');
      S.Azura.Parent = K;
      S.Azura.Visible = 'On';
      K = S.Azura_fig;        
    otherwise %such as case 1, the main screen
        msgbox('Popout not active for this panel','Inactive Popout','warn','modal');
        return;
end


%% Panel Popout
S.popout_k = uicontrol(K,'style','pushbutton','units','normalized',...
                         'position',[.965 .947 .025 .0355],...
                         'FontUnits','normalized','Callback',{@newfig,S,K});
S.popout_k.String = char(8601);
S.popout_k.TooltipString = 'Pin to main window';

%% Main fig callback
% Pump Popup Menu          
S.pump_k = uicontrol(K,'style','pushbutton','units','normalized',...
                       'position',[.762 .95 .185 .0355],'Tag','Main_back',...
                       'string','Back to Main Figure','FontUnits','normalized','Callback',{@main_back,S});
end

function [] = main_back(varargin)
S = varargin{3};
figure(S.fig);
end
