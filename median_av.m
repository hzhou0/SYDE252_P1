function y = median_av(x, window_size)
    i=1;
    y=zeros(size(x));
    %Iterate over signal vector, replacing each value with the median of
    %the sliding window
    for sig=1:numel(x)
       lower_bound=i-window_size;
       if lower_bound<1
           lower_bound=1;
       end
       y(i)=median(x(lower_bound:lower_bound+window_size,:));
       i=i+1; 
    end
    % Normalize magnitude of signal
    y=normalize(y, x);
end

function [] = graph_median_av(x, y, t)
    plot(t,x)
    hold on
    plot(t,y)
    title('Median filter')
    xlabel('t (seconds)')
    ylabel('amplitude')
    legend('Input Data','Filtered Data')
end