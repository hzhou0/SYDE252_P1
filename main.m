%%########################################################################
% SYDE_252_Main.m
%
% SYDE 252 - Project #1: Audio Processing in Time Domain
% November 2, 2022
% Written By: Sean Clarke, Henry Zhou, Shourrya Guha
%%########################################################################

%%########################################################################
% Initial Setup
%%########################################################################

% Clearing outputs
close all; % Close all figure
clc;       % Clear command window
clear;     % Clear memory

audio_files = arrayfun(@(x) string(x.name), dir("Assets/*.wav")).';
% sampling_rate = preprocess_audio_files(audio_files, "Dist");
%% Compute signal charateristics
[x,Fs] = audioread("Dist/Birds.wav");
T=1/Fs;
L=numel(x);
t=(0: L-1)*T;
%% Filters
step=50;
err=1:200;
for c = 1:numel(err)
   y=gaussian_av(x, t, c*step);
   [e]=filter_error(y, t, Fs);
   err(c)=e;
end
figure
plot(linspace(1, numel(err)*step,numel(err)), err);
%figure
%y=gaussian_av(x,10);
%figure
%y=median_av(x,5);
%[~, sig_fdom]=filter_error(x);
%plot((1:numel(sig_fdom)),sig_fdom)