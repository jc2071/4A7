clc; close all; clear;

altitudes = 0:0.5:15;
nox = zeros(size(altitudes));
co2 = zeros(size(altitudes));

parfor i = 1:1:length(altitudes)
   [noxim, co2im, ~] = impact_v2(altitudes(i));
   nox(i) = noxim
   co2(i) = co2im
end

figure(1)
hold on
yyaxis left
plot(altitudes,nox,'b','Linewidth',1.5,'DisplayName','NO_x GWP - Spline fit')
ylabel('NO_x GWP')
set(gca,'YColor','k');
plot(0:1:15,[-7.1;-7.1;-7.1;-4.3;-1.5;6.5;14.5;37.5;60.5;64.7;68.9;57.7;46.5;25.6;4.6;0.6],'--x','Linewidth',1,'DisplayName','Raw NO_x GWP data','color','b');
yyaxis right
plot(altitudes,co2,'--','color','r','Linewidth',1.5,'DisplayName','CO_2 GWP')
ylabel('CO_2 GWP')
set(gca,'YColor','k');
box on
xlabel('Altitude (km)')
set(gca,'FontName','Times','FontSize',12)
xticks(0:1:15)
legend('Location','nw')
print(gcf,'rel_impact','-depsc')



