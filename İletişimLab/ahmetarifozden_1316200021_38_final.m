clear; clc; close all;
pkg load signal

fcx = 200; % Taşıyıcı frekansı x (Hz)
fcy = 400; % Taşıyıcı frekansı y (Hz)
fx = 30; % Modüle edici sinyal frekansı x (Hz)
fy = 30; % Modüle edici sinyal frekansı y (Hz)
Ac = 1;  % Taşıyıcı sinyal genliği
Am = 1;  % Modüle edici sinyal genliği
kf = 30;  % Frekans modülasyon indeksi

fs = 4000;  % Örnekleme frekansı (Hz)
ts = 1/fs;
t = 0:ts:1-ts;  % Zaman vektörü


x = 10*cos(2*100*fx*t)+5*cos(2*pi*250*t)+8*cos(2*pi*500*t); % Modüle edici sinyal (cosine)
y = cos(2*pi*1000*t); % Modüle edici sinyal (sine)
m = Ac*cos(2*pi*fcx*t + kf*cumsum(x)*ts); % Frekans modüle edilmiş sinyal (cosine)
n = Ac*cos(2*pi*fcy*t + kf*cumsum(y)*ts);  % Frekans modüle edilmiş sinyal (sine)
z=m+n;

X=fftshift(fft(x));
Y=fftshift(fft(y));
M=fftshift(fft(m));   #Fourier Dönüşümleri
N=fftshift(fft(n));
Z=fftshift(fft(z));
w=linspace(-fs/2,fs/2,length(X)+1);
w(end)=[];

figure
subplot (1,5,1)
plot(w,abs(X))
title('X_f');
xlabel('F[Hz]');
ylabel('Genlik');
grid on;

subplot (1,5,2)
plot(w,abs(Y))
title('Y_f');
xlabel('F[Hz]');
ylabel('Genlik');
grid on;

subplot (1,5,3)
plot(w,abs(M))
title('M_f');
xlabel('F[Hz]');
ylabel('Genlik');
grid on;

subplot (1,5,4)
plot(w,abs(N))
title('N_f');
xlabel('F[Hz]');
ylabel('Genlik');
grid on;

subplot (1,5,5)
plot(w,abs(Z))
title('Z_f');
xlabel('F[Hz]');
ylabel('Genlik');
grid on;

#Butterworth Filtre Tasarımı
n=11; % Filtre derecesi
Wn1=280/(fs/2); % Normalleştirilmiş kesim frekansı (280 Hz)
[b1,a1] = butter(n,Wn1); % Butterworth filtresi tasarımı
[H1 w1] = freqz(b1,a1,length(Z),'whole'); % Frekans tepkisi hesaplama
H1=fftshift(H1); % Frekans tepkisini merkezlemek

figure
plot(w,abs(Z)/length(Z)) % Z sinyalinin normalize edilmiş spektrumu
hold on
plot(w,abs(H1)) % Filtrenin frekans tepkisi
title('|Z_f| ve |H1|');
xlabel('Frekans [Hz]');
ylabel('Genlik');
grid on;
legend('|Z_f|', '|H1|', 'Location', 'northeast');

#Butterworth Filtre Tasarımı
n=13; % Filtre derecesi
Wn2=320/(fs/2); % Normalleştirilmiş kesim frekansı (320 Hz)
[b2,a2] = butter(n,Wn2,'high'); % Yüksek geçiren Butterworth filtresi tasarımı
[H2 w2] = freqz(b2,a2,length(Z),'whole'); % Frekans tepkisi hesaplama
H2=fftshift(H2); % Frekans tepkisini merkezlemek

figure
plot(w,abs(Z)/length(Z)) % Z sinyalinin normalize edilmiş spektrumu
hold on
plot(w,abs(H2))  % Filtrenin frekans tepkisi
title('|Z_f| ve |H2|');
xlabel('Frekans [Hz]');
ylabel('Genlik');
grid on;
legend('|Z_f|', '|H2|', 'Location', 'northeast');


k=filter(b1,a1,z);
l=filter(b2,a2,z);


K=fftshift(fft(k));
L=fftshift(fft(l));

figure
subplot (1,2,1)
plot(w,abs(K))
title('K_f');
xlabel('F[Hz]');
ylabel('Genlik');
grid on;

subplot (1,2,2)
plot(w,abs(L))
title('L_f');
xlabel('F[Hz]');
ylabel('Genlik');
grid on;


zk1= hilbert(k);
zk2 = zk1.*exp(-1i*2*pi*fcx*t);

zl1= hilbert(l);
zl2 = zl1.*exp(-1i*2*pi*fcy*t);


faz1=unwrap(angle(zk2));
faz2=unwrap(angle(zl2));



x_hat=(1/kf) * diff(faz1)/ts;
y_hat=(1/kf) * diff(faz2)/ts;


figure
plot(t,x,t(1:end-1),x_hat,'r')
title('|x_t| ve |x_hat_t|');
xlabel('Zaman [s]');
ylabel('Genlik');
grid on;
legend('|x_t|', '|x_hat_t|', 'Location', 'northeast');

figure
plot(t,y,t(1:end-1),y_hat,'r')
title('|y_t| ve |y_hat_t|');
xlabel('Zaman [s]');
ylabel('Genlik');
grid on;
legend('|y_t|', '|y_hat_t|', 'Location', 'northeast');




