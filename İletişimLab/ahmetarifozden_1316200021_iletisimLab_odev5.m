% Parametrelerin tanımlanması
Ac = 1;
Am = 1;
fc = 200; % Hz
fm = 10; % Hz
fs = 1000; % Hz, örnekleme frekansı
t = 0:1/fs:1-1/fs; % 1 saniye süre
Kf = 50;

% Mesaj sinyali m(t)
m_t = Am * cos(2 * pi * fm * t);

% Taşıyıcı sinyal c(t)
c_t = Ac * cos(2 * pi * fc * t);

% Mesaj sinyalinin integrali
integral_m_t = cumsum(m_t) / fs;

% Frekans modüleli sinyal s_fm(t)
s_fm_t = Ac * cos(2 * pi * fc * t + Kf * integral_m_t);

% Sinyallerin çizimi
figure;

% Mesaj sinyali m(t)
subplot(3, 1, 1);
plot(t, m_t);
title('Mesaj Sinyali m(t)');
xlabel('Zaman [s]');
ylabel('Genlik');

% Taşıyıcı sinyal c(t)
subplot(3, 1, 2);
plot(t, c_t);
title('Taşıyıcı Sinyal c(t)');
xlabel('Zaman [s]');
ylabel('Genlik');

% Frekans modüleli sinyal s_fm(t)
subplot(3, 1, 3);
plot(t, s_fm_t);
title('Frekans Modüleli Sinyal s_{fm}(t)');
xlabel('Zaman [s]');
ylabel('Genlik');

% Demodülasyon işlemi
% Adım 1: Hilbert dönüşümü ile z1 elde et
z1 = hilbert(s_fm_t);

% Adım 2: exp(-j*2*pi*fc*t) ile çarparak z2 elde et
z2 = z1 .* exp(-1i * 2 * pi * fc * t);

% Adım 3: z2'nin fazını hesapla ve unwrap yap
phase_z2 = unwrap(angle(z2));

% Adım 4: Diferansiyel al ve genliği ayarla, m_hat(t) elde et
m_hat_t = diff(phase_z2) * fs / Kf;

% FFT grafikleri için frekans ekseni hazırla
n = length(t);
f = (-n/2:n/2-1)*(fs/n);

% s_fm(t) sinyalinin FFT'si
S_fm = fftshift(fft(s_fm_t));

% z1(t) sinyalinin FFT'si
Z1 = fftshift(fft(z1));

% z2(t) sinyalinin FFT'si
Z2 = fftshift(fft(z2));

% Genlik spektrumlarının çizimi
figure;

subplot(3, 1, 1);
plot(f, abs(S_fm)/n);
title('Genlik Spektrumu |S_{FM}(f)|');
xlabel('Frekans [Hz]');
ylabel('Genlik');

subplot(3, 1, 2);
plot(f, abs(Z1)/n);
title('Genlik Spektrumu |Z1(f)|');
xlabel('Frekans [Hz]');
ylabel('Genlik');

subplot(3, 1, 3);
plot(f, abs(Z2)/n);
title('Genlik Spektrumu |Z2(f)|');
xlabel('Frekans [Hz]');
ylabel('Genlik');

figure;
% Mesaj sinyali m(t) ve demodüle edilmiş sinyal m_hat(t)'nin çizimi
plot(t(1:end-1), m_t(1:end-1));
hold on;
plot(t(1:end-1), m_hat_t, '--');
title('Mesaj Sinyali m(t) ve Demodüle Edilmiş Sinyal m_{hat}(t)');
xlabel('Zaman [s]');
ylabel('Genlik');
legend('m(t)', 'm\_hat(t)');
hold off;
