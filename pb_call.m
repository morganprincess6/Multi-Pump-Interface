function S = pb_call(varargin)
% Function Information
% Parent - Various
% Children - iterate.m
%          - flooring.m
% Description - Changes various inputs due to pushbutton and
%               togglebutton functions; multipurpose button function
S = varargin{3};  %main figure handle
U = varargin{1};  %current uicontrol
good = 1;         %program function check
pumpIndex = 0;    %ASSUMING that there's one Syrris Asia Pump
str = char(U.String);
flag = [1,2];
switch str
%% Asia    
    case 'FILL'
        if(U.Position(1) < 0.5) %Left Channel
            if(S.Lch.Value)
                good = fcn_call(fill(pumpIndex,0,str2num(S.Lstr_fill.String)),'fill (left channel)');
            else  msgbox('You must activate the channel first','User Error','error','modal');
            end
        else                 %Right Channel
            if(S.Rch.Value)
                good = fcn_call(fill(pumpIndex,1,str2num(S.Rstr_fill.String)),'fill (right channel)');
            else  msgbox('You must activate the channel first','User Error','error','modal');
            end
        end
        if(~good)
            U.String = 'FILL ERROR';
            U.FontAngle = 'italic';
        end        
    case 'EMPTY'
        if(U.Position(1) < 0.5) %Left Channel
            if(S.Lch.Value)
                good = fcn_call(empty(pumpIndex,0,str2num(S.Lstr_empty.String)),'empty(left channel)');
            else  msgbox('You must activate the channel first','User Error','error','modal');
            end
        else                 %Right Channel
            if(S.Rch.Value)
                good = fcn_call(empty(pumpIndex,1,str2num(S.Rstr_empty.String)),'empty (right channel)');
            else  msgbox('You must activate the channel first','User Error','error','modal');
            end
        end        
        if(~good)
            U.String = 'EMPTY ERROR';
            U.FontAngle = 'italic';
        end        
    case 'PUMP'
        if(U.Position(1) < 0.5) %Left Channel
            if(S.Lch.Value)
                good = fcn_call(pump(pumpIndex,0,str2num(S.Lstr_pump.String)),'pump (left channel)');
            else  msgbox('You must activate the channel first','User Error','error','modal');
            end
        else                 %Right Channel
            if(S.Rch.Value)
                good = fcn_call(pump(pumpIndex,1,str2num(S.Rstr_pump.String)),'pump (right channel)');
            else  msgbox('You must activate the channel first','User Error','error','modal');
            end
        end       
        if(~good)
            U.String = 'PUMP ERROR';
            U.FontAngle = 'italic';
        end        
    case 'STOP'
        if(U.Position(1) < 0.5) %Left Channel
            good = fcn_call(pumpStop(pumpIndex,0),'stop (left channel)');
            S.Lch.Value = 0;
            S.Lch.String = 'Left Channel Activation';
            S.Lch.FontAngle = 'normal';
            S.Lch.BackgroundColor = S.fig.Color.*0.7;            
        else                    %Right Channel
            good = fcn_call(pumpStop(pumpIndex,1),'stop (right channel)');
            S.Rch.Value = 0;
            S.Rch.String = 'Left Channel Activation';
            S.Rch.FontAngle = 'normal';
            S.Rch.BackgroundColor = S.fig.Color.*0.7;            
        end
        if(~good)
            U.String = 'STOP ERROR';
            U.FontAngle = 'italic';
        end
