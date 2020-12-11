function [T,p,rho,a] = ISA(h)
% [T,p,rho,a] = ISA(h)
% T = tempreture
% p = pressure
% rho = density
% a = speed of sound
% h = height in km above sl

tsl = 288.15;
asl = 340.3;
psl = 101.325;
rhosl = 1.225;

if h <= 11 && h >=0
    T = tsl - 6.5.*h;
    p = psl*(T./tsl).^(5.256);
    rho = rhosl*(T./tsl).^(4.256);
elseif 11 < h && h <= 20
    T = 216.65;
    rhot = rhosl*(T./tsl).^(4.256);
    pt = psl*(T./tsl).^(5.256);
    p = pt*exp(-0.1577*(h -11));
    rho = rhot*exp(-0.1577*(h-11));
else
    error('Please enter alitude 0 <= h <= 20')
end

a = asl*(T./tsl).^0.5;

end