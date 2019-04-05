%% Import data from OtherPaperRespRates.xlsx
clear;

%% Read data
workingDir = '~/Documents/Works/Papers/4. How does changing soil moisture/';
rawData = xlsread([workingDir,'Tables.xlsx'],'Table S1','B2:C265');
WHC = rawData(:,1);
respRate = rawData(:,2);
WHC_range = 0.01:0.01:1;
par = [-3.427 4.042]; % par[1]*x^2 + par[2]*x = y, regression line
par_low = [-4.092 3.567];
par_high = [-2.763 4.518];

%% Plotting 
plot(WHC,respRate,'*'); hold on;
plot(WHC_range,par(1)*WHC_range.^2+par(2)*WHC_range);
plot(WHC_range,par_low(1)*WHC_range.^2+par_low(2)*WHC_range);
plot(WHC_range,par_high(1)*WHC_range.^2+par_high(2)*WHC_range);