%     case {'FILL ERROR' 'EMPTY ERROR' 'PUMP ERROR' 'STOP ERROR'}
%         stx = strsplit(str); %grabs first word
%         U.String = stx(1);
%         U.FontAngle = 'normal';
    case 'QUIT Syrris Asia Pump'  
        clearUp;
        fcn_call(exitRemoteMode(pumpIndex),'exitRemoteMode (Quit One)');
        U.ForegroundColor = [0 0 0];
        U.BackgroundColor = [0.7 0.7 0.7];
        S.Asia.Visible = 'Off';
        S.Main.Visible = 'On';
        %Eventually, get this to display Nexus pump (or just next one)
    case{'QUIT Little Things Factory Mr Q.' ...
         'QUIT Chemyx Nexus 3000' 'QUIT Knauer Azura P4.1S' ...
         'QUIT Model 3HI Eldex'}
        if (U.ForegroundColor == [0 0 0]);
            U.ForegroundColor = S.lb_quitone.ForegroundColor;
            U.BackgroundColor = S.lb_quitone.BackgroundColor;
        else
            U.ForegroundColor = [0 0 0];
            U.BackgroundColor = [0.7 0.7 0.7];
        end      
    case 'QUIT ALL DEVICES'
        if (U.ForegroundColor == [0 0 0]);
            U.ForegroundColor = S.lb_quitone.ForegroundColor;
            U.BackgroundColor = S.lb_quitone.BackgroundColor;
        else
            U.ForegroundColor = [0 0 0];
            U.BackgroundColor = [0.7 0.7 0.7];
        end
        clearUp;
        fcn_call(exitRemoteMode,'exitRemoteMode (QuitAll)');
        fcn_call(stopAllPumps,'stopAllPumps (QuitAll)');
        close all;
    case {'Left Channel Activation' 'Right Channel Activation'}
        if strcmp(U.String,'Left Channel Activation'); U.String = 'Left Channel Active';
            good = fcn_call(initialiseChannel(pumpIndex,0),'initialiseChannel (left channel)');
        elseif strcmp(U.String,'Right Channel Activation'); U.String = 'Right Channel Active';
            good = fcn_call(initialiseChannel(pumpIndex,1),'initialiseChannel (right channel)');
        end
        U.FontAngle = 'italic';
        U.BackgroundColor = S.color.asa_org;
        if(~good)
            U.String = 'ACTIVATION ERROR';
            U.FontAngle = 'italic';
        end            
    case {'Left Channel Active' 'Right Channel Active'}
        if strcmp(U.String,'Left Channel Active'); U.String = 'Left Channel Activation';
            good = fcn_call(pumpStop(pumpIndex,0),'pumpStop (left channel)');
        elseif strcmp(U.String,'Right Channel Active'); U.String = 'Right Channel Activation';
            good = fcn_call(pumpStop(pumpIndex,1),'pumpStop (right channel)');
        end
            U.FontAngle = 'normal';
            U.BackgroundColor = S.fig.Color.*0.7;
        if(~good)
            U.String = 'DEACTIVATION ERROR';
            U.FontAngle = 'italic';
        end            
    case char(9650) %up
        if(U.Position(1)==S.panel_struct.coln(1));     flag(1) = 0;  %Left Column
        elseif(U.Position(1)==S.panel_struct.coln(3)); flag(1) = 1;  %Right Column
        end
        if(U.Position(2)==flooring(7.5,'tp'));     flag(2) = 0; %fill
        elseif(U.Position(2)==flooring(6.5,'tp')); flag(2) = 1; %empty
        elseif(U.Position(2)==flooring(5.5,'tp')); flag(2) = 2; %pump           
        end
        S = iterate(S,flag,1); %iterates up by one upper
    case char(9660) %down
        if(U.Position(1)==S.panel_struct.coln(1));     flag(1) = 0;  %Left Column
        elseif(U.Position(1)==S.panel_struct.coln(3)); flag(1) = 1;  %Right Column
        end
        if(U.Position(2)==flooring(7,'fl'));     flag(2) = 0; %fill
        elseif(U.Position(2)==flooring(6,'fl')); flag(2) = 1; %empty
        elseif(U.Position(2)==flooring(5,'fl')); flag(2) = 2; %pump           
        end
        S = iterate(S,flag,-1); %deiterates by one upper
