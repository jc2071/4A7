function T0 = stag_temp(M,h)
% T0 = stag_temp(T,M)
% T0 = stagnation tempreture (isentropic)
% M = Mach number of flight
% h = height of aircraft

T = ISA(h);
T0 = T*(1 + 0.2*M^2);
end

