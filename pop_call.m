function S = pop_call(varargin)
% Function Information
% Parent - Various
% Description - Changes various inputs due to popup functions;
%               multipurpose popup function
S = varargin{3};  %main figure handle
U = varargin{1};  %current uicontrol
P = get(U,{'String','Val'});
str = P{1}{P{2}};
switch U.Tag
    case 'Nexus_Units'
        S.ml_min_label.String = str;
        S.ml_label.String = str(1:2);
    case 'Nexus_Step'
        stepper = str2double(str(5:length(str))); %gets rid of 'Step_', grabs value;
        S.volume_enter.String    = num2str(S.n(1,stepper).Volume);
        S.ml_label.String        = S.n(1,stepper).Volume_U;
        S.rate_enter.String      = num2str(S.n(1,stepper).Rate);
        S.ml_min_label.String    = S.n(1,stepper).Rate_U;
        S.delay_min_enter.String = num2str(S.n(1,stepper).Delay_min);
        S.delay_sec_enter.String = num2str(S.n(1,stepper).Delay_sec);
        S.time_min_enter.String  = num2str(S.n(1,stepper).Time_min);
        S.time_sec_enter.String  = num2str(S.n(1,stepper).Time_sec);
end
end
