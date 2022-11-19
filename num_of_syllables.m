function syllables = num_of_syllables()
    clc; close;
    num_syllables = 0;
    %Load the speech audio file
    [x,Fs] = audioread("Dist/Speech.wav");

    %Read the wave file information
    info = audioinfo("Dist/Speech.wav")
    
    %Use the gaussian average filter to reduce noise with window size of 100
    y = gaussian_av(x,0,100);
    
    %y_mov_av = moving_av(abs(y),0,100)
    
    %[peaks, locs] = findpeaks(abs(y));
    %median_val = mean(y_mov_av)


    %fit((k-2:k+2)',y(k-2:k+2),'poly1').p1

    slope=(1:numel(y))';
    
    for k = 1:numel(y)-1
        slope(k)=(y(k+1)-y(k))/2;
    end
    slope=slope(1:end-1);
    average_slope = median(slope);
    average_slope
    slope=moving_av(slope, 0, 10);
    figure
    plot((1:numel(slope)-1), slope(1:end-1));
    
    syllable_signal = zeros(1,numel(slope))';
    for n = 1:numel(slope)
        if(slope(n)>=average_slope)
            syllable_signal(n)=1;
        end
    end
    
  
    %plot(abs(y))
    %plot(y_mov_av)
    %plot(locs,peaks,'o')
    figure
    plot(syllable_signal)
    
end 


    %Find the peaks of the postive parts of the signal every 20th of the
    %file sampling rate to create an approximation of the singal
    %[peaks, locs] = findpeaks(abs(y),'MinPeakDistance',info.SampleRate/20);

    %find the peaks of the peaks of the funciton
    %[peaks2, locs2]= findpeaks(peaks,locs)

    %Plot the filtered signal approximation of the peaks of the signal
    %plot(locs, peaks)

    %Return the number of syllables as the number of peaks in
    %syllables = numel(peaks2)