function [G_xx, S_xx, frequency_g, frequency_s] = my_PSD(signal, fs)
%this is an improved version of MATLAB's PSD
%Input of this function are signal and fs, the output of the function are,
%single and double power pectrum density and their associated spectrum

[N ~] = size(signal);
del_t = 1/fs;
T = (0:N-1)*del_t;
[fft, frequency] = my_fft(signal, fs);
%the double PSD can be calsulated by, where T(:, end) indicate the suration
%of the signal 
S_xx = abs(fft).^2./T(:,end);
frequency_s = frequency;

%for single PSD, we have to 'fold' it back together wrt. 0 frequency
if mod(N,2) == 0
    mid = N/2;
    G_xx = vertcat(S_xx(mid,:), S_xx(mid+1:end -1,:)*2, S_xx(end,:));
    frequency_g = vertcat(frequency(mid:end,:));
else
    mid = ceil(N/2);
    G_xx = vertcat(S_xx(mid,:), S_xx(mid+1:end,:)*2);
    frequency_g = frequency(mid:end, :);
end
end


