data = readmatrix('../dataset/ecg_sample.csv');

% Take first ECG sample (row)
ecg = data(1, 1:end-1);  % last column is label
ecg = ecg';              % convert to column vector

% Create time axis (assume sampling frequency)
fs = 100;
t = (0:length(ecg)-1)/fs;

% Plot signal
figure
plot(t, ecg)
title('Raw ECG Signal')
xlabel('Time (s)')
ylabel('Amplitude')
