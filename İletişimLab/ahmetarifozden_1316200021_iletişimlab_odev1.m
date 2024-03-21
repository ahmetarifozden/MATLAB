% Soru 1
%a
x = 10; 
y = 3;
u = x+y
%b
z = sin(x)
%c
v = x*y
%d
r = 8*sin(y)
%e
w = x/y
%f
s = 5*sin(2*y)
%--------------------------------

%Soru2
%a
x = 3;
y = (6*x^3) + (4/x)
%b
x = 4;
z = (3*(x-5))/(x^(1/2) + log(16)/log(4))
%c
x = 5 + 8i;
z = exp(x)
%d
x = 5 + 8i;
y = -6 + 7i;
v = x*y 
%--------------------------------

%Soru3
x = 1:0.2:5;
y = 7 * sin(4 * x)
disp(['size of array of y: ', num2str(length(y))]);
disp(['third member: ', num2str(y(3))]);
%--------------------------------

%Soru4
x = 0:0.2:14
%--------------------------------

%Soru5
A = [3 7 -4 12
    -5 9 10 2
    6 13 8 11
    15 5 4 1];
%a
v = A(:,2)
%b
w = A(2,:) 
%c
B = A(:, 2:4)
%d
max(A)
min(A)
%e
max(A,[],2)
min(A,[],2)
%f
inv(A)
det(A)
%--------------------------------

%Soru6
A = [5 9
    6 2];

B = [4 7
    2 8];

C = A./B
D = A.\B
E = A*B
F = A.*B
G = A.^2
H =A'
I = B^2
%--------------------------------

%Soru7
% Fonksiyon tanımı
f = @(x) (2.5 * exp(-0.5 * x)) .* sin(5 * x);

% x değerlerini oluştur
x_values = linspace(-3.5, 10, 1000);

% Fonksiyon değerlerini hesapla
y_values = f(x_values);

% Grafiği çiz
figure;
plot(x_values, y_values, 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title('Fonksiyon Grafiği');
grid on;
%--------------------------------

%Soru8
x = 6;

z = (x<10)
z = (x == 10)
z = (x >= 4)
z = (x ~= 7)
%-------------------------------

%Soru9
x = [10,-2, 6, 5,-3];
y = [9,-3, 2, 5,-1]; 

z = (x<6)
z = (x<=y)
z = (x==y)
z = (x ~= y)
%-------------------------------

%Soru10
x = [-3, 0, 0, 2, 5, 8]  
y = [-5,-2, 0, 3, 4, 10] 

z = (y<~x)
z = (x&y)
z = (x|y)
z = xor(x,y)
%-------------------------------

%Soru11
% Skaler değişken x'in değerleri
x1 = -5;
x2 = 3;
x3 = 10;

% İlk koşul: x < -1
if x1 < -1
    y1 = exp(x1) + 1;
else
    % İkinci koşul: -1 <= x < 5
    if x1 < 5
        y1 = 2 + cos(pi * x1);
    else
        % Üçüncü koşul: x >= 5
        y1 = 10 * (x1 - 5) + 1;
    end
end

% İlk koşul: x < -1
if x2 < -1
    y2 = exp(x2) + 1;
else
    % İkinci koşul: -1 <= x < 5
    if x2 < 5
        y2 = 2 + cos(pi * x2);
    else
        % Üçüncü koşul: x >= 5
        y2 = 10 * (x2 - 5) + 1;
    end
end

% İlk koşul: x < -1
if x3 < -1
    y3 = exp(x3) + 1;
else
    % İkinci koşul: -1 <= x < 5
    if x3 < 5
        y3 = 2 + cos(pi * x3);
    else
        % Üçüncü koşul: x >= 5
        y3 = 10 * (x3 - 5) + 1;
    end
end

% Sonuçları ekrana yazdır
disp(['x = -5, y = ' num2str(y1)]);
disp(['x = 3, y = ' num2str(y2)]);
disp(['x = 10, y = ' num2str(y3)]);
%-------------------------------
%Soru 12
if x < y && z < 10
    w = x * y * z;
end

%Soru13
x = [-3, 0, 0, 2, 6, 8];
y = [-5, -2, 0, 3, 4, 10];

% 𝑥 içindeki 𝑦'deki karşılık gelen elemanlardan büyük olan indeksleri bul
indices = find(x > y);

% Büyük olan elemanları göster
indices = x(indices)
%-------------------------------

%Soru14
% Kullanıcıdan fonksiyon seçimini al
fprintf('Lütfen çizmek istediğiniz fonksiyonu seçin:\n');
fprintf('1. f1(x) = cos(x)\n');
fprintf('2. f2(x) = sin(x)\n');
fprintf('3. f3(x) = -x^2 + 10x\n');

secim = input('Seçiminizi yapın (1, 2 veya 3): ');

% 0 ≤ 𝑥 ≤ 10 aralığında x değerlerini oluştur
x_values = linspace(0, 10, 1000);

% Seçilen fonksiyonu hesapla
if secim == 1
    y_values = cos(x_values);
    fonksiyon_adi = 'f1(x) = cos(x)';
elseif secim == 2
    y_values = sin(x_values);
    fonksiyon_adi = 'f2(x) = sin(x)';
elseif secim == 3
    y_values = -x_values.^2 + 10 * x_values;
    fonksiyon_adi = 'f3(x) = -x^2 + 10x';
else
    error('Geçersiz seçim. Lütfen 1, 2 veya 3 girin.');
end

% Grafiği çiz
figure;
plot(x_values, y_values, 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title(['Seçilen Fonksiyon: ', fonksiyon_adi]);
grid on;

%Soru 15

x = linspace(-2*pi, 2*pi, 1000);
f = @(x) 3*cos(x).^2 - 2*x;
g = @(x) -6*x.*cos(x).*sin(x) + 3*cos(x).^2 - 2;

% Grafik çizimi
figure;
plot(x, f(x), 'r', 'LineWidth', 2); % f(x) kırmızı çizgi
hold on;
plot(x, g(x), '--b', 'LineWidth', 2); % g(x) kesikli mavi çizgi
xlabel('x');
ylabel('y');
title('f(x) ve g(x) Fonksiyonları');
legend('f(x)', 'g(x)');
grid on;

% Eksenleri etiketleyelim
xticks(-2*pi:pi/2:2*pi);
xticklabels({'-2\pi', '-\pi', '0', '\pi', '2\pi'});









