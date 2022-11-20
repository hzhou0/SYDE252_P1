function y = gaussian_av(x, window_size)
    b=gausswin(window_size);
    num = b/sum(b);
    denom = 1;
    y = normalize(filter(num,denom,x), x);
end