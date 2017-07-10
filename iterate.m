# Multi-Pump-Interface
function [F] = iterate(S,flag,sign)
% Function Information
% Parent - pb_call.m
% Description - Iterates values based on an "upper" value
%               that can be set to negative to de-iterate
max = S.panel_struct.Max;
min = S.panel_struct.Min;
upper = S.panel_struct.upper;
upper = upper*sign;             %iterates/deiterates
str_read = read(S,flag);                    %finds correct string to pull from
str_num = compute(str_read,max,min,upper);  %computes iteration
write(S,str_num,flag);                      %finds correct string to update
F = S;  %updates main handle
end
    function [str] = read(S,flag)
        switch flag(1)
            case 0
                switch flag(2)
                    case 0  % Left fill
                        str = S.Lstr_fill.String;
                    case 1  % Left empty
                        str = S.Lstr_empty.String;
                    case 2  % Left pump
                        str = S.Lstr_pump.String;
                end
            case 1
                switch flag(2)
                    case 0  % Right fill
                        str = S.Rstr_fill.String;
                    case 1  % Right empty
                        str = S.Rstr_empty.String;
                    case 2  % Right pump
                        str = S.Rstr_pump.String;
                end
        end
    end
    function [str] = compute(str,max,min,upper)
        num = str2num(str); %convert from reading to computing
        if (isempty(num)) 
            num = 0;   %changes num to a zero if input is not valid
        elseif(((upper>0)&&((num+upper)<=max))||((upper<0)&&((num+upper)>=min)))
            num = num + upper;  %proper (exact) iteration
        elseif((num<max)&&(upper>0)&&(num+upper>max))
            num = max; %allows raising by less than upper to reach exact max
        elseif((num>min)&&(upper<0)&&(num+upper<min))
            num = min; %allows lowering by less than upper to reach exact min
        end
        num = (num>max)*max+(num<=max)*num; %cannot exceed max
        num = (num<min)*min+(num>=min)*num; %cannot exceed min
        str = num2str(num); %convert from computing to writing
    end
    function write(S,str,flag)
        switch flag(1)  %finds correct string to update
            case 0
                switch flag(2)
                    case 0  % Left fill
                        S.Lstr_fill.String  = str;
                    case 1  % Left empty
                        S.Lstr_empty.String = str;
                    case 2  % Left pump
                        S.Lstr_pump.String  = str;
                end
            case 1
                switch flag(2)
                    case 0  % Right fill
                        S.Rstr_fill.String  = str;
                    case 1  % Right empty
                        S.Rstr_empty.String = str;
                    case 2  % Right pump
                        S.Rstr_pump.String  = str;
                end
        end
    end

