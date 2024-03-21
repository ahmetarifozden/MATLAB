clc, clear, close all;

f1=15;
f2=60;
fs=1000;
ts=1/fs;
t=0:ts:1-ts;
s1=2*cos(2*pi*f1*t);
s2=cos(2*pi*f2*t);
s = s1+s2;

S=fft(s);


f=-fs/2:fs/2;
f(end)=[];
figure
plot(f,abs(fftshift(S))/fs)
axis([-100 100 0 1])

%% Filtre tasarımı

% LPF filtre
wp=20/(fs/2);
ws=50/(fs/2);
Rp=1;
Rs=80;
[n,Wn] = buttord(wp,ws,Rp,Rs);
[b1,a1] = butter(n,Wn)

[H1,~] = freqz(b1,a1,fs,'whole');

hold on
plot(f,abs(fftshift(H1)),'r');

% BPF filtre
wp=[55 65]/(fs/2);
ws=[20 100]/(fs/2);
Rp=3;
Rs=80;
[n,Wn] = buttord(wp,ws,Rp,Rs);
[b2,a2] = butter(n,Wn)

[H2,~] = freqz(b2,a2,fs,'whole');

hold on
plot(f,abs(fftshift(H2)),'k');

title('|S(f)| , BPF ve LPF')
xlabel('frekans [Hz]')
ylabel('Genlik')
legend('|S(f)|','LPF','BPF','Location','northeastoutside')
%% Sinyali Filtreleme

s1_hat = filter(b1,a1,s);

figure 
plot(t,s1,t,s1_hat)

title('s1(t) ve {s_1}hat(t) ')
xlabel('zaman [s]')
ylabel('Genlik')
legend('s_1(t)','{s_1}hat(t)','Location','northeast')

s2_hat = filter(b2,a2,s);

figure 
plot(t,s2,t,s2_hat)
axis([.5 .6 -1.1 1.1])

title('s2(t) ve {s_2}hat(t) ')
xlabel('zaman [s]')
ylabel('Genlik')
legend('s_2(t)','{s_2}hat(t)','Location','northeast')