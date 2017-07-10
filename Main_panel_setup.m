function S = Main_panel_setup(varargin)
% Function Information
% Parent - PanelSet.m
% Additions - S.Main 
%           - S.Title
% Description - Creates Main panel and all of the
%               functions and interfaces associated with
%               this particular pump
S = varargin{1};
%% Deconstruction
btn_w = S.panel_struct.btn_w;
btn_h = S.panel_struct.btn_h;
lbl_h = S.panel_struct.lbl_h;
flb_h = S.panel_struct.flb_h;
arr_w = S.panel_struct.arr_w;
panel_w = S.panel_struct.panel_w;
clr = S.panel_struct.clr;
edit_clr = S.panel_struct.edit_clr;
panpos = S.panel_struct.panpos;
coln = S.panel_struct.coln;
Max = S.panel_struct.Max;
Min = S.panel_struct.Min;
red = S.color.red;
blu = S.color.blu;
grn = S.color.grn;
ppl = S.color.ppl;
org = S.color.org;
wht = S.color.wht;
blk = S.color.blk;
lit_red = S.color.lit_red;
lit_blu = S.color.lit_blu;
lit_grn = S.color.lit_grn;
lit_ppl = S.color.lit_ppl;
lit_org = S.color.lit_org;

%% Main Panel
S.Main = uipanel('BorderType','none','BackgroundColor',edit_clr,'Visible','On','Position',panpos,'Tag','Main');
S.Title = uicontrol(S.Main,'style','text','units','normalized',...
                 'position',[0 flooring(5.3,'b') 1 3*btn_h],'BackgroundColor',edit_clr,...
                 'FontUnits','normalized','FontWeight','bold','FontSize',0.17,...                 
                 'string','Multi-Pump Driver Interface - Main Panel');
S.Find_Devices = uicontrol(S.Main,'style','pushbutton','units','normalized',...
                 'position',[coln(2)+btn_w/2 flooring(4.5,'b') coln(3)-coln(2) btn_h],...
                 'FontUnits','normalized','FontWeight','bold','FontSize',0.3,'UserData',0,... %UserData is number of machines
                 'string','Find Devices','BackgroundColor', (clr.*0.97));%,'callback',{@main_panel_pb_call,S});

% S.Llbl_fill = uicontrol(S.Main,'style','pushbutton','units','normalized',...
%                  'position',[coln(1)+arr_w flooring(7.5,'tp') btn_w-arr_w flb_h],...
%                  'FontUnits','normalized','FontWeight','bold',...                 
%                  'string','Fill rate (ul/min)','BackgroundColor',lit_blu,'callback',{@pb_call,S});
% S.Llbl_fill = uicontrol(S.Asia,'style','text','units','normalized',...
%                  'position',[coln(1)+arr_w flooring(7.5,'tp') btn_w-arr_w flb_h],...
%                  'FontUnits','normalized','FontWeight','bold',...                 
%                  'string','Fill rate (ul/min)','BackgroundColor',lit_blu,'callback',{@pb_call,S});
% S.Llbl_fill = uicontrol(S.Asia,'style','text','units','normalized',...
%                  'position',[coln(1)+arr_w flooring(7.5,'tp') btn_w-arr_w flb_h],...
%                  'FontUnits','normalized','FontWeight','bold',...                 
%                  'string','Fill rate (ul/min)','BackgroundColor',lit_blu,'callback',{@pb_call,S});
% S.Llbl_fill = uicontrol(S.Asia,'style','text','units','normalized',...
%                  'position',[coln(1)+arr_w flooring(7.5,'tp') btn_w-arr_w flb_h],...
%                  'FontUnits','normalized','FontWeight','bold',...                 
%                  'string','Fill rate (ul/min)','BackgroundColor',lit_blu,'callback',{@pb_call,S});           

end


