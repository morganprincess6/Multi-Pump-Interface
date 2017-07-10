function SafeClose(varargin)
% Function Information
% Parent - addcomponents.m
% Description - Changes figure close so that pumps close first
   selection = questdlg('Close This Figure?',...
      'Close Request Function',...
      'Yes','No','Yes'); 
   switch selection, 
      case 'Yes',
         %pb_call(S.pb_quitall,~,S); work with it later
      case 'No'
      return 
   end
end
