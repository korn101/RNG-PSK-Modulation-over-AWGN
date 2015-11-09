% question 3 BOTH:

close all;
clear all;
clc;

% run loop for: minimum of n=100 bits have been run and min of 50 error
% bits detected.

SNRdB = -4:1:8 ; % run from -4 to 8 dB.
BERvalues = zeros(1,length(SNRdB));
noRunsEach = 2;

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
            s = 2 * (randWich > 0.5) - 1; % transmitted symbol.
            r =  s + (getSigma(SNRdB(i), 1) * MarsagliaBray());
            % now we know we received r.
            % does the logical binary interpretation of r match that of s ?

            if ( ((s+1)/2) ~= (r > 0) )
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
title('A bit-error rate curve for BPSK and QPSK on an AWGN channel');
hold on;



% QPSK part:

% question 3:
%%%%%%%%
% QPSK %
%%%%%%%%

% run loop for: minimum of n=100 bits have been run and min of 50 error
% bits detected.

SNRdB = -4:1:8 ; % run from -4 to 8 dB.
BERvalues = zeros(1,length(SNRdB));
noRunsEach = 2;

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
            % generate two symbol components (Quadrature and In-phase)
            [ randWich1 , s1, s2, s3 ] = WichmannHill(s1,s2,s3);
            [ randWich2 , s1, s2, s3 ] = WichmannHill(s1,s2,s3);
            % now map these double digits to their const maps:
            
            sR = 2 * (randWich1 > 0.5) - 1;
            sI = 2 * (randWich2 > 0.5) - 1;
            
            % add noise, NOTICE fbit changes.
            r =  sR + sI*1i + (getSigma(SNRdB(i), 1) * MarsagliaBray());
            r = r + (getSigma(SNRdB(i), 1) * MarsagliaBray())*1i; % add complex noise.
            
            % demodulate:
            dR = (sign(real(r))+1)/2; % sign function divides component by mag.
            dI = (sign(imag(r))+1)/2; % and convert to binary rep.
            
            % dR and dI now hold the demodulated components of the sent
            % signal sR and sI after AWGN.
            % does the logical binary interpretation of r match that of s ?

            if ( ((sR+1)/2) ~= (dR > 0) )
                nErrors = nErrors + 1;
            end
            
            if ( ((sI+1)/2) ~= (dI > 0) )
                nErrors = nErrors + 1;
            end

            nBits = nBits + 2;


        end
        nErrorsAvg = nErrorsAvg + nErrors;
    
    end
    
    % at this point, we have a pretty good estimation of the number of
    % errors so:
    BERvalues(i) = (nErrorsAvg/ noRunsEach) / nBits;
    disp('Finished an SNR level');
    
end

%BERideal=(1/2)*erfc(sqrt(10.^(SNRdB/10))); % ideal BER.
semilogy(SNRdB, BERvalues, 'g');
%title('A bit-error rate curve for QPSK on an AWGN channel');
%hold on;
semilogy(SNRdB,BERideal, '.r');
%legend('Simulation', 'Theoretical');
legend('BPSK', 'QPSK', 'Theoretical Ideal');
xlabel('SNR (in dB)');
ylabel('BER');
