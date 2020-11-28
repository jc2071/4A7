clc; close all; clear

%load workspace
ref 

heights = 0:0.2:20;

[T, p, rho ,a] = arrayfun(@ISA,heights);

figure(1)
hold on
plot(heights,T/tsl,'--','color','k','DisplayName','T/T_{sl}')
plot(heights,p/psl,'-','color','k','DisplayName','p/p_{sl}')
plot(heights,rho/rhosl,'-.','color','k','DisplayName','\rho/\rho_{sl}')
grid on
set(gca,'FontName','times','FontSize',14)
xlabel('Altitude (km)')
legend()