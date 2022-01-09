function [fsig] = HPFilter(sig,Fc,T)

  % T = 1/Fs
  c1 = 1/(1+tan(Fc*pi*T));
  c2 = (1-tan(Fc*pi*T))/(1+tan(Fc*pi*T));

  sigLen = length(sig);

  fsig = zeros(1,sigLen);

  for i=2:sigLen
    fsig(i)=c2*fsig(i-1)+c1*(sig(i)-sig(i-1));
  end

end