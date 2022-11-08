function y = gaussian_av(x, t, window_size)
    b=gausswin(window_size*2);
    b=b(window_size:end);
    num = (1/window_size)*b;
    denom = 1;
    y = normalize(filter(num,denom,x), x);
%     plot(t,x)
%     hold on
%     plot(t,y)
%     title('Gaussian filter')
%     xlabel('t (seconds)')
%     ylabel('amplitude')
%     legend('Input Data','Filtered Data')
end