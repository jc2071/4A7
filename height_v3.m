clc; clear; close all;

%load workspace
Reference_data

OPR = 40; % Set overall pressure ratio

flight_range = 12000;% Set flight range

stages = 10; % number of integration stages

stage_length =  flight_range*1000/stages; % length of each stage (m)

heights = 5:1:15; % fixed heights to fly at

beta_star = 2*sqrt(k1*k2); % the optiumum L/D fixed by k1*k2

co2_masses = zeros(1,length(heights)); % store co2 used for each height
nox_masses = zeros(1,length(heights)); % store nox used for each height

index = 1; % index to get co2_mass and nox_mass positions

for height = heights % loop through for a fixed height
    
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
        
        mach = 0.85;
        
        if mach >= 0.85
             mach = 0.85; % don't go faster
        end
        
        mach_stage(i) = mach;
        
        TAS = a*mach; % now go back if we get past this 0.85 limit to change nu.
        EAS = (rho/rhosl)^0.5 * TAS;
        nu = EAS/ve_star; % get what we have nu as in this 0.85 limit

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

    co2_masses(index) = mass_co2;
    nox_masses(index) = mass_nox;
    
    index = index +1;
    
end

figure(1)
hold on
plot(heights,co2_masses/(flight_range*pmax),'-' ,'color','g','DisplayName', 'CO_2','linewidth',2)
plot(heights,nox_masses/(flight_range*pmax),'-' ,'color','b','DisplayName', 'NO_x','linewidth',2)

index = 1;

for height = heights % loop through for a fixed height
    
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

    co2_masses(index) = mass_co2;
    nox_masses(index) = mass_nox;
    
    index = index +1;
end

plot(heights,co2_masses/(flight_range*pmax),'--' ,'color','g','DisplayName', 'CO_2 Mach Limit','linewidth',2)
plot(heights,nox_masses/(flight_range*pmax),'--' ,'color','b','DisplayName', 'NO_x Mach Limit','linewidth',2)
legend('location','e')
xlabel('Altitude (km)')
ylabel('Emissions g/PAX km')
xticks(heights)
set(gca,'FontName','Times','FontSize',12)
box on
print('altitude','-depsc')
