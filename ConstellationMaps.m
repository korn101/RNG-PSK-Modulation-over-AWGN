sC = [ 1 -1 ];
plot(real(sC), imag(sC), 'o');
hold on
s = [(1./sqrt(2)) + (1i./sqrt(2)) (-1./sqrt(2)) + (-1i./sqrt(2))];
plot(real(s), imag(s), 'ro');
axis([-2 2 -2 2]);


legend('Conventional BPSK', 'Offset BPSK');
xlabel('Real');
ylabel('Imag');
title('Constellation map of Conventional BPSK and Phase-shift offset BPSK');
grid on;