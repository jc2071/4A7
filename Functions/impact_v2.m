function [noxim, co2im, h2oim] = impact_v2(h)
% [noxim, co2im] = impact(h)
% noxim = relative impact of nox with height variations
% co2im = relative impact of co2 with height variations
% h20im = relative impact of h2o with height variations


nox = [-7.1;-7.1;-7.1;-4.3;-1.5;6.5;14.5;37.5;60.5;64.7;68.9;57.7;46.5;25.6;4.6;0.6];

h20 = [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.24,0.34,0.43,0.53,0.62,0.72];

co2 = [1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1];

altitudes = [0;1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15];




sp = fit(altitudes, co2, 'smoothingspline');
     co2im = feval(sp,h);
     
sp2 = fit(altitudes, nox, 'smoothingspline');
     noxim = feval(sp2,h);
     
h2oim = 0;
% 
%     sp2 = fit(altitudes, noximpact, 'smoothingspline');
%     noxim = feval(sp2,h);
% else
%     noxim = (126-105)*(h-12)^2 + 126;
%     co2im = 100;


end

