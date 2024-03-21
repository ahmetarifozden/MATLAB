clc,clear, close all;

fs=10000;
wp=[2000 3000]/(fs/2);
ws=[1500 3500]/(fs/2);
Rp=3;
% Rs=?  n=2
% [n,Wn] = buttord(Wp,Ws,Rp,Rs)
% [b,a] = butter(n,Wn)
% [b,a] = butter(n,Wn,ftype)
Rs=20;

[n,Wn] = buttord(wp,ws,Rp,Rs);
[b,a] = butter(n,Wn)

% [H,w] = freqz(b,a,n)
% [H,f] = freqz(b,a,n,fs)
% [H,w] = freqz(b,a,n,'whole')
% [H,f] = freqz(b,a,n,fs,'whole')
rsltn=5000;
[H,f] = freqz(b,a,rsltn,fs);

figure
subplot 211
plot(f,abs(H));
subplot 212
plot(f,angle(H));

% figure
% plot(f,phase(H));

% figure
% semilogy(f,abs(H));

figure
plot(f,20*log10(abs(H)));

figure
zplane(b,a)
