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

    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(L/2))/L;
    
    
    %plot(f,P1) ;
    title("Drums Signal Highpassed at 12 kHz")
    xlabel("Sample Number");
    ylabel("Audio Data Amplitude");
    

    % Highpass above 12 kHz, experimentally found to be the best
    y_2 = highpass(Y,12000,Fs);
    p2 = abs(y_2/L);
    p1 = p2(1:L/2+1);

    hold on
    %plot (f,p1);

    %Inverse FFT to return to discrete-time domain
    Y_2 = ifft(y_2);


    sound(abs(Y_2),Fs)
    plot(abs(Y_2))

end


    