function [H,CO2aq,H2CO3,HCO3,CO3,Ca,OH] = specC(CO2g,pH)
% This function uses CO2(g) concentration and assumed pH to calculate the
% concentration of different carbon species assuming instantaneous
% equilibrium with CO2(g) and CaCO3(s).
% Results are not charge balanced. 
% This function is further used in Carbon_speciation to calculate the
% charge balanced concentration of different carbon species.
% CO2g is the partial pressure of CO2(g) in the air [atm]
% pH is the assumed pH of the solution.

%% Parameter input
kdis = 29.76; % [mol/atm/L], CO2(aq) = CO2(g)
kh = 1.7E-3; % [-], H2O + CO2(aq) = H2CO3
k1 = 2.5E-4; % [mol/L], H2CO3 = HCO3- + H+
k2 = 5.61E-11; % [mol/L], HCO3- = CO3-- + H+
ksp = 4.47E-9; % [mol^2/L^2], CaCO3 = CO3-- + Ca++
kw = 1E-14; % [mol^2/L^2], H2O = H+ + OH-

%% Calculation
% Assuming constant equilibrium with CO2(g) and CaCO3(s)
H = 10.^-pH;
CO2aq = CO2g./kdis;
H2CO3 = CO2aq.*kh;
HCO3 = k1*H2CO3./H;
CO3 = k2*HCO3./H;
Ca = ksp./CO3;
OH = kw./H;

end