%% Improving Performance and Parallel for-Loops.

%% Load and plot the data.
load US_Births_1978
figure
plot(T.Date, T.Births, 'LineWidth', 1)
xlabel('Date')
ylabel('Number of Births')
title('US Births, 1978')
grid

%% Test the simulation code.
groupSize = 30;
numTrials = 1e3;
birthDist = T.Births / sum(T.Births);
matchProb = runBirthdaySim(groupSize, numTrials, birthDist);
fprintf('Match probability: %.4f\n', matchProb);

%% Measure the existing (sequential) performance.
f = @() runBirthdaySim(groupSize, numTrials, birthDist);
tSeq = timeit(f);
fprintf('Sequential execution time (s): %.4f\n', tSeq);

%% Run the simulation in parallel.
tic
matchProb = runBirthdaySimPar(groupSize, numTrials, birthDist);
tPar = toc;
fprintf('Parallel execution time (s): %.4f\n', tPar);

%% Compute speedup.
speedup = tSeq/tPar;
fprintf('Speedup: %.4f\n', speedup);





