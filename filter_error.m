function [err, P1, f] = filter_error(x, t, Fs)
    % Transforms x into the frequency domain, P1 resulting signal
    y=fft(x);
    % Compute the two-sided spectrum P2. Then compute the single-sided spectrum 
    % P1 based on P2 and the even-valued signal length L.
    L=numel(t);
    P2 = abs(y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    % Compute the frequency
    f = Fs*(0:(L/2))/L;
    % Calculate the error as the ratio of the sum of the frequencies
    % below the median amplitutde and the sum of the frequencies above the
    % median amplitude
    err=sum(P1(P1<median(P1)))/sum(P1(P1>=median(P1)));
end

