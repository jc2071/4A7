clc; clear; close all;

%load workspace
Reference_data

range = 1500; % range in km

heights = 5:1:12; % height array in km

figure(1)
hold on
w0 = 200;
stages = 10; % split flight into 10 stages
nox = zeros(1,length(heights));
co2 = zeros(1,length(heights));

TAT_flag = 0;

index =1;
for height = heights % loop through each height
    machlist = zeros(1,length(heights));
    wp = w0; % set initial weight
    wplist = zeros(1,stages); % get weight for eachpart of flight not just start and end
    stage_length = range/stages; % length of each stage
    LCV = 42.7e6; % Lower Calorific Value of JET-A1 (kerosene)
    for i = 1:1:stages
        wplist(i) = wp;
        [T,p,rho,a] = ISA(height); % get ISA envioment conditions
        wl = wp*1000*9.81/A; % wing loading
        ve_star = (wp*1000*9.81/(0.5*rhosl*A))^0.5 *(k2/k1)^0.25; % Optimum EAS 
        nu = 1; % EAS ratio to optimium
        EAS = nu*ve_star;
        TAS = ve_star/sqrt(rho/rhosl); % True Air Speed
        mach = TAS/a; % Mach number of flight (cruise)
        [mj,tj, peff] = jet(mach, FPR, feff); % jet mach, jet temp ratio, propulsive efficiency
        LD = (sqrt(k1*k2)*(nu^2 + 1/nu^2))^-1;
        cycle_efficiency = (1 - OPR^-0.17);
        H = peff * cycle_efficiency * treff * LD* LCV / 9.81;
        
        if TAT_flag ==0
            syms theta
            solx = solve(cycle_efficiency == (theta*(1 - 1/OPR^(0.4/1.4))*teff - ((OPR^(0.4/1.4) -1)) / teff)/ ...
            (theta -1 - (OPR^(0.4/1.4) -1)/teff), theta);
            TAT_flag =1;
        end
        %H = peff * cycleff(teff,theta,OPR) * treff * LD* LCV / 9.81;
        weightr = exp(stage_length*1000/H);
        deltaw = wp*(1 - 1/weightr);
        wp = wp/weightr;
        machlist(i) = mach;
    end
    figure(1)
    fuelused = w0 -wp;
    plot(linspace(0,range,stages),w0-wplist,'DisplayName',['Height = ' num2str(height) 'km'])
    T02 = stag_temp(mach,height);
    [noxim, co2im] = impact(height);
    nox(index) = NOx(T02,teff,OPR)*fuelused*2*15.1*1000/range/pmax * noxim ;
    co2(index) = 3088*fuelused*1000/range/pmax * co2im;
    index = index +1;
    figure(4)
    plot(machlist,linspace(0,range,stages))
    hold on
    
end

figure(1)
sum_impact = nox + co2;
min_index = find(sum_impact == min(sum_impact(:)));
opt_height = heights(min_index);
figure(1)
legend('Location','best')
xlabel('Distance (km)')
ylabel('Fuel used (T)')
set(gca,'FontName','Times','FontSize',14)

figure(2)
hold on
plot(heights, nox,'Linestyle' ,'--' ,'color','b','DisplayName', 'NO_x impact','linewidth',2)
plot(heights, co2,'Linestyle','-','color','g', 'DisplayName', 'CO_2 impact','linewidth',2)
plot(heights, sum_impact,'Linestyle','-.','color','cyan', 'DisplayName', 'Impact sum','linewidth',2)
xline(opt_height,'--','label','Optimum altitude','color','r','linewidth',2,...
    'HandleVisibility','off','LabelHorizontalAlignment','left',...
    'LabelVerticalAlignment' ,'bottom')
xlabel('Height (km)')
ylabel('Relative impact')
set(gca,'FontName','Times','FontSize',14)
box on
legend()