%% Nexus        
    case 'Start'
        if (S.play.ForegroundColor == [.15 .80 .15]); S.play.ForegroundColor =  S.panel_struct.clr*0.7;
        else                            S.play.ForegroundColor = [.15 .80 .15];
        end
    case 'Stop'
        if (S.stop_sq.ForegroundColor == [.90 .05 .05]); S.stop_sq.ForegroundColor =  S.panel_struct.clr*0.7;
        else                            S.stop_sq.ForegroundColor = [.90 .05 .05];
        end
    case 'Pause'
        if (S.pause_sym.ForegroundColor == S.color.lit_blu); S.pause_sym.ForegroundColor = S.panel_struct.clr*0.7;
        else                            S.pause_sym.ForegroundColor = S.color.lit_blu;
        end
    case 'Reset'
        S.play.ForegroundColor =  S.panel_struct.clr*0.7;
        S.stop_sq.ForegroundColor =  S.panel_struct.clr*0.7;
        S.pause_sym.ForegroundColor =  S.panel_struct.clr*0.7;
    case 'Apply Parameters'
        P = get(S.currentstep_enter,{'String','Val'});
        nam = P{1}{P{2}};
        stepper = str2double(nam(5:length(nam))); %gets rid of 'Step_', grabs value;
        S.n(1,stepper).Volume    = str2double(S.volume_enter.String);
        S.n(1,stepper).Volume_U  = S.ml_label.String;
        S.n(1,stepper).Rate      = str2double(S.rate_enter.String);
        S.n(1,stepper).Rate_U    = S.ml_min_label.String;
        S.n(1,stepper).Delay_min = str2double(S.delay_min_enter.String);
        S.n(1,stepper).Delay_sec = str2double(S.delay_sec_enter.String);
        S.n(1,stepper).Time_min  = str2double(S.time_min_enter.String);
        S.n(1,stepper).Time_sec  = str2double(S.time_sec_enter.String);
        
    case 'Add Step Before'
        P = get(S.currentstep_enter,{'String','Val'});
        nam = P{1}{P{2}};
        stepper = str2double(nam(5:length(nam))); %gets rid of 'Step_', grabs value;
        h=1;    %searches for end of the line
        while((h<=3000)&&(strcmp(S.n(h).Name,'Step_0'))); h=h+1; end;
        if(h>3000); disp('Error, max limit exceeded finding struct name'); end;
        for i = stepper:(h-1)
            j = h-i+stepper; %backwards iterator
            S.n(j) = S.n(j-1);            
        end
        S.n(1,stepper).Volume    = str2double(S.volume_enter.String);
        S.n(1,stepper).Volume_U  = S.ml_label.String;
        S.n(1,stepper).Rate      = str2double(S.rate_enter.String);
        S.n(1,stepper).Rate_U    = S.ml_min_label.String;
        S.n(1,stepper).Delay_min = str2double(S.delay_min_enter.String);
        S.n(1,stepper).Delay_sec = str2double(S.delay_sec_enter.String);
        S.n(1,stepper).Time_min  = str2double(S.time_min_enter.String);
        S.n(1,stepper).Time_sec  = str2double(S.time_sec_enter.String);
        %Add stepper
        S.currentstep_enter.String{h} = strcat('Step',{' '},num2str(h));
    case 'Add Step After'
        P = get(S.currentstep_enter,{'String','Val'});
        nam = P{1}{P{2}};
        stepper = str2double(nam(5:length(nam))); %gets rid of 'Step_', grabs value;
        h=1;    %searches for end of the line
        while((h<=3000)&&(strcmp(S.n(h).Name,'Step_0'))); h=h+1; end;
        if(h>3000); disp('Error, max limit exceeded finding struct name'); end;
        for i = (stepper+1):(h-1)
            j = h-i+(stepper+1); %backwards iterator
            S.n(j) = S.n(j-1);            
        end
        S.n(1,stepper+1).Volume    = str2double(S.volume_enter.String);
        S.n(1,stepper+1).Volume_U  = S.ml_label.String;
        S.n(1,stepper+1).Rate      = str2double(S.rate_enter.String);
        S.n(1,stepper+1).Rate_U    = S.ml_min_label.String;
        S.n(1,stepper+1).Delay_min = str2double(S.delay_min_enter.String);
        S.n(1,stepper+1).Delay_sec = str2double(S.delay_sec_enter.String);
        S.n(1,stepper+1).Time_min  = str2double(S.time_min_enter.String);
        S.n(1,stepper+1).Time_sec  = str2double(S.time_sec_enter.String);  
        %Add stepper
        S.currentstep_enter.String{h} = strcat('Step',{' '},num2str(h));
        S.currentstep_enter.Value = stepper+1; %Move to applied new stepper parameters  
    case 'Remove Step'
       P = get(S.currentstep_enter,{'String','Val'});
        nam = P{1}{P{2}};
        stepper = nam(5:length(nam)); %gets rid of 'Step_', grabs value
        h=1;    %searches for end of the line
        while((h<=3000)&&(strcmp(S.n(h).Name,'Step_0'))); h=h+1; end;
        if(h>3000); disp('Error, max limit exceeded finding struct name'); end;
        for i = stepper:(h-1)
            S.n(i) = S.n(i+1);
        end
        S.volume_enter.String    = num2str(S.n(1,stepper).Volume);
        S.ml_label.String        = S.n(1,stepper).Volume_U;
        S.rate_enter.String      = num2str(S.n(1,stepper).Rate);
        S.ml_min_label.String    = S.n(1,stepper).Rate_U;
        S.delay_min_enter.String = num2str(S.n(1,stepper).Delay_min);
        S.delay_sec_enter.String = num2str(S.n(1,stepper).Delay_sec);
        S.time_min_enter.String  = num2str(S.n(1,stepper).Time_min);
        S.time_sec_enter.String  = num2str(S.n(1,stepper).Time_sec);  
        %Remove stepper
        S.currentstep_enter.String(:,h-1) = []; %delete last stepper
