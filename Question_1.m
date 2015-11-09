close all
clear
clc

% sample size:
sample_size = 1000000; % no of numbers to generate.
samples = zeros(1,sample_size);

a = clock;

s1 = sum(a(1:6));
s2 = floor(prod(a(4:6)));
s3 = floor(prod(a(1:2)));


for i=1:sample_size
    [ r , s1, s2, s3 ] = WichmannHill(s1,s2,s3);
    samples(i) = r;
end

[y,x] = hist(samples, 100);
bar(x, y/sum(y)/(x(2)-x(1)));
hold on;

% Create three distribution objects with different parameters
pd1 = makedist('Uniform');

% Compute the pdfs
x = -0.5:.01:1.5;
pdf1 = pdf(pd1,x);

stairs(x,pdf1,'r','LineWidth',2);
ylim([0 1.1]);
hold off;

title(sprintf('Probability Distribution for the Wichmann-Hill algorithm\nMean : %f \nVariance: %f\nStandard Deviation: %f\n', mean(samples), var(samples), std(samples)));
ylabel('Probability');
xlabel('Values');

legend('Simulated Distribution', 'Theoretical Distribution');

fprintf('Mean : %f \nVariance: %f\nStandard Deviation: %f\n', mean(samples), var(samples), std(samples));