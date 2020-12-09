function tjr = tj(M,FPR,dfvdfvdf)
% tjr = tj(M,FPR)
% M = mach number of flight speed
% FPR = fan pressure ratio

tjr = sqrt((FPR^(0.4/1.4)*(1 + 0.5*0.4*M^2) - 1)/(0.5*0.4));

end