end  %switch end

if(~good) %error check
   errorCode = strcat('Error=',getLastError(pumpIndex));
   disp(errorCode); %program failure means that Syrris Asia pump has stopped
end

%% Mr. Q
%str
switch str
%     case 'invisible'
%         if U.Value;
    case 'Time Operation 1'
%         if U.Value
           S.result_panel_time1.Visible = 'On';
           S.result_panel_time.Visible = 'On';
           S.cal_dateTextHandle1.Visible = 'On';
           S.cal_dateEditBoxHandle1.Visible = 'On';
           S.calendarButtonHandle1.Visible = 'On';
           S.time_title1.Visible = 'On';
           S.colon1_1.Visible = 'On';
           S.hour_enter1.Visible = 'On';
           S.colon2_1.Visible = 'On';
           S.min_enter1.Visible = 'On';
           S.sec_enter1.Visible = 'On';
           S.AM_PM1.Visible = 'On';
           S.result_panel_volume1.Visible = 'Off';
           S.result_panel_volume.Visible = 'Off';
           S.result_panel_ml.Visible = 'Off';
           S.volume_enter.Visible = 'Off';
%         else
%            S.result_panel_time1.Visible = 'Off';
%            S.result_panel_volume1.Visible = 'On';
%         end 
    case {'Volume Operation 1'}
%         if U.Value
           S.result_panel_time1.Visible = 'Off';
           S.result_panel_time.Visible = 'Off';
           S.cal_dateTextHandle1.Visible = 'Off';
           S.cal_dateEditBoxHandle1.Visible = 'Off';
           S.calendarButtonHandle1.Visible = 'Off';
           S.time_title1.Visible = 'Off';
           S.colon1_1.Visible = 'Off';
           S.hour_enter1.Visible = 'Off';
           S.colon2_1.Visible = 'Off';
           S.min_enter1.Visible = 'Off';
           S.sec_enter1.Visible = 'Off';
           S.AM_PM1.Visible = 'Off';
           S.result_panel_volume1.Visible = 'On';
           S.result_panel_volume.Visible = 'On';
           S.result_panel_ml.Visible = 'On';
           S.volume_enter.Visible = 'On';

    case 'Time Operation 2'
