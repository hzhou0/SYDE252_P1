function syllables = num_of_syllables_amplitude()

    %Close previous figures
    clc; close;

    %Load the speech audio file     
    [x,Fs] = audioread("Preprocessed Audio Files/Speech.wav");

    %Read the wave file information
    info = audioinfo("Preprocessed Audio Files/Speech.wav")
   
    %Take a gaussian average filter to reduce noise variation 
    y_gauss_av = gaussian_av(abs(x),14);
  
    %Find the peaks of the function
    [pks, locs] = findpeaks(y_gauss_av);


    %Compute the mean amplitude of the peaks as a threshhold
    threshold = 0.01

    %A vector to check if the each amplitude is greater than the threshold
    syllable_signal = zeros(1,numel(pks))';

    %Arbitrary value used just for plotting the regions for syllable_signal
    syllable_detected_amplitude = 0.45;

    %Iterate through all values and set the vector element in
    %syllable_signal to 1 if greater than the mean
    for n = 1:numel(pks)
        if(pks(n) >= threshold)
            syllable_signal(n) = syllable_detected_amplitude;
        end
    end
    
    
    
    %Temp variabes used for counting if the amplitudes constitute a signal
    num_syllables = 0; %Number of syllables determines
    consecutive_count = 0; %Number of consecutive peaks above threshhold
    consecutive_peak_threshold = 75; %The number of consecutive peaks required for a syllables

    %Iterate through each peak and determine the number of syllables
    for k = 1:numel(pks)
        
        if(syllable_signal(k) == syllable_detected_amplitude)
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
  
    %Plot the syllable detection overalyed
    plot(abs(y_gauss_av))
    yline(threshold,Label="Threshold",color='red')
    plot(locs,syllable_signal)
    

    title("Speech.wav Number of Syllables Detection")
    xlabel("Sample Number");
    ylabel("Audio Data Amplitude");
    legend("Filtered Signal", "Signal Above Threshold")

    
end 
