%%########################################################################
% preprocess_audio_file.m
% 
% SYDE 252 - Project #1: Audio Processing in Time Domain
% November 2, 2022
% Written By: Sean Clarke, Henry Zhou, Shourrya Guha
%%########################################################################
 
function sampling_rate = preprocess_audio_files(file_names, out)
    for file_name = file_names
        %Read in audio file. y is audio data, Fs is sampling rate
        [y,Fs] = audioread(file_name);
        info = audioinfo(file_name);
        
        %Extract the sampling rate for the original file
        sampling_rate = info.SampleRate;
        
        %If stereo, sum both channels together to form a mono signal
        if (info.NumChannels == 2)
            y = y(:, 1) + y(:, 2);
        end
        
        %Plot figures
        fig=figure();
        fig.UserData=struct("audio", y, "Fs", Fs);
        
        %Adding a play sound button
        c = uicontrol;
        c.String = 'Play';
        c.Callback = @callback; %Play the audio file

        %Write sound to a new file
        audiowrite(fullfile(out, file_name), y, Fs);
        
        hold on; grid on
    
        %Define the range of the sound waveform plot
        x=(1:info.TotalSamples);
    
        %Plot sound waveform
        plot(x,y)
    
        %Resample up/down-scaling to 16 kHz
        y_new = resample(y,16000,sampling_rate);
       
        %Define new range
        x_new=(1:numel(y_new));
    
        %Plot resampled audio file
        plot(x_new,y_new)

        %Add chart elements
        legend('Original Waveform','Waveform Resampled at 16 kHz');
        title(append('Sound waveform graph for: ', file_name));
        xlabel('Sample Number');
        ylabel('Audio Data');
    end
    function callback(src, ~)
            data=ancestor(src,"figure","toplevel").UserData;
            sound(data.audio, data.Fs);
    end
end

