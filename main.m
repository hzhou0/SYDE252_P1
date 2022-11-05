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
sampling_rate = preprocess_audio_files(audio_files, "Dist");