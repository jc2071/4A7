clc; clear; close all

% Load workspace
Reference_data 

H = 28270;
OPR = 20;

wf = tmax*(1 - exp(-12/(H/1000)) + 0.015);
EI = 3088;

co2mass =  EI*wf*1000/pmax/12000;

T02 = stag_temp(0.85,9.5);
EInox = NOx(T02, teff, OPR);

noxmass = EInox *wf* 1000*15.1*2/pmax/12000;

altitudes = [5 9 10 11 12];
co2impact = [147 126 110 100 100];
noximpact = [10 47 63 105 126];

xq = 5:0.01:12;

noxi = [];
co2i = [];
heights =  5:0.1:16;
i = 1;
for h = heights
    [noxi(i), co2i(i)] = impact(h);
    i = i+1;
end

figure(1)
hold on
plot(heights, noxi,'Linestyle','-.','color','blue', 'DisplayName', 'NO_x relative warming','linewidth',2)
plot(heights, co2i,'Linestyle','-','color','green', 'DisplayName', 'CO_2 relative warming','linewidth',2)
altitudes = [5 9 10 11 12];
co2impact = [147 126 110 100 100];
noximpact = [10 47 63 105 126];
scatter(altitudes, co2impact,100,'x','g','HandleVisibility','off','LineWidth',2)
scatter(altitudes, noximpact,100,'x','b','HandleVisibility','off','LineWidth',2)
legend()
xlabel('Altitude (km)')
ylabel('Relative warming')
box on
set(gca,'FontName','Times','FontSize',14)
print(gcf,'impact','-depsc')