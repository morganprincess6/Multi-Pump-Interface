# Multi-Pump-Interface
function [] = device_call(varargin)
% Function Information
% Parent - Pumps1.m
% Children - panel_switch.m (local function)
% Description - Callback for the device selector (popup)
% IMPORTANT NOTE - If you add another device, it must be added
%                  here and in newfig.m as well as an entire function in PanelSet
S = varargin{3};  %main figure handle
P = get(S.device,{'String','Val'});  
% Explanation of P
% P{1} is array of options, P{2} is cell number of picked option
% P{1}{1} would be option 1, P{1}{2} would be option 2, and so on
% In this case, P{1}{P{2}} is the pump name and company
switch P{1}{P{2}}
    case 'Huber Unistat 360'
        str = 'Unistat';
    case 'Ika Plate'
        str = 'IkaPlate';    
    case '(select other devices here)'
        str = 'Main';    
    otherwise
        str = 'Main';     
end
alt_fig = findobj('Number',2); flag = 0;
if ~isempty(alt_fig) %if a subfigure exists
    for i = 2:30  %30 is user-defined maximum number of subfigures, can change here
        alt_fig = findobj('Number',i);
        if ~isempty(alt_fig) %if a subfigure exists
        alt_str = alt_fig.Tag(1:length(alt_fig.Tag)-4); %4 = length of '_fig' extension
            if strcmp(alt_str,str)
                S.device.Value = 1;
                figure(alt_fig);
                flag = 1;
            end
        end
    end
    if(~flag)
        switch P{1}{P{2}}
            case 'Huber Unistat 360'
                S.im.String = ('Path/that/gets/to/DeviceLogo.png');
                panel_switch(S.fig,str);
            case 'Ika Plate'
                S.im.String = ('Path/that/gets/to/DeviceLogo.png');
                panel_switch(S.fig,str);      
            case '(select device here)'
                S.im.String = ('clse.png');
                panel_switch(S.fig,str);    
            otherwise
               S.im.String = ('clse.png');    
                panel_switch(S.fig,str);    
        end
        imshow(S.im.String); %outputs corresponding logo
        if strcmp(P{1}{P{2}},'(select other devices here)') %Quit button label
            S.pb_quitone.Visible = 'off';
            S.lb_quitone.Visible = 'on';
        else
            S.pb_quitone.Visible = 'on';
            S.lb_quitone.Visible = 'off';
            S.pb_quitone.String = strcat('QUIT',{' '},P{1}{P{2}});
        end
    end
else
        switch P{1}{P{2}}
            case 'Huber Unistat 360'
                S.im.String = ('Path/that/gets/to/DeviceLogo.png');
                panel_switch(S.fig,str);
            case 'Ika Plate'
                S.im.String = ('Path/that/gets/to/DeviceLogo.png');
                panel_switch(S.fig,str);      
            case '(select other devices here)'
                S.im.String = ('clse.png');
                panel_switch(S.fig,str);    
            otherwise
               S.im.String = ('clse.png');    
                panel_switch(S.fig,str);    
        end
        imshow(S.im.String); %outputs corresponding logo
        if strcmp(P{1}{P{2}},'(select other devices here)') %Quit button label
            S.pb_quitone.Visible = 'off';
            S.lb_quitone.Visible = 'on';
        else
            S.pb_quitone.Visible = 'on';
            S.lb_quitone.Visible = 'off';
            S.pb_quitone.String = strcat('QUIT',{' '},P{1}{P{2}});
        end
end

S.pump.Value = 1;
S.recipe.Value = 1;

end
