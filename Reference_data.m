%% ISA base values

tsl = 288.15; % temptretur sea level
asl = 340.3; % speed of sound sea level
psl = 101.325; % pressure sea levek
rhosl = 1.225; % density sea level

%% Reference data 1

pmax = 240; % max number of passengers
rmax = 12000; % range at max payload (km)
plmax = 40; % max payload (tonnes)
we = 106; % empty weight (tonnes)
fmax = 74; % max fuel capacity at max payload (tonnes)
tmax = 220; % max take off weight (tonnes)
cr = 256; % cruie TAS (Target Air Speed, V)
mc = 0.8; % mach number at cruise
icr = 31000; % initial cruise altitude (ft)
LD = 21; % cruise L/D
A = 315; % wing area

%% Reference data 2

tac = 227; % atmosphere tempreture at cruise 
pac = 28.7; % atmosphere pressure at cruise
to2 = 259; % stagnation tempreture at cruise
po2 = 45.7; % stagnation pressure at cruise
OPR = 45; % Overall Pressure Ratio
theta = 6; % Turbine entry tempreture ratio
teff = 0.9; % Turbine and compressor effciencies
FPR = 1.45; % fan pressure ratio
feff = 0.92; % fan effciency
treff = 0.90; % transfer effciencie

%% Refrence data 3

k = 0.015; % range equation offset
c1 = 0.3; % weight coef
c2 = 1.0; % weight coef
k1 = 0.0125; % drag coef
k2 = 0.0446; % drag coef
