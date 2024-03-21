clc,clear, close all;

fs=10000;
wp=2000/(fs/2);
ws=1500/(fs/2);
Rp=3;
Rs=25;

% [n,Wn] = buttord(Wp,Ws,Rp,Rs)



[n,Wp] = cheb1ord(wp,ws,Rp,Rs)
[b,a] = cheby1(n,Rp,Wp,'high');

[n2,Ws] = cheb2ord(wp,ws,Rp,Rs)
[b2,a2] = cheby2(n2,Rs,Ws,'high');


% [H,w] = freqz(b,a,n)
% [H,f] = freqz(b,a,n,fs)
% [H,w] = freqz(b,a,n,'whole')
% [H,f] = freqz(b,a,n,fs,'whole')
rsltn=500;
[H,f] = freqz(b,a,rsltn,fs);
[H2,f] = freqz(b2,a2,rsltn,fs);

figure
subplot 211
plot(f,abs(H));
subplot 212
plot(f,angle(H));

figure
subplot 211
plot(f,abs(H2));
subplot 212
plot(f,angle(H2));






