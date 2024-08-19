clc, clear, close all;

fs= 1000;
f1= 20;
f2= 30;
fc= 200;
t = 0:0.001:0.999;

m_t = 2*cos(2*pi*f1*t) + 5*cos(2*pi*f2*t);
c_t = cos(2*pi*fc*t);

m_t_hat = imag(hilbert(m_t));
c_t_hat = imag(hilbert(c_t));

x_tyb = (m_t.*c_t) + (m_t_hat.*c_t_hat) ;



m_t_fft = fft(m_t);
c_t_fft = fft(c_t);
x_tyb_fft = fft(x_tyb);

f = linspace(-fs/2, fs/2, length(t));


figure;
subplot(2,2,1);
plot(t, abs(fftshift(c_t_fft)/length(c_t_fft)));
title('c t fft');
xlabel('F (Hz)');
ylabel('Gen');
grid on;

subplot(2,2,2);
plot(t, abs(fftshift(m_t_fft)/length(m_t_fft)));
title('m t fft');
xlabel('F (Hz)');
ylabel('Gen');
grid on;

subplot(2,2,3);
plot(t, abs(fftshift(x_tyb_fft)/length(x_tyb_fft)));
title('x tyb fft');
xlabel('F (Hz)');
ylabel('Gen');
grid on;

figure;
subplot(2,1,1);
plot(t, x_tyb);
title('x tyb');
xlabel('F (Hz)');
ylabel('Gen');
grid on;


d = x_tyb .* c_t ;
d_fft = fft(d);

n=5;
WN= 100/(fs/2);
[b,a] = butter(n,WN);
[H,f] = freqz(b,a,'whole',1000,fs);

figure;
subplot(2,2,1);
plot(f, abs(fftshift(d_fft))/length(d_fft));
hold on;
plot(f, abs(fftshift(H)),'r');
title('d and Hf');
xlabel('F (Hz)');
ylabel('Gen');
legend('d','HF');
grid on;


y= filter(b,a,d);
y_fft= fft(y);


subplot (2,2,2)
plot(f, abs(fftshift(y_fft))/fs);
hold on;
plot(f, abs(fftshift(m_t_fft)), 'r');
title('y ve m');
xlabel('F (Hz)');
ylabel('Gen');
legend('y', 'm');
grid on;

subplot (2,2,3)
plot(t,m_t);
hold on;
plot(t, y*2);
title('m ve y');
xlabel('Zaman (t)');
ylabel('Gen');
legend('m','y');
grid on;