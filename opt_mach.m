clc; clear; close all;

% Load workspace
Reference_data

w0 = 200;
weights =[1 0.80 0.60 0.40]*w0;
altitudes = 0:0.1:15;

cl_star = sqrt(k1/k2);
linestyles = {'-','--','-.',':'};
colors = {'r','b','g','m'};
j = 1;
for weight = weights
    mstar = zeros(size(altitudes));
    i = 1;
    for altitude = altitudes
        [T, ~, rho, a] = ISA(altitude);
        mstar_unconstrained = sqrt(2*weight*1000*9.81/(cl_star*rho*A*a^2));
        if mstar_unconstrained >= 0.85
            mstar(i) = 0.85;
        else
            mstar(i) = mstar_unconstrained;
        end
        i = i +1;
    end
    figure(1)
    plot(altitudes, mstar,'Linestyle',linestyles{j},'color',colors{j},...
        'DisplayName',[num2str(weight/w0*100) '% W_0'],'Linewidth',1.5)
    hold on
    j = j +1;
end

figure(1)
legend('location','se')
xlabel('Altitude (km)')
ylim([0.30,0.9])
ylabel('Optimium Mach number')
set(gca,'FontName','Times','FontSize',12)
box on;
xticks(0:1:15)
print('opt_mach','-depsc')