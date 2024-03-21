clc, clear, close all;

f1=20;
f2=100;
fs=500;
ts=1/fs;
t=0:1/fs:1-(1/fs);
s1=sin(2*pi*20*t);
s2=sin(2*pi*100*t);
s3 = s1.*s2;
s4 = s3+s2;

S=fft(s4);

f=-fs/2:fs/2;
f(end)=[];
figure
plot(f,abs(fftshift(S))/fs)
axis([-100 100 0 1])

% BPF filtre
wn=[50 150]/(fs/2);
n=3;
[b2,a2] = butter(n,wn)

[H1,~] = freqz(b2,a2,fs,'whole');

hold on
plot(f,abs(fftshift(H1)),'k');

y = filter(b, a, s4);

z = y.*s2;
% LPF filtre
wn=50/(fs/2);
n = 2;
[b1,a1] = butter(n,wn)

[H2,~] = freqz(b1,a1,fs,'whole');

hold on
plot(f,abs(fftshift(H2)),'r');




