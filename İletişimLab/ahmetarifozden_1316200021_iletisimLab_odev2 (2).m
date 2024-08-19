clear, clc, close all;

fs = 500; 
t=0:1/fs:0.2;
t(end)= [];

s1 = sin(2*pi*20*t);
s2 = sin(2*pi*100*t);

s = s1.*s2;
s = s + s2;

S_fft = fft(s); 

f = linspace(-fs/2,fs/2,101);
f(end) = [];

figure;
plot(f, abs(fftshift(S_fft))/fs)
axis([-250 250 0 1])
grid on;


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