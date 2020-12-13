function range = Range_contour(height,OPR,w_f)

Reference_data;

stage_length =  20*1000; % 1km flight steps

[T,p,rho,a] = ISA(height); % get ISA envioment conditions for fixed height
w0_stage = 220; % get starting weight 

i = 1;
while w_f > 0 % loop over each stage in fixed height flight
    ve_star = (w0_stage*1000*g/(0.5*rhosl*A))^0.5 *(k2/k1)^0.25; % Optimum Equivilant Air Speed 
    nu = 1; % EAS ratio to optimium set to get best L/D
    EAS = nu*ve_star; % actaul EAS
    TAS = ve_star/sqrt(rho/rhosl); % True Air Speed
    mach = TAS/a; % Mach number of flight (cruise)

%     if mach >= 0.85
%         mach = 0.85; % don't go faster
%     end
    [mach, ~, nu] = max_range(w0_stage,height,OPR);    

    [mj,tj, peff] = jet(mach, FPR, feff); % jet mach, jet temp ratio, propulsive efficiency
    LD = (sqrt(k1*k2)*(nu^2 + 1/nu^2))^-1;
    cycle_efficiency = (1 - OPR^-0.17);
    H = peff * cycle_efficiency * treff * LD* LCV / g; % the range parameter for eacgh stage

    if i ==1
        weight_fuel = w0_stage*(0.015 + 1 - exp(-stage_length/H));
    else
        weight_fuel =  w0_stage*(1 - exp(-stage_length/H));
    end

    w_f = w_f - weight_fuel;
    i = i + 1;
    
end

range = i*20;
