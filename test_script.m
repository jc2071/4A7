clc; close all; clear

%load workspace
ref 

heights = 0:0.5:20;

[T, p, rho ,a] = arrayfun(@ISA,heights);

figure(1)
hold on
plot(heights,T/tsl)
plot(heights,p/psl)
plot(heights,rho/rhosl)
