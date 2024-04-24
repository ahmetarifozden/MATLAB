%% Genlik Modulasyon
clear, clc, close all;

%% Degiskenler
m = 0.9;
t = linspace(0,1,1001);
t(end) = [];
fs = 1000;
f1 = 20;
f2 = 30;
fc = 200;

% Denklemler
m_t = (2*cos(2*pi*f1*t)+5*cos(2*pi*f2*t))/5;
c = cos(2*pi*fc*t);
f_gm = m * m_t .* c + c;

%% FFT
M_fft = fft(m_t);
C_fft = fft(c);
F_fft = fft(f_gm);

f = linspace(-fs/2,fs/2,1001);
f(end) = [];

%% Cizim 1

figure;
subplot(2,2,1); 
plot(f, abs(fftshift(C_fft))/fs);
axis([-350 350 0 0.7])
grid on;
title('|C_fft|')
xlabel('Frekans [Hz]');
ylabel('Genlik');
legend('C_fft','Location','best');

subplot(2,2,2);
plot(f, abs(fftshift(M_fft))/fs);
axis([-350 350 0 0.7])
grid on;
title('|M_fft|')
xlabel('Frekans [Hz]');
ylabel('Genlik');
legend('M_fft','Location','best');

subplot(2,2,[3,4]);
plot(f, abs(fftshift(F_fft))/fs);
axis([-350 350 0 0.7])
grid on;
title('|Fgm_fft|')
xlabel('Frekans [Hz]');
ylabel('Genlik');
legend('Fgm_fft','Location','best');

%% LPF ve islemler
% diode
f_gm1 = f_gm;
f_gm1(f_gm1 < 0) = 0;
v0 = f_gm1;

n = 5;
Wn = 100/(fs/2);
[b,a] = butter(n, Wn);

v1 = filter(b, a, v0);

m_t_hat = v1 - mean(v1);

% v0_fft = fft(v0);
% v1_fft = fft(v1);
% figure;
% subplot(2,1,1);
% plot(f, abs(fftshift(v0_fft))/fs);
% subplot(2,1,1);
% plot(f, abs(fftshift(v1_fft))/fs);

%% Cizim 2

figure;
subplot(2,1,1);
plot(t, f_gm);
grid on;
title('|f_gm|')
xlabel('Zaman [s]');
ylabel('Genlik');
legend('f_gm','Location','best');

subplot(2,1,2);
plot(t, m_t);
hold on;
plot(t, m_t_hat);
grid on;
title('|m_t| ve |m_t_hat|')
xlabel('Zaman [s]');
ylabel('Genlik');
legend('m_t','m_t_hat','Location','best');

%% Cizim 3
v0_fft = fft(v0);
v1_fft = fft(v1);
m_t_fft = fft(m_t_hat);
[H, f] = freqz(b, a, 1000, fs);

figure;
subplot(2,2,1);
plot(f, abs(fftshift(v0_fft))/fs);
hold on;
plot(f, abs(H));
grid on;
title('|V0_f| ve |H_f|')
xlabel('Frekans [f]');
ylabel('Genlik');
legend('V0_f','H_f','Location','best');

subplot(2,2,2);
plot(f, abs(fftshift(v1_fft))/fs);
grid on;
title('|V1_f|')
xlabel('Frekans [f]');
ylabel('Genlik');
legend('V1_f','Location','best');

subplot(2,2,3);
plot(f, abs(fftshift(m_t_fft))/fs);
grid on;
title('|M_f|')
xlabel('Frekans [f]');
ylabel('Genlik');
legend('M_f','Location','best');
