clc, clear, close all;

fs=500;
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
axis([-250 250 0 1])

% % BPF filtre
% wn=[50 150]/(fs/2);
% n=3;
% [b2,a2] = butter(n,wn)
% 
% [H1,~] = freqz(b2,a2,fs,'whole');
% 
% hold on
% plot(f,abs(fftshift(H1)),'k');
% 
% y = filter(b, a, s4);
% 
% z = y.*s2;
% % LPF filtre
% wn=50/(fs/2);
% n = 2;
% [b1,a1] = butter(n,wn)
% 
% [H2,~] = freqz(b1,a1,fs,'whole');
% 
% hold on
% plot(f,abs(fftshift(H2)),'r');

%% bandpass filter
n1 = 3;
Wn1 = [50 150]/(fs/2);
[b1,a1] = butter(n1,Wn1);

rsltn = 100;
[H1,~] = freqz(b1,a1, rsltn, fs,'whole');

hold on;
plot(f,abs(fftshift(H1)), 'r');
grid on;
title('|bandpass|')
xlabel('Frekans [Hz]');
ylabel('Genlik');
legend('bps_hat', 's','Location','best');

bps_hat = filter(b1, a1, s);

bps_hat1 = bps_hat.*s2 *2;

%% Lowpass filter
n2 = 2;
Wn2 = 50/(fs/2);

[b2,a2] = butter(n2, Wn2);

lws_hat2 = filter(b2, a2, bps_hat1);

%% dc cikarma
dcs_hat3 = lws_hat2 - mean(lws_hat2);

figure;
plot(t,dcs_hat3,t,s1);
grid on;
title('dcs_hat3 ve s_1 karsilastirma')
xlabel('Zaman(t) [s]');
ylabel('Genlik');
legend('dcs_hat3', 's_1','Location','best');



