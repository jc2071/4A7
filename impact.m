function [noxim, co2im] = impact(h)
% [noxim, co2im] = impact(h)
% noxim = relative impact of nox with height variations
% co2im = relative impact of co2 with height variations
altitudes = [5;9;10;11;12];
co2impact = [147;126;110;100;100];
noximpact = [10;47;63;105;126];

sp = fit(altitudes, co2impact, 'smoothingspline');
co2im = feval(sp,h);

sp2 = fit(altitudes, noximpact, 'smoothingspline');
noxim = feval(sp2,h);
end

