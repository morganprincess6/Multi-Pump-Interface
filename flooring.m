# Multi-Pump-Interface
function [vert] = flooring(val,name)
% Function Information
% Parent - Various
% Description - Sets the vertical positions of buttons,
%               textboxes, labels, etc. based on 'floors'

val = val-1;
switch name
    case 'l'
    % label flooring        
        if(mod(val,1)==0.5)
            vert = (val-0.01)*0.14;
        elseif(mod(val,1)==0)
            vert = (val+0.02)*0.14;
        end    
    case 'b'
    % button flooring
        vert = val*0.14;
    case 'fl'
    % full label flooring
        vert = val*0.14+0.001;
    case 'tp'
    % full label topping
        vert = val*0.14-0.006;
end
vert = vert - 0.13;  %set everything lower
end
