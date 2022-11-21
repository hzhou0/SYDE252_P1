function y = median_av(x, window_size)
    i=1;
    y=1:numel(x);
    
    % Take a sliding window over the signal
    for sig=1:numel(x)
       lower_bound=i-window_size;
       
       % If lower bound is out of bounds, set it as 1
       % For smaller window sizes (<1000) this is irrelevant
       if lower_bound<1
           lower_bound=1;
       end
       
       % Set output as the median of the sliding window
       y(i)=median(x(lower_bound:lower_bound+window_size-1,:));
       i=i+1; 
    end
    y=y';
end
