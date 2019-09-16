function [gamma_sq, frequency] = my_coh(signal_1, signal_2, fs, n_avg)
N = length(signal_1);
bin_size = floor(N/n_avg); %this is to sample of each individual record. Soem sample at the end might be droped        
for i = 1:1:n_avg
signal_1_ind = signal_1((i-1)*bin_size+1:i*bin_size);%individual recording
signal_2_ind = signal_2((i-1)*bin_size+1:i*bin_size);%individual recording

[G_xy, ~, frequency, ~] = my_CSD(signal_1_ind, signal_2_ind, fs);
[G_xx, ~, ~, ~] = my_CSD(signal_1_ind, signal_1_ind, fs);
[G_yy, ~, ~, ~] = my_CSD(signal_2_ind, signal_2_ind, fs);

G_xy_ind(:, i) = G_xy;
G_xx_ind(:, i)= G_xx;
G_yy_ind(:, i)= G_yy;

end

G_xy_avg = mean(G_xy_ind, 2);      
G_xx_avg = mean(G_xx_ind, 2);
G_yy_avg = mean(G_yy_ind, 2);

gamma_sq = ((conj(G_xy_avg).*G_xy_avg)./(G_xx_avg.*G_yy_avg));
end

