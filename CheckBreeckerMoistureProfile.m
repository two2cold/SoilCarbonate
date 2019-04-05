%% Apply same moisture profile to three models and check the CO2 concentration profile
clear;

%% Input parameters
depthProfile = 1:100; % cm
% moistureProfile = 0.1:0.005:0.595; % 100 cm profile from WHC 0.1 to 0.595
% moistureProfile = 0.1:0.003:0.397; % Sensitivity analysis
moistureProfile = 0.1:0.009:0.991; % Sensitivity analysis
concAir = 400; % ppm
deltaAir = -6.5; % permil
deltaRespired = -22; % permil
peakPosition = 0.6; % [-]
% peakValueCQ = 2; % ug/cm3/h
% peakValueDR = 0.4825; % ug/cm3/h
intercept = 0; % ug/cm3/h

%% Calculation
surfaceFlux = 314;
CO2DR = FitSurfaceFlux(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,intercept,1,surfaceFlux,50);
CO2CQ = FitSurfaceFlux(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,intercept,2,surfaceFlux,50);
CO2DIFF = FitSurfaceFlux(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,intercept,3,surfaceFlux,50);

%% Functions used
function concCO2 = FitSurfaceFlux(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,intercept,options,surfaceFlux,targetDepth)
    % Input a soil carbon surface flux, and calculate the peakValue using a dichotomized algorism
    % options represents different models (1 for DR, 2 for CQ, 3 for DIFF)
    % surfaceFlux represents the targeted surface flux [g/m2/year]
    % targetDepth represents the concentration of CO2 at the depth of the soil profile that this function returns
    % Other parameters used are identical to function diffusion_with_two_isotopes_func
    minPeakValue = 0; % Specify the minimum RespRate in this search [ug/cm3/h]
    maxPeakValue = 10; % Specify the maximum RespRate in this search [ug/cm3/h]
    % Test to see if the targeted depth lies within the range of our profile
    if targetDepth<min(depthProfile) || targetDepth>max(depthProfile)
        error('Targeted depth out of the soil profile');
    end
    % Test to see if min and max value cover our target
    [~,~,minFluxTest] = diffusion_with_two_isotopes_func(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,minPeakValue,intercept,options);
    [~,~,maxFluxTest] = diffusion_with_two_isotopes_func(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,maxPeakValue,intercept,options);
    if minFluxTest>surfaceFlux
        error('Minimum surface flux specified is larger than target');
    end
    if maxFluxTest<surfaceFlux
        error('Maximum surface flux specified is lower than target');
    end
    % Start the dichotomy 
    while true
        % Calculate the respiration flux at the middle point
        midPeakValue = (minPeakValue + maxPeakValue)/2;
        [~,~,fluxTemp] = diffusion_with_two_isotopes_func(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,midPeakValue,intercept,options);
        % Set the ending point
        tolerance = 0.1;
        if abs(fluxTemp - surfaceFlux)<tolerance
            break;
        end
        if fluxTemp>surfaceFlux
            maxPeakValue = midPeakValue;
        else
            minPeakValue = midPeakValue;
        end
    end
    [concProfile,~,~] = diffusion_with_two_isotopes_func(depthProfile,moistureProfile,concAir,deltaAir,deltaRespired,peakPosition,midPeakValue,intercept,options);
    concCO2 = concProfile(targetDepth-min(depthProfile)+1);
end
    
