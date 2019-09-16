function [energy_remain,total_energy] = EDC(x)
% EDC - Energy Decay Curve. Inputs are time series x and sampling frequency
% fs. outputs are time vector t, remaining energy vector, and total energy
% from the sound. EDC is also known as Schroeder Curve. When plotting. Take
% 10log10 of energy_remain/total_energy for dB.
% N = length(x); % number of samples in time series.
% dt = 1/fs; % time increments. 
% 
% t = ((0:N-1)*dt).'; % time vector

p = x.^2; % amplitude squared power. 

energy_remain = cumsum(p,'reverse'); % backwards integration for EDC
total_energy = sum(p); % total energy. 
