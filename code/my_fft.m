function [real_fft, frequency] = my_fft(signal, fs)
%This is a imrpoved version of MATLAB's fft function
%the imput of this function is (signal, fs)
%output of the function is its fft, after shifted to the -fs/2 to fs/2
%range
[N, ~] = size(signal);
del_t = 1/fs;
del_f = fs/N;
fft_raw = fft(signal);
if mod(N,2) == 0
    mid = N/2;
    real_fft = vertcat(fft_raw(mid+2:end,:), fft_raw(1:mid+1,:));
    real_fft = real_fft*del_t;
    frequency = [-fs/2+del_f:del_f:fs/2]';
else 
    mid = ceil(N/2);
    real_fft = vertcat(fft_raw(mid+1:end,:), fft_raw(1:mid,:));
    real_fft = real_fft*del_t;
    frequency = [-fs/2+del_f/2:del_f:fs/2-del_f/2]';
end

end




