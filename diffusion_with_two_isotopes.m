%% Pure diffusion code with two isotopes
clear;

%% Input parameter
z = 100; % Domain size [cm]
dz = 1; % Grid size [cm]
D1 = 0.16; % Diffusivity of 12C [cm^2/s]
D2 = D1/1.0044; % Diffusivity of 13C [cm^2/s] (Cerling and Quade, 1993)
isotopeRatioRef = 0.011; % Ratio of 13C/12C in reference material
mass12C = 12; % Mass of 12C
mass13C = 13; % Mass of 13C
massO = 16; % Mass of O
pH = 6.5; % pH of the soil profile

deltaRespired = -30; % permil
deltaAir = -6; % permil
moisture = 0.01:0.01:1; % Set moisture profile

%% Calculate polynomial
peakPosition = 0.6; % Peak position of the reaction rate polynomial (Se [-])
peakValue = 1; % Peak respiration rate [mol/m^3/hour]
intercept = 0;
coeff_a = -(peakValue-intercept)/peakPosition^2; % the coefficient in polynomial a*Se^2 + b*Se + c= respiration rate
coeff_b = -2*peakPosition*coeff_a; % the coefficient in polynomial a*Se^2 + b*Se + c= respiration rate
R_total = coeff_a*moisture.^2 + coeff_b*moisture + intercept;
% R_total = zeros(1,length(moisture));
% R_total(1:100) = 1; 

%% Initial condition
c0 = 400; % Initial condition and upper boundary condition [ppm]

%% Main
q1 = -D1/dz^2;
matrix1 = TriDiag(q1,-2*q1,q1,z);
matrix1(z,z) = -q1;
R1 = R_total'/(DeltaToRatio(deltaRespired,isotopeRatioRef)+1);
R1(1) = R1(1) - q1*c0/(DeltaToRatio(deltaAir,isotopeRatioRef)+1);
result1 = matrix1\R1;
% C12test = c0/(DeltaToRatio(deltaAir,isotopeRatioRef)+1)
% C13test = c0*(1-1/(DeltaToRatio(deltaAir,isotopeRatioRef)+1))
% RatioToDelta(C13test/C12test,isotopeRatioRef)

q2 = -D2/dz^2;
matrix2 = TriDiag(q2,-2*q2,q2,z);
matrix2(z,z) = -q2;
R2 = R_total'*(1-1/(DeltaToRatio(deltaRespired,isotopeRatioRef)+1));
R2(1) = R2(1) - q2*c0*(1-1/(DeltaToRatio(deltaAir,isotopeRatioRef)+1));
result2 = matrix2\R2;

CO2concentration = result1 + result2;
[H,CO2aq,H2CO3,HCO3,CO3,Ca,OH] = specC(CO2concentration,pH);

resultDelta = RatioToDelta(result2./result1,isotopeRatioRef);
plot(resultDelta);hold on;

%% Additional functions
function value = TriDiag(a,b,c,size)
    value = zeros(size,size);
    for i = 1:size-1
        value(i+1,i) = a;
        value(i,i) = b;
        value(i,i+1) = c;
    end
    value(size,size) = b;
end

function ratio = DeltaToRatio(deltaValue,refereceRatio)
    ratio = ((deltaValue/1000)+1)*refereceRatio;
end

function delta = RatioToDelta(ratioValue,referenceRatio)
    delta = (ratioValue/referenceRatio-1)*1000;
end