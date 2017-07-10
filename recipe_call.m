function [] = recipe_call(varargin)
% Function Information
% Parent - Pumps1.m
% Children - panel_switch.m (local function)
% Description - Callback for the recipe selector (popup)
% IMPORTANT NOTE - If you add another recipe, it must be added
%                  here and in newfig.m as well as an entire function in PanelSet
S = varargin{3};  %main figure handle
P = get(S.recipe,{'String','Val'});  
% Explanation of P
% P{1} is array of options, P{2} is cell number of picked option
% P{1}{1} would be option 1, P{1}{2} would be option 2, and so on
% In this case, P{1}{P{2}} is the pump name and company
switch P{1}{P{2}}
    case 'recipe1'
        str = 'recipe_co_1';
    case 'recipe2'
        str = 'recipe_co_2';  
    case 'recipe3'
        str = 'recipe_co_3';   
    case 'recipe4'
        str = 'recipe_co_4';    
    case '(select recipes here)'
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
                S.recipe.Value = 1;
                figure(alt_fig);
                flag = 1;
            end
        end
    end
    if(~flag)
        switch P{1}{P{2}}
            case 'Reactor 1 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);
            case 'Reactor 2 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);    
            case 'Reactor 3 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);  
            case 'Reactor 4 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);    
            case '(select recipes here)'
                S.im.String = ('clse.png');
                panel_switch(S.fig,str);    
            otherwise
               S.im.String = ('clse.png');    
                panel_switch(S.fig,str);    
        end
        imshow(S.im.String); %outputs corresponding logo
        if strcmp(P{1}{P{2}},'(select recipes here)') %Quit button label
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
            case 'Reactor 1 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);
            case 'Reactor 2 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);    
            case 'Reactor 3 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);  
            case 'Reactor 4 name'
                S.im.String = ('Path/that/gets/to/ReactorLogo.png');
                panel_switch(S.fig,str);    
            case '(select recipes here)'
                S.im.String = ('clse.png');
                panel_switch(S.fig,str);    
            otherwise
               S.im.String = ('clse.png');    
                panel_switch(S.fig,str);    
        end
        imshow(S.im.String); %outputs corresponding logo
        if strcmp(P{1}{P{2}},'(select recipes here)') %Quit button label
            S.pb_quitone.Visible = 'off';
            S.lb_quitone.Visible = 'on';
        else
            S.pb_quitone.Visible = 'on';
            S.lb_quitone.Visible = 'off';
            S.pb_quitone.String = strcat('QUIT',{' '},P{1}{P{2}});
        end
end

S.pump.Value = 1;
S.device.Value = 1;

end
