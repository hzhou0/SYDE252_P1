function y = gaussian_av(x, window_size)
    % Create a gaussian transfer function of window_size
    b=gausswin(window_size);
    num = b/sum(b);
    denom = 1;
    % Filter x with generated gaussian filter and normalize
    y = normalize(filter(num,denom,x), x);
end