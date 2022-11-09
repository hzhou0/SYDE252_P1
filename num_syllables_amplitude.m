function syllables = num_of_syllables_amplitude()

    %Close previous figures
    clc; close;

    %Load the speech audio file
    [x,Fs] = audioread("Dist/Speech.wav");

    %Read the wave file information
    info = audioinfo("Dist/Speech.wav")
    
    %Use the gaussian average filter to maximize peaks/reduce noise with window size of 10
    y = gaussian_av(x,0,10);
    
    %Take a moving average filter to reduce noise variation
    y_mov_av = moving_av(abs(y),0,250);
  
    %Compute the mean amplitude of the absolute values of the signa;
    mean_val = mean(y_mov_av);

    %Avector to check if the each amplitude is greater than the mean
    syllable_signal = zeros(1,numel(y_mov_av))';

    %Iterate through all values and set the vector element in
    %syllable_signal to 1 if greater than the mean
    for n = 1:numel(y_mov_av)
        if(y_mov_av(n) >= mean_val)
            syllable_signal(n)=1;
        end
    end
    

    %Temp variabes used for counting if the amplitudes constitute a signal
    num_syllables = 0;
    concurrent_count = 0;

    %Iterate through and if part of the signal is continuously above the
    %mean (for 100 samples), it counts as a syllable
    for k = 2:numel(syllable_signal)
       
        if(syllable_signal(k) == 1 && syllable_signal(k-1) == 1)
            concurrent_count = concurrent_count + 1;
        else
            if(concurrent_count >= 100)
                num_syllables = num_syllables + 1;
            end

            concurrent_count = 0;
        end

    end

    %Output the number of syllables
    syllables = num_syllables

    hold on;
  
    %plot(abs(y))
    plot(syllable_signal)
    
end 
