% BPSK with a pi/4 phase shift.:

close all;
clear all;
clc;

% run loop for: minimum of n=100 bits have been run and min of 50 error
% bits detected.

SNRdB = -4:1:8 ; % run from -4 to 8 dB.
BERvalues = zeros(1,length(SNRdB));
noRunsEach = 20;

constS1 = (1./sqrt(2)) + (1i./sqrt(2));
constS2 = (-1./sqrt(2)) + (-1i./sqrt(2));

% seeds:
a = clock;
s1 = sum(a(1:6));
s2 = floor(prod(a(4:6)));
s3 = floor(prod(a(1:2)));

for i=1:length(SNRdB) 
    % for every dB of SNR we want to iterate through, we need to generate
    % and test bits through the AWGN channel until we get min of 50 errors
    % or min of 100 bits.
    
    nErrorsAvg = 0;
    
    for n=1:noRunsEach
    
        
        nBits = 0; % start at zero.
        nErrors = 0; % no errors for this SNR.

        while (nBits < 100000 && nErrors < 50000)

            % just keep going.
            % generate a new bit:
            [ randWich , s1, s2, s3 ] = WichmannHill(s1,s2,s3);
            % round for bit representation.
     
            if (randWich > 0.5)
                s = (1./sqrt(2)) + (1i./sqrt(2)); % if bit is 1 then map to top right
            else
                s = (-1./sqrt(2)) + (-1i./sqrt(2)); %
            end
            
            r =  s + (getSigma(SNRdB(i), 1) * MarsagliaBray());
            r = r + (getSigma(SNRdB(i), 1) * MarsagliaBray())*1i; % complex noise.
            % now we know we received r.
            % does the logical binary interpretation of r match that of s ?
            % now for the comparative logic:
            
            % if the delta value of S1 is smaller than delta of S2 we know
            % that it is S1.
            if ( abs( r - constS1 )^2 < abs( r - constS2)^2)
                dR = (1./sqrt(2)) + (1i./sqrt(2)); % S1
            else
                dR = (-1./sqrt(2)) + (-1i./sqrt(2)); % S2
            end
            
            if (dR ~= s)
                nErrors = nErrors + 1;
            end

            nBits = nBits + 1;


        end
        nErrorsAvg = nErrorsAvg + nErrors;
    
    end
    
    % at this point, we have a pretty good estimation of the number of
    % errors so:
    BERvalues(i) = (nErrorsAvg/ noRunsEach) / nBits;
    disp('Finished an SNR level');
    
end


BERideal=(1/2)*erfc(sqrt(10.^(SNRdB/10))); % ideal BER.
semilogy(SNRdB, BERvalues);
title('A bit-error rate curve for 45 degree phase-offset BPSK on an AWGN channel');
hold on;
semilogy(SNRdB,BERideal, '.r');
legend('Offset BPSK', 'Normal BPSK');
xlabel('SNR (in dB)');
ylabel('BER');
