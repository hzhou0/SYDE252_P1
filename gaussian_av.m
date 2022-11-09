function y = gaussian_av(x, window_size)
    % Compute the gaussian convolution vector and clip it to window size
    b = gausswin(window_size*2);
    b = b(window_size:end);
    % Apply it as the filter
    num = (1/window_size)*b;
    denom = 1;
    y = normalize(filter(num,denom,x), x);
end

function [] = graph_gaussian_av(x, y, t)
     plot(t,x)
     hold on
     plot(t,y)
     title('Gaussian filter')
     xlabel('t (seconds)')
     ylabel('amplitude')
     legend('Input Data','Filtered Data')
end
