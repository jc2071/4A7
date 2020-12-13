clc; clear; close all;

OPR_range = 5:5:100;
height_range = 0:1:15;

[X, Y] =  meshgrid(height_range,OPR_range);

Z = zeros(size(X));

% parfor i = 1:1:size(X,2)
%     for j = 1:1:size(X,1)
%         disp(j)
%         %Z(j,i) = Range_contour(X(j,i),Y(j,i),74);
%         Z() = arrayfun(@Range_contour,X,Y,74)
%     end
% end
%   

parfor i = 1:1:size(X,2)
        disp(i)
        Z(:,i) = arrayfun(@Range_contour,X(:,i),Y(:,i),repmat(74,size(X,1),1))
end

figure(1)
c = 6000:100:12000;
[C,h] = contour(X,Y,Z,'linewidth',1.5);
clabel(C,h,c,'FontName','Times', 'FontSize',10)
xlabel('Altitude (km)')
ylabel('Overall Pressure Ratio')
box on
c = colorbar;
c.Label.String = 'Range (km)';
set(gca,'FontName','Times','FontSize',12)
print('range_contour','-depsc')

        