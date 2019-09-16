function [ifft_result] = my_ifft(signal_fft, fs)
%This is a imrpoved version of MATLAB's ifft function
%the input of this function is (signal_fft, fs), signal_fft is the result
%of function my_fft(signal, fs)
%output of the function is the reconstructed signal
[N, ~] = size(signal_fft);
del_t = 1/fs;
del_f = fs/N;
%the fft should first be shifted back to range od 0 to fs
if mod(N,2) == 0
    mid = N/2;
    unshift = vertcat(signal_fft(mid:end,:), signal_fft(1:mid-1,:));
    ifft_result = ifft(unshift/del_t);
else
    mid = ceil(N/2);
    unshift = vertcat(signal_fft(mid:end,:), signal_fft(1:mid-1,:));
    ifft_result = ifft(unshift/del_t);
end

    
end
