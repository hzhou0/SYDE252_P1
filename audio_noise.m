function R = audio_noise(x)
    a=(1:numel(x)).';
    [f, gof] = fit(a,x,'cubicinterp');
    plot(f, (1:numel(x)), x)
    R=gof
end

