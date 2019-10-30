function [C, frequency, t] = my_Spect(signal, fs, rec_length, overlap)
%rec_length in sec
%overlap, in percent/100
delt = 1/fs;
N = length(signal);
t = (0:N-1)*delt; t = t';
n = rec_length/delt;% length of each chunk in samples
bin_size = floor(rec_length/delt);
n_chunk = N/(n-overlap*n); %number of small chunks resulting
for i = 1:1:n_chunk
    signal_clip = signal((i-1)*bin_size-(i-1)*overlap*bin_size+1:i*bin_size-(i-1)*overlap*bin_size, :);
    [G_xx, ~, frequency_g, ~] =  my_PSD(signal_clip, fs);
    G_all(:, i) = G_xx;
    if (i+1)*bin_size-(i)*overlap*bin_size > N
        break
    end
end
C = G_all;
frequency = frequency_g;
imagesc(t, frequency, 10*log10(C/max(max(C))))
xlabel('Time(s)')
ylabel('Frequency(Hz)')
set(gca,'YDir','normal')
colormap jet
colorbar
end