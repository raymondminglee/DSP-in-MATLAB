function [G_xy, S_xy, frequency_cg, frequency_cs] = my_CSD(signal_x, signal_y, fs)
%this is a function of getting Cross Spectral Density (CSD)
%Input of this function are two signals and fs, the output of the function are,
%single and double corss-spectrum density and their associated spectrum

[N, ~] = size(signal_x);
del_t = 1/fs;
T = (0:N-1)*del_t;
[fft_x, frequency_x] = my_fft(signal_x, fs);
[fft_y, frequency_y] = my_fft(signal_y, fs);
%conj(signal1)*signal2/ or same signal for auto 
S_xy = conj(fft_x).*fft_y./T(:,end);
frequency_cs = frequency_x;

%shift the CSD same reason as fft needed to be shift
if mod(N,2) == 0
    mid = N/2;
    G_xy = vertcat(S_xy(mid,:), S_xy(mid+1:end -1,:)*2, S_xy(end,:));
    frequency_cg = vertcat(frequency_x(mid:end,:));
else
    mid = ceil(N/2);
    G_xy = vertcat(S_xy(mid,:), S_xy(mid+1:end,:)*2);
    frequency_cg = frequency_x(mid:end, :);
end
end