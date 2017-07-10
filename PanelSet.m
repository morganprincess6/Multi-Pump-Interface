function S = PanelSet(varargin)
% Function Information
% Parent - addcomponents.m
% Children - Syrris_Asia_panel_setup.m
%          - Chemyx_Nexus3000_panel_setup.m
% Additions - S.panel_struct
%           - S.color
% Description - Sets up figure sizes (panel_struct),
%               color palette (color), and calls pumps
S = varargin{1};
figure_palette; %sets programmer-defined figure size standards
color_palette;  %sets programmer-defined color definitions
    function figure_palette
        clr = S.fig.Color;
        edit_clr = [1,1,1].*(clr~=[1,1,1])+[0.9,0.9,0.9].*(clr==[1,1,1]);
        panpos = [.28 .13 .716 .81]; %panel position
        % Normalized column positions
        coln = [0 0.25 0.5 0.75]+0.01;
        Max = 10000;         %Rate limit
        Min = 0;             %Rate limit
        upper = 0.1;         %Rate iteration constant
        btn_w = 0.23;        %Button Width
        btn_h = 0.13;        %Button Height
        lbl_h = 0.44*btn_h;  %Label Height (relative to button height)
        flb_h = 0.50*btn_h;  %Full Label Height (relative to button height)
        arr_w = 0.15*btn_w;  %Iteration arrow Width (relative to button width)       
        panel_w = 0.499;     %SemiPanel Width (relative to uipanel width)
        border_w = btn_w+0.02; %Border width (will make there be a border around the button)
        border_h = lbl_h*1.1; %Border height (height definition of border)
        S.panel_struct = struct('btn_w',btn_w,'btn_h',btn_h,...
                        'bor_w', border_w, 'bor_h', border_h,...
                        'lbl_h',lbl_h,'flb_h',flb_h,'upper',upper,...
                        'arr_w',arr_w,'panel_w',panel_w,...
                        'clr',clr,'edit_clr',edit_clr,...
                        'panpos',panpos,'coln',coln,...
                        'Max',Max,'Min',Min);
    end
    function color_palette
        tint = 0.5; %lit intensity
        darktint = 0.3; %because orange looks peachy when its lit
        lit = @(clr) clr*(1-tint)+[1,1,1]*tint; %lit function
        lite = @(clr) clr*(1-darktint)+[1,1,1]*darktint; %dark lit function
        red    = [.90 .05 .05];
        blue   = [.05 .05 .90];
        nexus_blue = [0.1451 0.3725 0.5765];
        q_blu = [0.584314 0.8 0.843137];
        green  = [.15 .80 .15];
        purple = [.70 .05 .85];
        orange = [1.0 .56 .00];
        asia_orange = [.8 .32 .16];
        gray   = [.50 .50 .50];
        grey = [0.94902 0.94902 0.94902];
        white  = [1 1 1];
        black  = [0 0 0];
        S.color = struct('red',red,'lit_red',lit(red),...
                         'blu',blue,'lit_blu',lit(blue),'nex_blu', nexus_blue,'q_blu', q_blu, ...
                         'grn',green,'lit_grn',lit(green),...
                         'ppl',purple,'lit_ppl',lit(purple),'lite_ppl', lite(purple),...
                         'org',orange,'lit_org',lite(orange),'asa_org', asia_orange,...
                         'gry',gray,'lit_gry',lit(gray),'drk_gry',lite(gray), 'grey', grey,...
                         'wht',white, 'blk',black);
    end

%% Panel Calls
K = varargin{2};
switch K.UserData
    case 1
        S = Main_panel_setup(S,K);
        %S = Syrris_Asia_panel_setup(S,K);
        S = Chemyx_Nexus3000_panel_setup(S,K);
        S = LittleThingsFactory_MrQ_panel_setup(S,K);
        S = Knauer_Azura_panel_setup(S,K);
        S = Model_3HI_Eldex_panel_setup(S,K);
    case 2
        S = Syrris_Asia_panel_setup(S,K);
        S.Asia.Visible = 'On';
    case 3
        S = LittleThingsFactory_MrQ_panel_setup(S,K);
        S.MrQ.Visible = 'On';        
    case 4
        S = Chemyx_Nexus3000_panel_setup(S,K);
        S.Nexus.Visible = 'On';
    case 5
        S = Knauer_Azura_panel_setup(S,K);
        S.Azura.Visible = 'On';
    case 6
        S = Model_3HI_Eldex_panel_setup(S,K);
        S.Eldex.Visible = 'On';
    otherwise
        S = Main_panel_setup(S,K);
        S = Syrris_Asia_panel_setup(S,K);
        S = Chemyx_Nexus3000_panel_setup(S,K);
        S = LittleThingsFactory_MrQ_panel_setup(S,K);
        S = Knauer_Azura_panel_setup(S,K);
        S = Model_3HI_Eldex_panel_setup(S,K);
        disp('Tag not found');
end

%% Panel Popout
S.popout = uicontrol(K,'style','pushbutton','units','normalized',...
                   'position',[.965 .947 .025 .0355],'Visible','on',...
                   'FontUnits','normalized','Callback',{@newfig,S,K});
S.popout.String = char(8599);
S.popout.TooltipString = 'Create new window';

end
