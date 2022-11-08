function y = median_av(x, t, window_size)
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
    y=normalize(y, x);
%     plot(t,x)
%     hold on
%     plot(t,y)
%     title('Median filter')
%     xlabel('t (seconds)')
%     ylabel('amplitude')
%     legend('Input Data','Filtered Data')
end