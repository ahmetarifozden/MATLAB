function [S_temiz] = faz_temizleme(S,hassasiyet)
S_temiz=S;
S_temiz(abs(S)<max(abs(S)*10^-hassasiyet))=0;
end