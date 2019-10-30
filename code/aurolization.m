function output = aurolization(music, IR, fs)
dt = 1/fs;
% shoulde be same length to performe aurolization
z_com = zeros(length(music)-length(IR), 1);
% add some decay at the very end
decay = zeros(88200, 1);
IR = vertcat(IR, z_com);
IR = vertcat(IR, decay);
music = vertcat(music, decay);
[IR_fft, f] = my_fft(IR, fs);
[sound_fft, f] = my_fft(music, fs);
output_fft = IR_fft.*sound_fft;
output = my_ifft(output_fft, fs);