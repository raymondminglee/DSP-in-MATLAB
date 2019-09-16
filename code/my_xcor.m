function [xcor, t_new] = my_xcor(signal1, signal2, fs)
%this is an imporved version of getting cross correlation/auto correlation
%the xcor is just simply ifft of the single cross-spectral density
[~, Sxy, ~, ~] = my_CSD(signal1, signal2, fs);
xcor = my_ifft(Sxy, fs);
[N, ~] = size(Sxy);
del_t = 1/fs;
if mod(N,2) == 0
    mid = N/2;
    xcor = vertcat(xcor(mid+2:end,:), xcor(1:mid+1,:));
    t_new = (-1*mid*del_t+del_t:del_t:mid*del_t);
else 
    mid = ceil(N/2);
    xcor = vertcat(xcor(mid+1:end,:), xcor(1:mid,:));
    t_new= (-1*mid*del_t/2+del_t/2:del_t:mid*del_t/2-del_t/2);
end
end

