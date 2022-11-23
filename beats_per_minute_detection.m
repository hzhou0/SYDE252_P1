%%########################################################################
% beats_per_minute_detection.m
% 
% SYDE 252 - Project #1: Audio Processing in Time Domain
% November 2, 2022
% Written By: Sean Clarke, Henry Zhou, Shourrya Guha
%%########################################################################

function BPM = beats_per_minute_detection()
    
    %Close previous figures
    clc; close;

    %Load the speech audio file
    [X,Fs] = audioread("Dist/Drum.wav");

    %Read the wave file information
    info = audioinfo("Dist/Drum.wav")
   
    L = info.TotalSamples; %Length of the audio clip
    Y = fft(X); %Fast fourier transform to convert to frequency domain
    
    % Highpass above 8 kHz, experimentally found to be the best
    y_2 = highpass(Y,7000,Fs);
 
    %Inverse FFT to return to discrete-time domain
    Y_2 = ifft(y_2);

    %Abosulte value of the signal gives the amplitudes from ifft
    abs_Y_2 = abs(Y_2);

    sound(abs_Y_2,Fs);

    %Determining which instrument signal peaks correspond to
    %sound(abs_Y_2(20000:35000),Fs); %High-pitch cymbal sample
    %sound(abs_Y_2(40000:52000),Fs); %Edge hit sample

    %Plot the highpassed waveform
    figure
    plot(abs(Y_2))
    title("Drums Signal Highpassed at 8 kHz")
    xlabel("Sample Number");
    ylabel("Audio Data Amplitude");

end


    