clc; clear; close all;

% load workspace
Reference_data;

altitudes = 3:1:15;
OPR_range = 3:1:60;

[X,Y] = meshgrid(altitudes, OPR_range); % X = altitudes, Y = OPR's

Nox = zeros(size(X)); % make grid
Co2 = zeros(size(X)); % make grid


for i = 1:1:size(X,2) % loop over for a fixed altitude so go down the column
    for j = 1:1:size(X,1) % loop over across the column
        [Nox(j,i), Co2(j,i)] = Contour_Function(Y(j,i),X(j,i),12000);
    end
end

c = 0.2:0.2:1.6;
figure(1)
[C,h] = contour(X,Y,Nox,c,'linewidth',1.6);
clabel(C,h,c,'FontName','Times', 'FontSize',12)
xlabel('Altitude (km)')
ylabel('Overall Pressure Ratio')
box on
set(gca,'FontName','Times','FontSize',12)

c = 50:10:100;
figure(2)
[C,h] = contour(X,Y,Co2,c,'linewidth',1.6);
clabel(C,h,c,'FontName','Times', 'FontSize',12)
xlabel('Altitude (km)')
ylabel('Overall Pressure Ratio')
box on
set(gca,'FontName','Times','FontSize',12)




