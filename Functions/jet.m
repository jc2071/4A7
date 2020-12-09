function [mach_jet, jet_temp_ratio, propulsive_efficiency] = jet(M,FPR,feff)
% [mach_jet, jet_temp_ratio, propulsive_efficiency] = jet(M,FPR,feff)
% mach_jet = jet mach number
% jet_temp_ratio = jet tempreture ratio t_jet/t_atmosphere
% propulsive_efficiency = propulsive efficiency
% M = mach number of flight speed
% FPR = fan pressure ratio
% feff = fan efficiency

mj = sqrt((FPR^(0.4/1.4)*(1 + 0.5*0.4*M^2) - 1)/(0.5*0.4));
tjr = (1 + 0.5*0.4*M^2)/(1 + 0.5*0.4*mj^2) * FPR^(0.4/1.4*feff);
peff = 2*(1 + mj/M * sqrt(tjr))^-1;

mach_jet = mj;
jet_temp_ratio =  tjr;
propulsive_efficiency = peff;
end