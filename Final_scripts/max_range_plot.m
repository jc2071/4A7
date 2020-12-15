clc; clear; close all;

Reference_data;

w0 = 220;
OPR = 40;
weights = [1 0.80 0.60 0.40]*w0;
altitudes = 0:0.5:15;

linestyles = {'-','--','-.',':'};
colors = {'r','b','g','m'};
j = 1;

for w = weights
    opt_mach = zeros(size(altitudes));
    opt_H = zeros(size(altitudes));
    index = 1;
    for h = altitudes
        [opt_mach(index), opt_H(index)] = max_range(w,h, OPR);
        index = index +1;
    end
    figure(1)
    hold on
    plot(altitudes,opt_mach,'Linestyle',linestyles{j},'color',colors{j},...
        'DisplayName',[num2str(w/w0*100) '% W_0'],'Linewidth',1.5)
    
    figure(2)
    hold on
    plot(altitudes,opt_H,'Linestyle',linestyles{j},'color',colors{j},...
        'DisplayName',[num2str(w/w0*100) '% W_0'],'Linewidth',1.5)
    j = j +1;
end

figure(1)
legend('location','se')
xlabel('Altitude (km)')
ylim([0.30,0.9])
ylabel('Optimium Mach number')
xticks(0:1:15)
set(gca,'FontName','Times','FontSize',12)
box on
print('opt_mach','-depsc')

figure(2)
legend('location','se')
xlabel('Altitude (km)')
ylabel('Range Parameter')
xticks(0:1:15)
set(gca,'FontName','Times','FontSize',12)
box on
legend('location','s')
print('opt_range','-depsc')

