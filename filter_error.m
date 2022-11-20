
function [noise, drift, P1] = filter_error(filtered, original)
    % take the fourier transform of the input signal 
    y=fft(filtered);
    % length is number of time samples
    L=numel(filtered);
    % y contains both negative and positive frequencies
    P2 = abs(y/L);
    % compute single-sided amplitude spectrum with only positive
    % frequencies
    P1 = P2(1:uint8(L/2+1));
    P1(2:end-1) = 2*P1(2:end-1);
    % f is the frequency domain, based on the samplying frequency
    % Assume the true signal a combination of high frequency peaks: 
    % everything above some threshold being the true signals
    % and everything below that as noise.

    % Define noise as the ratio between the sum of true
    % frequencies vs the sum of noise frequencies.
    threshold=median(P1);
    noise=sum(P1(P1<threshold))/sum(P1(P1>=threshold));

    % Define drift as the root mean square difference between the original
    % and filtered signal in the frequency domain
    z=fft(original);
    drift=sum(abs(y-z));
end

