close all
clear
clc


% sample size:
sample_size = 10000000; % no of numbers to generate.
samples = zeros(1,sample_size);

for i=1:sample_size
    r1 = MarsagliaBray();
    samples(i) = r1;
end

[ y,x ] = hist(samples, sample_size ./ 1000);
bar(x, y/sum(y)/(x(2)-x(1)));
hold on;

x = [-3:.1:3];
norm = normpdf(x,0,1);
plot(x,norm, 'r');

title(sprintf('Probability Distribution for the Marsaglia-Bray algorithm\nMean : %f \nVariance: %f\nStandard Deviation: %f\n', mean(samples), var(samples), std(samples)));
ylabel('Probability');
xlabel('Values');
legend('Simulated Distribution', 'Theoretical Distribution');
fprintf('Mean : %f \nVariance: %f\nStandard Deviation: %f\n', mean(samples), var(samples), std(samples));