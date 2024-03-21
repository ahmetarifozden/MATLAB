clc, clear, close all;

fm1=15;
fm2=60;
faz=pi/2;
fs=500;
ts=1/fs;
t=0:ts:1-ts;
s1=2*cos(2*pi*fm1*t);
s2=cos(2*pi*fm2*t);

s = s1+s2;

S1=fft(s);

f=-fs/2:fs/2;
f(end)=[];
figure
plot(f,abs(fftshift(S1))/fs)

%%Filtre tasarımı


%LPF filtre
wp=20/(fs/2);
ws=50/(fs/2);
Rp=1; %3 .3
Rs=80;

[n,Wn] = buttord(wp,ws,Rp,Rs);
[b,a] = butter(n,Wn);

% [H,w] = freqz(b,a,n)
% [H,f] = freqz(b,a,n,fs)
% [H,w] = freqz(b,a,n,'whole')
% [H,f] = freqz(b,a,n,fs,'whole')

[H,f] = freqz(b,a,fs,'whole');

figure
plot(f,abs(H));

hold on
plot(f,abs(fftshift(H)),'k');


%BPF filtre
wp=[50 70]/(fs/2);
ws=[20 100]/(fs/2);
Rp=3; %3 .3
Rs=80;

[n,Wn] = buttord(wp,ws,Rp,Rs);
[b2,a2] = butter(n,Wn);

% [H,w] = freqz(b,a,n)
% [H,f] = freqz(b,a,n,fs)
% [H,w] = freqz(b,a,n,'whole')
% [H,f] = freqz(b,a,n,fs,'whole')

[H,~] = freqz(b,a,fs,'whole');

figure
plot(f,abs(H2));

hold on
plot(f,abs(fftshift(H2)),'k');









