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
addpath("Assets/");
sampling_rate = preprocess_audio_files(audio_files, "Preprocessed Audio Files");


%%########################################################################
% Error plots
%%########################################################################
error_plot(@gaussian_av, "Gaussian", 100);
error_plot(@median_av, "Median", 100);
error_plot(@moving_av, "Moving", 100);

%%########################################################################
% Audio Processing - Part 3
%%########################################################################

silent_region()
syllables = num_syllables_amplitude()
beats_per_minute_detection()

function []=error_plot(filter_function, function_name, max_window_size)
    figure
    hold on;
    colors=['r' 'g' 'b'];
    i=1;
    for file_path = ["Preprocessed Audio Files/Drum.wav", "Preprocessed Audio Files/Birds.wav", "Preprocessed Audio Files/Speech.wav"]
        % Compute signal charateristics
        [x] = audioread(file_path);
        % Tune filter parameters
        noise=1:max_window_size;
        drift=noise;
        for c = 1:numel(noise)
           y=filter_function(x, c);
           [n, d]=filter_error(y, x);
           noise(c)=n;
           drift(c)=d;
        end
        noise=rescale(noise);
        drift=rescale(drift);
        plot(linspace(1, numel(noise),numel(noise)), noise, 'Color', colors(i));
        plot(linspace(1, numel(drift),numel(drift)), drift, '--', 'Color', colors(i));
        i=i+1;
    end
    legend('Drum.wav noise', 'Drum.wav drift', 'Birds.wav noise', 'Birds.wav drift', 'Speech.wav noise', 'Speech.wav drift')
    title(append(function_name, ' error plot'))
    ylabel('Relative value')
    xlabel('Window size')
end


