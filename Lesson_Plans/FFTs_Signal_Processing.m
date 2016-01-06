%% FFTs and Signal Processing.

%% Load and plot data.
load electricity
figure
plot(dates, price)
xlabel('Date')
ylabel('Price ($0.01/kWH)')
title('Electricity Prices')
grid

figure
plot(dates, usage)
xlabel('Date')
ylabel('Usage (MWH)')
title('Electricity Usage')
grid

%% Basic time-series analysis: trend estimation.
% Trends can be estimated using moving averages.
nPts = 5;
w = ones(nPts, 1)/nPts;
priceTrend = conv(price, w, 'same');
figure(1)
hold on
plot(dates, priceTrend, 'r', 'LineWidth', 1.5)
% Note that CONV uses points from either side (forwards and backwards).
% On the other hand, FILTER uses only previous data points.
priceTrend2 = filter(w, 1, price);
plot(dates, priceTrend2, 'g', 'LineWidth', 1.5)
% With FILTER, we incur a large ramp-up artefact. Consider using FILTFILT
% to process the data in the backwards and forwards directions, resulting
% in zero phase distortion.
priceTrend3 = filtfilt(w, 1, price);
plot(dates, priceTrend3, 'm', 'LineWidth', 1.5)
legend('Price Data', 'CONV', 'FILTER', 'FILTFILT')

%% Stable periodic filtering.
monthlyMeanPrice = mean(reshape(price, 12, []), 2);
stableTrend = repmat(monthlyMeanPrice, numel(price)/12, 1);
figure
subplot(2, 1, 1)
plot(dates, price)
hold on
plot(dates, stableTrend, 'r')
xlabel('Date')
ylabel('Price ($0.01/kWH)')
title('Electricity Prices')
legend('Price Data', 'Stable Trend', 'Location', 'northwest')
grid

subplot(2, 1, 2)
deseasPrice = price - stableTrend;
plot(dates, deseasPrice)
xlabel('Date')
ylabel('Detrended prices')
title('Detrended Price Series')
grid

%% Estimate the long-term smooth trend.
nPts = 13;
w = ones(nPts, 1)/nPts;
longTrend = conv(deseasPrice, w, 'same');
hold on
plot(dates, longTrend, 'r', 'LineWidth', 1.5)
legend('Deseasonalised Prices', 'Long-Term Trend')

%% Subtract it.
m = (nPts-1)/2;
longTrend([1:m, end-m+1:end]) = NaN;
irregularComponent = deseasPrice - longTrend;
figure
plot(dates, irregularComponent)
xlabel('Date')
ylabel('Amplitude')
title('Irregular Price Series Component')
grid

%% Summarise the time-series decomposition.
figure
subplot(3, 1, 1)
plot(dates, stableTrend, 'r', 'LineWidth', 1.5)
xlabel('Date')
title('Stable Trend')
grid

subplot(3, 1, 2)
plot(dates, longTrend, 'b', 'LineWidth', 1.5)
xlabel('Date')
title('Long-Term Trend')
grid

subplot(3, 1, 3)
plot(dates, irregularComponent, 'm', 'LineWidth', 1.5)
xlabel('Date')
title('Irregular Component')
grid

%% FFTs.
% Suppose we wish to discover the unknown frequency components of the time
% series. We start by detrending the electricity usage series.
usageDetrend = detrend(usage); % Subtracts the line of best-fit.
figure
subplot(2, 1, 1)
plot(dates, usage)
xlabel('Date')
ylabel('Usage (MWH)')
title('Electricity Usage')
grid

subplot(2, 1, 2)
plot(dates, usageDetrend)
xlabel('Date')
ylabel('Amplitude')
title('Linearly Detrended Usage Series')
grid

% We work with the detrended series for the FFT analysis.
Y = fft(usageDetrend);
nSamples = numel(Y);
fs = 1; % One sample per month.
freq = (0:n-1)*(fs/n); % Frequency vector.
P = Y .* conj(Y) / nSamples; % Power vector.
m = floor(nSamples/2); % Half-way point.








%% Windowing.

%% Zero padding.