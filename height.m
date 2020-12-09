clc; clear; close all;

%load workspace
Reference_data

beta = 2*sqrt(k1*k2); % optimium beta* gives best D/L and sets cruise

range = 12000; % range in km

heights = 4:2:16; % height array in km

figure(1)
hold on

for height = heights % loop through each height
    wp = 200; % set initial weight
    wplist = []; % get weight for eachpart of flight not just start and end
    stages = 10; % split flight into 10 stages
    stage_length = range/stages; % length of each stage
    LCV = 42.7e6; % Lower Calorific Value of JET-A1 (kerosene)
    fuel = 0; % sum up how much fuel has been used
    for i = 1:1:stages
        wplist(i) = wp;
        [T,p,rho,a] = ISA(height); % get ISA envioment conditions
        wl = wp*1000*9.81/A; % wing loading
        ve_star = (wp*1000*9.81/(0.5*rhosl*A))^0.5 *(k2/k1)^0.25; % Optimum EAS 
        nu = 1; 
        EAS = nu*ve_star;
        TAS = ve_star/sqrt(rho/rhosl); % True Air Speed
        mach = TAS/a; % Mach number of flight (cruise)
        [mj,tj, peff] = jet(mach, FPR, feff); % jet mach, jet temp ratio, propulsive efficiency
        LD = (sqrt(k1*k2)*(nu^2 + 1/nu^2))^-1;
        H = peff * cycleff(teff,theta,OPR) * treff * LD* LCV / 9.81;
        weightr = exp(stage_length*1000/H);
        deltaw = wp*(1 - 1/weightr);
        wp = wp/weightr;
        fuel = fuel + deltaw;
    end
plot(linspace(0,range,stages),200-wplist,'DisplayName',['Height = ' num2str(height) 'km'])
end

legend('Location','best')
xlabel('Distance (km)')
ylabel('Fuel used (T)')
set(gca,'FontName','Times','FontSize',14)