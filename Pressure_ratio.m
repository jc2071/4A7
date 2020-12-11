clc; clear; close all;

%load workspace
Reference_data

range = 12000; % range in km
w0 = 220;
stages = 5;
OPR_range = 10:1:50;
height = 12;
index =1;

for OPR = OPR_range % loop through each height
    machlist = zeros(1,length(OPR_range));
    wp = w0; % set initial weight
    wplist = zeros(1,stages); % get weight for eachpart of flight not just start and end
    stage_length = range/stages; % length of each stage
    LCV = 42.7e6; % Lower Calorific Value of JET-A1 (kerosene)
    for i = 1:1:stages
        wplist(i) = wp;
        [T,p,rho,a] = ISA(height); % get ISA envioment conditions
        wl = wp*1000*9.81/A; % wing loading
        ve_star = (wp*1000*9.81/(0.5*rhosl*A))^0.5 *(k2/k1)^0.25; % Optimum EAS 
        nu = 0.90; % EAS ratio to optimium
        EAS = nu*ve_star;
        TAS = ve_star/sqrt(rho/rhosl); % True Air Speed
        mach = TAS/a; % Mach number of flight (cruise)
        mach = 0.85;
        [mj,tj, peff] = jet(mach, FPR, feff); % jet mach, jet temp ratio, propulsive efficiency
        LD = (sqrt(k1*k2)*(nu^2 + 1/nu^2))^-1;
        cycle_efficiency = (1 - OPR^-0.17);
        H = peff * cycle_efficiency * treff * LD* LCV / 9.81;
        weightr = exp(stage_length*1000/H);
        deltaw = wp*(1 - 1/weightr);
        wp = wp/weightr;
        machlist(i) = mach;
    end
    syms theta
    solx = solve(cycle_efficiency == (theta*(1 - 1/OPR^(0.4/1.4))*teff - ((OPR^(0.4/1.4) -1)) / teff)/ ...
    (theta -1 - (OPR^(0.4/1.4) -1)/teff), theta);
    double(solx);
    fuelused = w0 -wp;
    T02 = stag_temp(mach,height);
    [noxim, co2im] = impact(height);
    nox(index) = NOx(T02,teff,OPR)*fuelused*2*15.1*1000/range/pmax * noxim;
    co2(index) = 3088*fuelused*1000/range/pmax * co2im;
    index = index +1;
end

sum_impact = nox + co2;
figure(1)
hold on
plot(OPR_range, nox,'Linestyle' ,'--' ,'color','b','DisplayName', 'NO_x impact','linewidth',2)
plot(OPR_range, co2,'Linestyle','-','color','g', 'DisplayName', 'CO_2 impact','linewidth',2)
plot(OPR_range, sum_impact,'Linestyle','-.','color','cyan', 'DisplayName', 'Impact sum','linewidth',2)
%xline(opt_height,'--','label','Optimum altitude','color','r','linewidth',2,...
   % 'HandleVisibility','off','LabelHorizontalAlignment','left',...
    %'LabelVerticalAlignment' ,'bottom')
xlabel('OPR')
ylabel('Relative impact')
set(gca,'FontName','Times','FontSize',14)
box on
legend()