function [ceff] = cycleff(teff,theta,OPR)
% ceff = cycleff(teff,theta,OPR)
% ceff = cycle effciency
% teff = turbine/ compressor effciency
% theta = turbine entry tempretrure ratio
% OPR = overall pressure ratio

ceff = (theta*(1 - 1/OPR^(0.4/1.4))*teff - ((OPR^(0.4/1.4) -1)) / teff)/ ...
        (theta -1 - (OPR^(0.4/1.4) -1)/teff);
end