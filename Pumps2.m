function [] = Pumps2()
% Function Information
% Master/Root function (no parent)
% Children - addcomponents.m
%          - pumpcall.m
% Description - Defines and then instantiates GUI
close all;                         %gives GUI clean start
clear all;
%mex -setup C; setenv('MW_MINGW64_LOC','C:\TDM-GCC-64');  %allows gui to access .dll files
P = path;                          %ensure GUI is on correct path
%if ~strcmp('H:\008',strcat(P(1:6))); addpath H:\008; end
%style('');                         %Windows Classic Style
S = addcomponents;                 %creates GUI
S.fig.Visible = 'on';              %instantiates GUI
S.pump.Callback = {@pump_call,S};       %creates pump selection callback
S.recipe.Callback = {@recipe_call,S};   %creates recipe selection callback
S.device.Callback = {@device_call,S};   %creates device selection callback
%com.jidesoft.plaf.LookAndFeelFactory.installJideExtension();  %restores all changes to Look and Feel outside of MATLAB
end
