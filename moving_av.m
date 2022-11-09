function y = moving_av(x, window)
    b = (1/window)*ones(1,window);
    a = 1;
    y = normalize(filter(b,a,x), x);
end

function [] = graph_moving_av(x, y, t)
    plot(t,x)
    hold on
    plot(t,y)
    title('Moving Average Filter')
    xlabel('t (seconds)')
    ylabel('amplitude')
    legend('Input Data','Filtered Data')
end

