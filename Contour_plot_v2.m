clc; clear; close all;

% load workspace
Reference_data;

altitudes = 0:0.1:15;
OPR_range = 4:2:100;

[X,Y] = meshgrid(altitudes, OPR_range); % X = altitudes, Y = OPR's

Nox = zeros(size(X)); % make grid
Co2 = zeros(size(X)); % make grid


for i = 1:1:size(X,2) % loop over for a fixed altitude so go down the column
    parfor j = 1:1:size(X,1) % loop over across the column
        
        [noxim, co2im] = impact_v2(X(j,i));
        [Nox(j,i), Co2(j,i)] = Contour_Function(Y(j,i),X(j,i),12000);
        Nox(j,i) =  Nox(j,i)*noxim;
        Co2(j,i) = Co2(j,i)*co2im;
    end
end

figure(1)
c = [10,50,90,150,210,300,450,700,1200,1500,2000];
[C,h] = contour(X,Y,Nox,c,'linewidth',1.5);
clabel(C,h,c,'FontName','Times', 'FontSize',10)
xlabel('Altitude (km)')
ylabel('Overall Pressure Ratio')
box on
c = colorbar;
c.Label.String = 'NO_x Impact';
set(gca,'FontName','Times','FontSize',12)
print('nox','-depsc')

figure(2)
c = 0:10:160;
[C,h] = contour(X,Y,Co2,c,'linewidth',1.5);
clabel(C,h,c,'FontName','Times', 'FontSize',10)
xlabel('Altitude (km)')
ylabel('Overall Pressure Ratio')
box on
c = colorbar;
c.Label.String = 'CO_2 Impact';
set(gca,'FontName','Times','FontSize',12)
print('co2','-depsc')

Z = zeros(size(X));
for i = 1:1:size(X,2) % loop over for a fixed altitude so go down the column
    parfor j = 1:1:size(X,1) % loop over across the column
        [Noxr, Co2r] = Contour_Function(Y(j,i),X(j,i),12000);
        [noxim, co2im] = impact_v2(X(j,i));
         Z(j,i) = Noxr*noxim + Co2r*co2im;
    end
end


figure(3)
c = [92 95 100 130 150 200 300 400 500 600];
[C,h] = contour(X,Y,Z,c,'linewidth',1.5);
clabel(C,h,c,'FontName','Times', 'FontSize',10)
xlabel('Altitude (km)')
ylabel('Overall Pressure Ratio')
box on
c = colorbar;
c.Label.String = 'Total Impact';
set(gca,'FontName','Times','FontSize',12)
print('overall','-depsc')



