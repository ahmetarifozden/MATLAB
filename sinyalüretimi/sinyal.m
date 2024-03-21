
clc, clear, close all;

fm=10;
faz=0;
fs=100*fm;
ts=1/fs;
t=0:ts:10-ts;

s=cos(2*pi*fm*t + faz);

figure
plot(t,s)
hold on
stem(t,s)
axis([0 0.1 -1.5 1.5])

figure
subplot 211
plot(t,s)
axis([0 0.1 -1.5 1.5])
xlabel('t')
ylabel('s(t)')
title('sinyali zaman bölgesinde (surekli) cizdirme')
subplot 212
stem(0:length(s)-1,s)
axis([0 fs/fm-1 -1.5 1.5])
xlabel('n')
ylabel('s[n]')
title('sinyali zaman bölgesinde (ayrik) cizdirme')
