# Multi-Pump-Interface
function bool = fcn_call(bool,fcn_name)
% Function Information
% Parent - Various
% Description - Gives time-stamped error message in Command Window for any bool-return-checked function

if(~bool)
    error_time = datevec(now);    
    clip = @(x) x./10.^floor(log10(x));
    year = error_time(1);  month = error_time(2);
    day = error_time(3);   hour = mod(error_time(4),12);   min = error_time(5);
    if    (error_time(6)>=1e+1);  sec = clip(error_time(6))*1e+1;     % I'm sure there's a more
    elseif(error_time(6)>=1e+0);  sec = clip(error_time(6))*1e+0;     % elegant, dynamic solution
    elseif(error_time(6)>=1e-1);  sec = clip(error_time(6))*1e-1;     % to this approach (*cough
    elseif(error_time(6)>=1e-2);  sec = clip(error_time(6))*1e-2;     % FOR LOOP *cough) but this
    elseif(error_time(6)>=1e-3);  sec = clip(error_time(6))*1e-3;     % isn't really a big problem,
    else;                         sec = clip(error_time(6))*1e-4;     % so I'm going to leave it
    end                                                               % like this and everything's
    sec(isnan(sec))=0;                                                % going to be okay.
    meridiem = 'A'*(error_time(4)<=12)+'P'*(error_time(4)>12);
    if(sec>=10); error_statement = 'Function: %s\n   Error occured at %d/%d/%d at %d:%02d:%05.3f %cM\n';
    else         error_statement = 'Function: %s\n   Error occured at %d/%d/%d at %d:%02d:0%4.3f %cM\n';
    end
    fprintf(error_statement,fcn_name,month,day,year,hour,min,sec,meridiem);
end

end
