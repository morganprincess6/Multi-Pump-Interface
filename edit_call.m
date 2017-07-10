# Multi-Pump-Interface
function [] = edit_call(varargin)
% Function Information
% Parent - Various
% Children - iterate.m
%          - flooring.m
% Description - Changes various inputs due to editable textbox
%               functions; multipurpose editable textbox function

S = varargin{3};  %main figure handle
U = varargin{1};  %current uicontrol
max = S.panel_struct.Max;
min = S.panel_struct.Min;
num = str2num(U.String);
num = (num>max)*max+(num<=max)*num;
num = (num<min)*min+(num>=min)*num;
U.String = num2str(num);
end
