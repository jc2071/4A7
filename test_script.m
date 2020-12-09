clc; clear; close all

% Load workspace
Reference_data 

H = 28270;
OPR = 20;

wf = tmax*(1 - exp(-12/(H/1000)) + 0.015);
EI = 3088;

co2mass =  EI*wf*1000/pmax/12000

T02 = stag_temp(0.85,9.5);
EInox = NOx(T02, teff, OPR);

noxmass = EInox *wf* 1000*15.1*2/pmax/12000