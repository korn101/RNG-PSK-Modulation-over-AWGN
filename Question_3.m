close all
clear
clc


% Question 3
% BPSK

noBits = 128;
sentBits = zeros(1, noBits);
sentSymbols = zeros(1, noBits);
receivedSymbols = zeros(1, noBits);
receivedBits = zeros(1, noBits);

% generate some random bits.
% seeds:
a = clock;
s1 = sum(a(1:6));
s2 = floor(prod(a(4:6)));
s3 = floor(prod(a(1:2)));

for i=1:noBits
    [ r , s1, s2, s3 ] = WichmannHill(s1,s2,s3);
    
    sentBits(i) = (r > 0.5);
    
    % convert to symbols
    sentSymbols(i) = 2 * sentBits(i) - 1;
    
end

errors = 0;

% additive gaussian noise
for i=1:noBits
   
    receivedSymbols(i) = sentSymbols(i) + MarsagliaBray();
   
    receivedBits(i) = (receivedSymbols(i) > 0);
    if (receivedBits(i) ~= sentBits(i))
        errors = errors + 1;
    end
    
end

% display sender bits.
sentBits
sentSymbols
receivedSymbols
receivedBits
errors
BER = errors./noBits
% map bits to constellation:
% for BPSK

