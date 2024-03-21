clc, clear, close all;

fm=10;
faz=pi/2;
fs=10*fm;
ts=1/fs;
t=0:ts:1-ts;
s1=cos(2*pi*fm*t);
s2=cos(2*pi*fm*t + faz);

S1=fft(s1);

S2=fft(s2);

% f=0:fs-1;
% figure
% subplot 211
% plot(f,abs(S1)/fs)
% subplot 212
% plot(f,angle(S1))


f=-fs/2:fs/2;
f(end)=[];
figure
plot 211
plot(f,abs(fftshift(S2))/fs)




