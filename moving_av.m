function y = moving_av(x, window)
    b = (1/window)*ones(1,window);
    a = 1;
    y = filter(b,a,x);
    plot((1:numel(x)),x)
    hold on
    plot((1:numel(x)),y)
    legend('Input Data','Filtered Data')
end