%         if U.Value
           S.result_panel_time2.Visible = 'On';
           S.result_pan_time2.Visible = 'On';
           S.cal_dateTextHandle2.Visible = 'On';
           S.cal_dateEditBoxHandle2.Visible = 'On';
           S.calendarButtonHandle2.Visible = 'On';
           S.time_title2.Visible = 'On';
           S.colon1_2.Visible = 'On';
           S.hour_enter2.Visible = 'On';
           S.colon2_2.Visible = 'On';
           S.min_enter2.Visible = 'On';
           S.sec_enter2.Visible = 'On';
           S.AM_PM2.Visible = 'On';
           S.result_panel_volume2.Visible = 'Off';
           S.result_panel_vol2.Visible = 'Off';
           S.result_panel_ml2.Visible = 'Off';
           S.volume_enter2.Visible = 'Off';
%         else
%            S.result_panel_time1.Visible = 'Off';
%            S.result_panel_volume1.Visible = 'On';
%         end 
    case {'Volume Operation 2'}
%         if U.Value
           S.result_panel_time2.Visible = 'Off';
           S.result_pan_time2.Visible = 'Off';
           S.cal_dateTextHandle2.Visible = 'Off';
           S.cal_dateEditBoxHandle2.Visible = 'Off';
           S.calendarButtonHandle2.Visible = 'Off';
           S.time_title2.Visible = 'Off';
           S.colon1_2.Visible = 'Off';
           S.hour_enter2.Visible = 'Off';
           S.colon2_2.Visible = 'Off';
           S.min_enter2.Visible = 'Off';
           S.sec_enter2.Visible = 'Off';
           S.AM_PM2.Visible = 'Off';
           S.result_panel_volume2.Visible = 'On';
           S.result_panel_vol2.Visible = 'On';
           S.result_panel_ml2.Visible = 'On';
           S.volume_enter2.Visible = 'On';
%         else
%            S.result_panel_time1.Visible = 'On';
%            S.result_panel_volume1.Visible = 'Off';
%         end 
%         if ~U.Value
%             set(findall(S.result_panel_volume2, '-property', 'Visible'), 'Visible', 'off');
%         else
%             set(findall(S.result_panel_volume2, '-property', 'Visible'), 'Visible', 'on');
%         end
%         if U.Value
%             set(S.check_timeop2, 'Enable', 'off');
%         else
%             set(S.check_timeop2, 'Enable', 'on');
%         end
end
%     case {'checktime1'}
%         if ~U.Value; set(findall(S.result_panel_time1, '-property', 'Visible'), 'Visible', 'off');
%         else set(findall(S.result_panel_time1, '-property', 'Visible'), 'Visible', 'on');
%         end  
%         if U.Value; set(S.checkbox_volume1, 'Enable', 'off');
%         else set(S.checkbox_volume1, 'Enable', 'on');
%         end

%     case {'checktime2'}
%         if ~U.Value; set(findall(S.result_panel_time2, '-property', 'Visible'), 'Visible', 'off');
%         else set(findall(S.result_panel_time2, '-property', 'Visible'), 'Visible', 'on');
%         end  
%         if U.Value; set(S.checkbox_volume2, 'Enable', 'off');
%         else set(S.checkbox_volume2, 'Enable', 'on');
%         end


end  %function end

% CODE for rate Javax.spinner --- still unfinished!!!
% if(strcmp(U.String,char(9650))||strcmp(U.String,char(9660)))
%     if(U.Value == 0)
%         tic;        %Starts stopwatch
%         J = java.awt.Robot;
%         % U.Value = 1 as soon as pb_call is made 
%         % then U.Value = 0 after second release
%         J.mouseRelease(java.awt.event.InputEvent.BUTTON1_MASK); %Ends ButtonDownFcn
%         J.mousePress(java.awt.event.InputEvent.BUTTON1_MASK);   %Starts Callback
% %         k = 0.5; %delay seconds
% %         l = 0.1; %fast iteration seconds
% %         while U.Value
% %             elapsedTime = toc;
% %             if(elapsedTime > 0.5)
% %                 if(elapsedTime>=k)
% %                     disp(elapsedTime);
% %                     k = k+l;
% %                 end
% %             end
% %         end
%     end
% end
