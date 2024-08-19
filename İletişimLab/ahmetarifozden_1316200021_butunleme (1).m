clc, clear, close all;
pkg load signal;

fs = 1000;
f1 = 40;
f2 = 100;
f3 = 200;
f4 = 10;
t = 0:1/fs:1
t(end)= [];
f = linspace(-fs/2, fs/2, length(t));


s1_t = sin(2.* pi.* f1.* t);
s2_t = sin(2 .*pi .*f2 .* t);
s3_t = sin(2 .*pi .* f3 .*t);
s4_t = sin(2 .*pi .* f4 .*t);

%s_12_t = s1_t + s2_t;
s_34_t = s3_t .* s4_t;

r_t = s1_t + s2_t + s_34_t;
r_f = fft(r_t);



% LPF filitresi

n1 = 15;  % derecesini belirtir
wn1 = 120/(fs/2);
[b1, a1] = butter(n1, wn1);
[H1,~] = freqz(b1, a1, fs,'whole');

r_lpt = filter(b1,a1,r_t);

r_lpf = fft(r_lpt);


figure
subplot(4,1,1);
plot(f,abs(fftshift(r_lpf)));
title('R(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,2);
plot(f,abs(fftshift(r_f)/fs));%fs ye bölmeye unutma normalizasyon demek
hold on;
plot(f,abs(fftshift(H1)));
title('R(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,3);
plot(f,abs(fftshift(r_lpf)));
title('Y(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');

% HPF filitresi

n2 = 15;  % derecesini belirtir
wn2 = [150 250]/(fs/2);
[b2, a2] = butter(n2, wn2);
[H2,~] = freqz(b2, a2, fs,'whole');

r_hpt = filter(b2,a2,r_t);

r_hpf = fft(r_hpt);

figure
subplot(4,1,1);
plot(f,abs(fftshift(r_f)));
title('R(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,2);
plot(f,abs(fftshift(r_f)/fs));%fs ye bölmeye unutma normalizasyon demek
hold on;
plot(f,abs(fftshift(H2)));
title('R(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,3);
plot(f,abs(fftshift(r_hpf)));
title('Y(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');


% BP Filter

n3 = 15;  % derecesini belirtir
wn3 = 250 / (fs/2);
[b3, a3] = butter(n3, wn3);
[H3,~] = freqz(b3, a3, fs,'whole');

r_bpt = filter(b3,a3,r_t);

r_bpf = fft(r_bpt);

figure
subplot(4,1,1);
plot(f,abs(fftshift(r_f)));
title('R(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,2);
plot(f,abs(fftshift(r_bpf)/fs));%fs ye bölmeye unutma normalizasyon demek
hold on;
plot(f,abs(fftshift(H3)));
title('R(f)');
xlabel('Frekans(Hz)');
ylabel('Genlik');


% a şıkkı

figure
subplot(4,1,1);
plot(t,r_t);
axis([0.4 0.5 ]);
title('r_t');
xlabel('Zaman(sn)');
ylabel('Genlik');

subplot(4,1,2);
plot(t,r_hpt);
axis([0.4 0.5 ]);
title('r_hpt');
xlabel('Zaman(sn)');
ylabel('Genlik');

subplot(4,1,3);
plot(t,r_lpt);
axis([0.4 0.5 ]);
title('r_lpt');
xlabel('Zaman(sn)');
ylabel('Genlik');

subplot(4,1,4);
plot(t,r_bpt);
axis([0.4 0.5 ]);
title('r_bpt');
xlabel('Zaman(sn)');
ylabel('Genlik');

% b şıkkı

figure

subplot(4,1,1);
plot(f,abs(fftshift(r_f)));
title('r_f');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,2);
plot(f,abs(fftshift(r_hpf)));
title('r_hpf');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,3);
plot(f,abs(fftshift(r_lpf)));
title('r_lpf');
xlabel('Frekans(Hz)');
ylabel('Genlik');

subplot(4,1,4);
plot(f,abs(fftshift(r_bpf)));
title('r_bpf');
xlabel('Frekans(Hz)');
ylabel('Genlik');











