function [nox, co2] = Contour_Function(OPR,height,flight_range)

Reference_data;

stages = 10;
stage_length =  flight_range*1000/stages;

[T,p,rho,a] = ISA(height); % get ISA envioment conditions for fixed height
    w0_stage = 220; % get starting weight 
    mach_stage = zeros(1,stages); % get mach number variation over the flight
    stage_fuel_used = zeros(1,stages); % get fuel used over the flight
    mass_co2 = 0; % store mass co2 used
    mass_nox = 0; % store mass nox used
    
for i = 1:1:stages % loop over each stage in fixed height flight

    ve_star = (w0_stage*1000*g/(0.5*rhosl*A))^0.5 *(k2/k1)^0.25; % Optimum Equivilant Air Speed 
    nu = 1; % EAS ratio to optimium set to get best L/D
    EAS = nu*ve_star; % actaul EAS
    TAS = ve_star/sqrt(rho/rhosl); % True Air Speed
    mach = TAS/a; % Mach number of flight (cruise)

%     if mach >= 0.85
%         mach = 0.85; % don't go faster
%     end
    [mach, ~, nu] = max_range(w0_stage,height,OPR);    
    mach_stage(i) = mach;

    [mj,tj, peff] = jet(mach, FPR, feff); % jet mach, jet temp ratio, propulsive efficiency
    LD = (sqrt(k1*k2)*(nu^2 + 1/nu^2))^-1;
    cycle_efficiency = (1 - OPR^-0.17);
    H = peff * cycle_efficiency * treff * LD* LCV / g; % the range parameter for eacgh stage

    if i ==1
        weight_fuel = w0_stage*(0.015 + 1 - exp(-stage_length/H));
    else
        weight_fuel =  w0_stage*(1 - exp(-stage_length/H));
    end

    stage_fuel_used(i) = weight_fuel;
    w0_stage = w0_stage - weight_fuel;
    T02 = stag_temp(mach,height);
    nox = NOx(T02,teff,OPR)*weight_fuel*2*15.1*1000;
    co2 = 3088*weight_fuel*1000;

    mass_co2 = mass_co2 + co2;
    mass_nox = mass_nox + nox;
end

co2 = mass_co2/flight_range/pmax;
nox = mass_nox/flight_range/pmax;

