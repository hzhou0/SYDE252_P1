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
%sampling_rate = preprocess_audio_files(audio_files, "Dist");
% [x, Fs]=audioread("Dist/Drum.wav");
% figure
% plot(gaussian_av(x, 1));
% figure
% plot(gaussian_av(x, 10));
% figure
% plot(gaussian_av(x, 100));
% sum(abs(x-gaussian_av(x, 2)))
% sum(abs(x-gaussian_av(x, 5)))
% sum(abs(x-gaussian_av(x, 10)))
% sum(abs(x-gaussian_av(x, 100)))
%%########################################################################
% Gaussian Filter
%%########################################################################
error_plot(@gaussian_av, "Gaussian", 100);
%error_plot(@median_av, "Median");
error_plot(@moving_av, "Moving", 100);


function []=error_plot(filter_function, function_name, max_window_size)
    figure
    hold on;
    colors=['r' 'g' 'b'];
    i=1;
    for file_path = ["Dist/Drum.wav", "Dist/Birds.wav", "Dist/Speech.wav"]
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