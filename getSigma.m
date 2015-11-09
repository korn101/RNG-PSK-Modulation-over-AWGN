function [ outputS ] = getSigma( SNR , fbit )
    % SNR in dB
    % fbit for BPSK (=1) or QPSK (=2)

    outputS = 1 ./ sqrt(power(10, SNR./10) * 2 * fbit);


end

