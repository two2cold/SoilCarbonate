%% Carbon speciation test
clear;

%% CO2 concentration input
CO2g = 2500; % [ppmV]
CO2g = CO2g/10^6; % [atm]

%% Calculate carbon speciation
% Assume a pH range
low = 0;
high = 14;

% Calculate the concentrations of different carbon speciation for the 
% low and high pH assumed using function specC
[H,CO2aq,H2CO3,HCO3,CO3,Ca,OH] = specC(CO2g,low);
lowSpeciation = [H,CO2aq,H2CO3,HCO3,CO3,Ca,OH];
[H,CO2aq,H2CO3,HCO3,CO3,Ca,OH] = specC(CO2g,high);
highSpeciation = [H,CO2aq,H2CO3,HCO3,CO3,Ca,OH];

% Check if the pH range covers the actual pH
if lowSpeciation(1) + 2*lowSpeciation(6) < lowSpeciation(4) + 2*lowSpeciation(5) + lowSpeciation(7) || highSpeciation(1) + 2*highSpeciation(6) > highSpeciation(4) + 2*highSpeciation(5) + highSpeciation(7)
    error('pH range not large enough');
end

while true
    % Using dichotomizing method to figure out the real pH
    [H,CO2aq,H2CO3,HCO3,CO3,Ca,OH] = specC(CO2g,(high + low)/2);
    midSpeciation = [H,CO2aq,H2CO3,HCO3,CO3,Ca,OH];
    
    % Check the charge balance
    if abs(midSpeciation(1) + 2*midSpeciation(6) - (midSpeciation(4) + 2*midSpeciation(5) + midSpeciation(7))) < 1E-14
        break
    end
    
    % Use charge balance to update pH
    if midSpeciation(1) + 2*midSpeciation(6) < midSpeciation(4) + 2*midSpeciation(5) + midSpeciation(7)
        high = (high + low)/2;
        highSpeciation = midSpeciation;
    else
        low = (high + low)/2;
        lowSpeciation = midSpeciation;
    end
end

%% Output
pH = -log10(midSpeciation(1))