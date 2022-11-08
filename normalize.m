function y = normalize(x, orig_x)
    ceiling=max([max(orig_x), abs(min(orig_x))]);
    y=(ceiling/max([max(x), abs(min(x))]))*x;
end

