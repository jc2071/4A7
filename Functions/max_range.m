function [opt_mach, opt_H, nu] = max_range(w,altitude,OPR)

Reference_data;

Machs = 0:0.01:1;
peffs = zeros(size(Machs));

[T,p,rho,a] = ISA(altitude);
ve_star = (w*1000*g/(0.5*rhosl*A))^0.5*(k2/k1)^0.25;

nu_cycle = 1 - OPR^(-0.17);

i = 1;
for M = Machs
    [~, ~, peff] = jet(M,FPR,feff);
    ve = (rho/rhosl)^0.5 * M*a;
    nu = ve/ve_star;
    beta = sqrt(k1*k2)*(nu^2 + 1/(nu^2));
    peffs(i) = peff/beta * LCV/g * nu_cycle * treff;
    i = i +1;
end 

[opt_H, index] = max(peffs);

if Machs(index) >= 0.85
    opt_mach = 0.85;
    opt_H = peffs(find(Machs==0.85));
else
    opt_mach = Machs(index);
end

ve = (rho/rhosl)^0.5 * opt_mach*a;
nu = ve/ve_star;
% max_h = peffs(find(Machs==0.85));
% figure(1);
% plot(Machs,peffs/1000,'k','Linewidth',1.5,'HandleVisibility','off')
% hold on
% xlabel('Mach Number')
% ylabel('Range Parameter - H (km)')
% scatter(0.85,max_h/1000,60,'marker','^','MarkerFaceColor','r','DisplayName','Transonic Limit')
% scatter(opt_mach,opt_H/1000,60,'marker','o','MarkerFaceColor','b','DisplayName','Optimium Mach')
% box on
% legend('Location','nw')
% set(gca,'FontName','Times','FontSize',12)