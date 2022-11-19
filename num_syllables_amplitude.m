function syllables = num_of_syllables_amplitude()

    %Close previous figures
    clc; close;

    %Load the speech audio file     
    [x,Fs] = audioread("Dist/Speech.wav");

    %Read the wave file information
    info = audioinfo("Dist/Speech.wav")
   
    %Take a moving average filter to reduce noise variation
    y_mov_av = moving_av(abs(x),90);
    
    %sound(y_mov_av,Fs)
  
    %Find the peaks of the function
    [pks, locs] = findpeaks(y_mov_av)


    %Compute the mean amplitude of the peaks as a threshhold
    threshold = mean(pks)

    %Avector to check if the each amplitude is greater than the mean
    syllable_signal = zeros(1,numel(pks))';

    %Iterate through all values and set the vector element in
    %syllable_signal to 1 if greater than the mean
    for n = 1:numel(pks)
        if(pks(n) >= threshold)
            syllable_signal(n)=1;
        end
    end
    

    %Temp variabes used for counting if the amplitudes constitute a signal
    num_syllables = 0; %Number of syllables determines
    consecutive_count = 0; %Number of consecutive peaks above threshhold
    consecutive_peak_threshold = 75 %The number of consecutive peaks required for a syllables

    %Iterate through each peak and determine the number of syllables
    for k = 2:numel(syllable_signal)
       
        if(syllable_signal(k) == 1 && syllable_signal(k-1) == 1)
            consecutive_count = consecutive_count + 1;
        else
            if(consecutive_count >= consecutive_peak_threshold)
                num_syllables = num_syllables + 1;
            end

            consecutive_count = 0;
        end

    end

    %Output the number of syllables
    syllables = num_syllables

    hold on;
  
    plot(abs(y_mov_av))
    yline(threshold)
    plot(locs,pks,'o')
    plot(locs,syllable_signal)
    
end 
