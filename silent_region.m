function silentRegion = silent_region()
    %Close previous figures
    clc; close;

    %Load the speech audio file     
    [x,Fs] = audioread("Dist/Birds.wav");

    %Read the wave file information
    info = audioinfo("Dist/Birds.wav")
    
    %filter out the noise, passing absolute value so that we only have to
    %deal with positive amplitude or 0 amplitude
    x_mov_avg = moving_av(abs(x),100);
    
    %plot(x)
    plot(x_mov_avg);
    
    % currently set by observation, can't find a function to detect dips in
    % signal so that I can average it out like in num_syllables
    threshold = 0.016;

    %vector of 0s for amplitude comparison
    signal_compare = zeros(1, numel(x_mov_avg));

    %creating a vector of 1s and 0s, 1 being under the threshold and 0 
    % being over the threshold
    for n = 1:numel(x_mov_avg)
        if(x_mov_avg(n) <= threshold)
            signal_compare(n)=1;
        end
    end
    
    %variable to count silent regions
    countSilentRegions = 0;

%     for n = 1:numel(x_mov_avg)-1
%         if(signal_compare(n) == 1 && signal_compare(n+1) == 0)
%             countSilentRegions = countSilentRegions + 1;
%         end
%     end
        
    lowerBound = 0; %lower bound of a silent region
    upperBound = 0; %upper bound of a silent region
    for n = 1:numel(x_mov_avg)-1
        %Start of a silent region, vector moves from 0s to 1s
        if(signal_compare(n) == 0 && signal_compare(n+1) == 1)
            lowerBound = n+1;    
        end

        %end of a silent region, vector moves from 1s to 0s
        if(signal_compare(n) == 1 && signal_compare(n+1) == 0)
            upperBound = n;
        end

        %If its a wide enough silent region make the rectangle
        if(upperBound - lowerBound >= 0) 
            %countSilentRegions =  countSilentRegions + 1;
            rectangle('Position',[lowerBound 0 upperBound-lowerBound 0.05]);
        end
    end

end