function y = moving_av(x, window_size)
     
    %Create a vector for the window size (numerator)
    b = (1/window_size)*ones(1,window_size);

    %Denominator
    a = 1;

    %Applying moving average filter by a ratio of b/a and sliding across x
    y = filter(b,a,x);

end

