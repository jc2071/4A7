function EI = NOx(T02,compeff,OPR)
% EI = NOx(T02,compeff)
% EI = Emmision index for NOx (g_Nox/g_air)
% T02 = Fan inlet stagnation tempreture
% compeff = Compressor effciency
% OPR = Overall pressure ratio

T03 = T02*(1 + (OPR^(0.4/1.4) -1)/compeff);
EI = 0.011445*exp(0.00676593*T03);
end

