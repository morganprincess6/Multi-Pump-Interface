function [tf] = time_call(freq,str,mode)
% Function Information
% Parent - Various
% Description - Checks system clock at a given frequency

timevec = datevec(now); %grabs current time

% Programmer defined constants                                     high         low
rangeprecision = 100; % 0<x  , higher number = higher precision  |||||||  vs  |  |  | 
rangeaccuracy = 0.1;  % 0<x<1, higher number == more true statements (0 being ~3% and 1 being 100%)

rangefactor = rangeaccuracy/rangeprecision;
if(freq == 1)  %changes units for higher accuracy
    switch str
        case 'sec';  freq = 60; str = 'min';
        case 'min';  freq = 60; str = 'hour';
        case 'hour'; freq = 24; str = 'day';
        case 'day'
            switch timevec(2)
                case {1 3 5 7 8 10  12}; freq = 31; %31 days in a month
                case {   4 6   9  11};   freq = 30; %30 days in a month
                case   2
                       if(((mod(timevec(1),4)==0)&&...
                         (mod(timevec(1),100)~=0))||...
                         (mod(timevec(1),400)==0))
                            freq = 29; %leap year, 29 days in a month
                       else
                            freq = 28; %non leap year, 28 days in a month
                       end
             end
            str = 'month';
        case 'month'; freq = 12; str = 'year';            
        case 'year'      % no shortenings here
end
switch str      %time type desired
    case 'sec'
       timecell = mod(timevec(6),1)*1000;
       recurrence = 1000; %1000 milliseconds in a second
    case 'min'  
       timecell = timevec(6);
       recurrence = 60; %60 seconds in a minute
    case 'hour'
       timecell = timevec(5);
       recurrence = 60; %60 minutes in an hour
    case 'day'
       timecell = timevec(4);
       recurrence = 24; %24 hours in a day
    case 'month'
       timecell = timevec(3);
       switch timecell
           case {1 3 5 7 8 10 12}
               recurrence = 31; %31 days in a month
           case {4 5 9 11}
               recurrence = 30; %30 days in a month
           case 2
               if(((mod(timevec(1),4)==0)&&...
                   (mod(timevec(1),100)~=0))||...
                   (mod(timevec(1),400)==0))
                    recurrence = 29; %leap year, 29 days in a month
               else
                    recurrence = 28; %non leap year, 28 days in a month
               end
       end
    case 'year'
       timecell = timevec(2);
       recurrence = 12;   %12 months in a year
end
timebreakjump = recurrence/freq;
timebreakarray = zeros(1,freq);
sum = 0;  i = 0;
while(sum<recurrence)
    i = i+1;
    timebreakarray(i) = sum;
    sum = sum + timebreakjump;
end
if ~strcmp(mode,'exact') % mode is 'range' (default)
    largearray = timebreakarray;
    freq = freq*(rangeprecision/2+1);
    timebreakarray = zeros(1,freq);
    for i = 1:freq
        for j = 1:(rangeprecision/2)
            timebreakarray(freq+j-1) = largearray(freq)-(rangeprecision/2+1-j)*rangefactor*timebreakjump;
        end
        timebreakarray(freq+rangeprecision/2) = largearray(rangeprecision/2);
        for j = (rangeprecision/2+1):rangeprecision
            timebreakarray(freq+j) = largearray(freq)+(j-rangeprecision/2)*rangefactor*timebreakjump;
        end        
    end
end

% Main For-loop, checks if time matches cases
tf = 0; %boolean output
for i = 1:freq
    if(timecell == timebreakarray(i))
        tf = 1; %match
        break
    end
end
end
