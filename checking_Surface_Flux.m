%% Checking surface flux calculation
clear;

%% Calculation
soilProfile = 1:100; % [cm]
maxResp = 0.2; % [ug/cm3/hour]
respProfile = maxResp*exp(-soilProfile/20);
sum(respProfile); % [ug/cm2/hour]
sum(respProfile)/1000000*10000*24*365; % [g/m2/year]