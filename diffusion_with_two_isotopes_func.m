function [concentrationCO2,resultDelta,surfaceFlux] = diffusion_with_two_isotopes_func(depth,moisture,concAir,deltaAir,deltaRespired,peakPosition,peakValue,intercept,options)
    % This is a diffusion code with two isotopes.
    % depth represent the corresponding depth of the soil effective saturation profile;
    % moisture represent the soil effective saturation profile;
    % concAir represent the air CO2 concentration;
    % deltaAir represent the d13C of the air CO2;
    % deltaRespired represent the d13C of the respired CO2;
    % peakPosition represent the effective saturation when soil reaches its maximum respiration rate;
    % peakValue represent the peak respiration rate of the soil [ug/cm3/h];
    % intercept represent the intercept of the polynomial that illustrate the correlation between respiration rate and soil moisture;
    % options represent the three options this code has: 1. our model, 2. the C&Q model, 3. soil moisture sensitivity in diffusivity only.
    %% Parameter
    z = max(depth); % Domain size [cm]
    dz = 1; % Grid size [cm]
    D1 = 0.14*0.5*0.6; % Diffusivity of 12C [cm^2/s]
    D2 = D1/1.0044; % Diffusivity of 13C [cm^2/s] (Cerling and Quade, 1993)
    isotopeRatioRef = 0.011; % Ratio of 13C/12C in reference material
    
    %% Checks
    if size(depth)~=size(moisture)
        error('Input depth scalar and moisture scalar are not consistant');
    end
    if size(depth,1)==1
        depth = depth';
    end
    if size(moisture,1)==1
        moisture = moisture';
    end
    if depth(1)~=0
        depth = [0;depth];
        moisture = [moisture(1);moisture];
    end
    
    %% Fitting moisture profile (PCHIP)
    moisture = pchip(depth,moisture,1:z);
    if options==1 || options==3
        D1 = D1*(1 - moisture);
        D2 = D2*(1 - moisture);
    else
        D1(1:length(moisture)) = D1;
        D2(1:length(moisture)) = D2;
    end

    %% Calculate polynomial
    if peakPosition<0.5
        % When peakPosition is lower than 0.5, fix the curve at (1,0)
        coeff_a = (peakValue-intercept)/(peakPosition^2-peakPosition);
        coeff_b = -coeff_a;
    else
        coeff_a = -(peakValue-intercept)/peakPosition^2; % the coefficient in polynomial a*Se^2 + b*Se + c= respiration rate
        coeff_b = -2*peakPosition*coeff_a; % the coefficient in polynomial a*Se^2 + b*Se + c= respiration rate
    end
    R_total = zeros(1,length(moisture));
    surfaceFlux = 0;
    zstar = 25;
    for i=1:length(moisture) % Calculate the respiration rate using the polynomial and the inputed soil moisture profile
        % Convert from ug/cm3/hour to ppm/s
        R_total(i) = (coeff_a*moisture(i)^2 + coeff_b*moisture(i) + intercept)*exp(-i/zstar)*24.22*1000/12/3600; 
        % Convert back to ug/cm2/hour and then convert to g/m2/year
        surfaceFlux = surfaceFlux + R_total(i)/24.22/1000*12*3600/1000000*10000*24*365; 
    end
    if options==2 || options==3 
        surfaceFlux = 0;
        % For options 2 and 3, the respiration rate is calculated as an exponential decrease from the maximum value at the top of the profile
        for i=1:length(moisture)
            % Convert from ug/cm3/hour to ppm/s
            R_total(i) = max(R_total)*exp(-i/zstar)*24.22*1000/12/3600;
            % Convert back to ug/cm2/hour and then convert to g/m2/year
            surfaceFlux = surfaceFlux + R_total(i)/24.22/1000*12*3600/1000000*10000*24*365;
        end
    end

    %% Main
    q1 = -D1/dz^2;
    matrix1 = TriDiag(q1,-2*q1,q1); % Creating a tridiag matrix for 12C
    matrix1(z,z) = -q1(z);
    R1 = R_total'/(DeltaToRatio(deltaRespired,isotopeRatioRef)+1); % Calculating the respiration profile for 12C
    R1(1) = R1(1) - q1(1)*concAir/(DeltaToRatio(deltaAir,isotopeRatioRef)+1);
    result1 = matrix1\R1; % Calculating the 12C concentration profile

    q2 = -D2/dz^2;
    matrix2 = TriDiag(q2,-2*q2,q2); % Creating a tridiag matrix for 13C
    matrix2(z,z) = -q2(z);
    R2 = R_total'*(1-1/(DeltaToRatio(deltaRespired,isotopeRatioRef)+1)); % Calculating the respiration profile for 13C
    R2(1) = R2(1) - q2(1)*concAir*(1-1/(DeltaToRatio(deltaAir,isotopeRatioRef)+1));
    result2 = matrix2\R2; % Calculating the 13C concentration profile
    
    concentrationCO2 = result1 + result2;
    if options==1 || options==3
        resultDelta = RatioToDelta(result2./result1,isotopeRatioRef);
    elseif options==2
        concentrationCO2 = concentrationCO2 - concAir;
        resultDelta = (concentrationCO2*1.0044*deltaRespired+4.4*concentrationCO2+concAir*deltaAir)./(concentrationCO2+concAir);
    end
end

%% Additional functions
function value = TriDiag(a,b,c)
    value = zeros(length(a),length(a));
    for i = 1:length(a)-1
        value(i+1,i) = a(i+1);
        value(i,i) = b(i);
        value(i,i+1) = c(i);
    end
    value(length(a),length(a)) = b(end);
end

function ratio = DeltaToRatio(deltaValue,refereceRatio)
    ratio = ((deltaValue/1000)+1)*refereceRatio;
end

function delta = RatioToDelta(ratioValue,referenceRatio)
    delta = (ratioValue/referenceRatio-1)*1000;
end