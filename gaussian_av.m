function y = gaussian_av(x, window_size)
    b=gausswin(window_size*2);
    b=b(window_size:end);
    num = (1/window_size)*b;
    denom = 1;
    y = filter(num,denom,x);
    plot((1:numel(x)),x)
    hold on
    plot((1:numel(x)),y)
    legend('Input Data','Filtered Gaussian Data')
end