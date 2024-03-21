clc, clear, close all;

fm=10;
faz=-pi/2;
fs=100*fm;
ts=1/fs;
t=0:ts:10-ts;
s1=cos(2*pi*fm*t);
s2=cos(2*pi*fm*t + faz);

figure
subplot 211
plot(t,s1)
axis([0 0.1 -1.5 1.5]) %grafikte goruntulenecek araligi belirleme
xlabel('t')
ylabel('s1(t)')
title('faz = 0')
grid on
subplot 212
plot(t,s2)
axis([0 0.1 -1.5 1.5]) %grafikte goruntulenecek araligi belirleme
xlabel('t')
ylabel('s2(t)')
title('faz = -pi/2')
grid on

figure
plot(t,s1)
hold on
plot(t,s2,'r')
axis([0 1 -1.5 1.5])
grid on
