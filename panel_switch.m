function [] = panel_switch(fig_handle,str)
% Function Information
% Parent - newfig.m
%        - pump_call.m
% Description - Turns on selected panel and turns off all others
panel_list = {'Asia'   ...
              'MrQ'    ...
              'Nexus'  ...
              'Azura'  ...
              'Eldex'  ...
              'Main'};
for j = 1:length(panel_list)
    ext = strcat('_',num2str(j));
    g = findobj('Parent',fig_handle,'Tag',strcat(str,ext));
    for i = 1:length(panel_list)
        h = findobj('Parent',fig_handle,'Tag',strcat(panel_list{i},ext));
        if ~isempty(h)     %panel exists
            if (h == g);  h.Visible = 'on';
            else          h.Visible = 'off';
            end
        end
    end
end
end
