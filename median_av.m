function y = median_av(x, window_size)
    i=1;
    y=zeros(size(x));
    for sig=1:numel(x)
       lower_bound=i-window_size;
       if lower_bound<1
           lower_bound=1;
       end
       y(i)=median(x(lower_bound:lower_bound+window_size,:));
       i=i+1; 
    end
    title("Median filter")
    plot((1:numel(x)),x)
    hold on
    plot((1:numel(x)),y)
    legend('Input Data','Filtered Median Data')
end