function [G_xx_avg, frequency] = my_PSDavg(signal, fs, n_avg, type, signal_true)
%this function is to compute average PSD, n_avg is the number of record to
%split fot a signal. type takes in one of the three method of avgeraging.
%RMS, Linear, or Time. For linear and time avaeraging, in order to aloow
%for synchronous averaging, signal_true has to be provided,
if nargin == 4
    signal_true = [];
end

switch type
    case 'RMS'  %divide the recording, compute G_xx and then acerage the G_xx
        N = length(signal);
        bin_size = floor(N/n_avg); %this is to sample of each individual record. Soem sample at the end might be droped
        
        for i = 1:1:n_avg
            signal_ind = signal((i-1)*bin_size+1:i*bin_size); %individual recording
            [G_xx, ~, frequency_g, ~] = my_PSD(signal_ind, fs);
            G_xx_ind(:, i) = G_xx; 
        end
        
         G_xx_avg = mean(G_xx_ind, 2);
         frequency = frequency_g;
         
    case 'Linear' %divide the recording, compute fft and then average the fft, compute final G_xx
        N = length(signal);
        N2 = length(signal_true);
        del_t = 1/fs;
        n_avg = floor(N/N2); %how amny actual audio clip in one averaging clip 
        bin_size = N2; %each individual record of the clip should be interger multiplication of the actual signal (synchronous)
        
        for i = 1:1:n_avg
            signal_clip(:,i) = signal((i-1)*bin_size+1:i*bin_size, :);
        end

        for i = 1:1:n_avg
            [fft(:,i), frequency_ind(:,i)] = my_fft(signal_clip(:,i), fs);
        end
        
        fft_mean = mean(fft, 2); %since it is fft, cant use my_PSD, rewrite the psd function here
        T = (0:bin_size-1)*del_t;
        S_xx = abs(fft_mean).^2./T(:,end);
        
        if mod(bin_size,2) == 0
            mid = bin_size/2;
            G_xx = vertcat(S_xx(mid,:), S_xx(mid+1:end -1,:)*2, S_xx(end,:));
            frequency_g = vertcat(frequency_ind(mid:end,1));
        else
            mid = ceil(bin_size/2);
            G_xx = vertcat(S_xx(mid,:), S_xx(mid+1:end,:)*2);
            frequency_g = frequency_ind(mid:end, 1);
        end
        
        G_xx_avg = G_xx;
        frequency = frequency_g;
        
    case 'Time' %divide the recording, average the recodings and then compute final G_xx
        N = length(signal);
        N2 = length(signal_true);
        n_avg = floor(N/N2); %how amny actual audio clip in one averaging clip 
        bin_size = N2;
        
        for i = 1:1:n_avg
            signal_clip(:,i) = signal((i-1)*bin_size+1:i*bin_size, :);
        end
        
        signal_avg = mean(signal_clip, 2);
        [G_xx, ~, frequency_g, ~] = my_PSD(signal_avg, fs);
        G_xx_avg = G_xx;
        frequency = frequency_g;
end
end

        
