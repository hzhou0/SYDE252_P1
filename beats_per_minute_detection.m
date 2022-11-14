function BPM = beats_per_minute_detection()

    %Close previous figures
    clc; close;

    %Load the speech audio file
    [X,Fs] = audioread("Dist/Drum.wav");

    %Read the wave file information
    info = audioinfo("Dist/Drum.wav")
    
    L = info.TotalSamples;
    Y = fft(X);

    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(L/2))/L;
    %plot(f,P1) ;
    title("Drums Signal Highpassed at 12 kHz")
    xlabel("Sample Number");
    ylabel("Audio Data Amplitude");
    


    y_2 = highpass(Y,12000,Fs); % Highpass above 12 kHz

    p2 = abs(y_2/L);
    p1 = p2(1:L/2+1);

    hold on
    %plot (f,p1);

    Y_2 = ifft(y_2);
    sound(abs(Y_2),Fs)
    plot(abs(Y_2))

    