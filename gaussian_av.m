function y = gaussian_av(x, window_size)

    b=gausswin(window_size*2);

    b=b(window_size:end);

    num = (1/window_size)*b;

    denom = 1;
    
    y = normalize(filter(num,denom,x), x);
end