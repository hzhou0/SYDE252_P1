function [err, P1, f] = filter_error(x, t, Fs)
    y=fft(x);
    L=numel(t);
    P2 = abs(y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    err=sum(P1(P1<median(P1)))/sum(P1(P1>=median(P1)));
end

