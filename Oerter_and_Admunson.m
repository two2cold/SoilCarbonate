%% Checking the diffusion file with data reported in O&D 2016
clear;
workingDir = '/Users/yuchenliu/Dropbox/Soil d13C model/Datasets/MasterCompilation_d13Cproject.xlsx';
spreadSheetName = 'Oerter and Amundson';

%% Parameter values
porosity = 0.5;

%% Read data from excel
% Moisture profile
moistureDepthProfile = [10 25 50 100]';
moistureProfileRaw = cell(1,4);
moistureProfileRaw{1} = xlsread(workingDir,spreadSheetName,'B4:M7'); % site A
moistureProfileRaw{2} = xlsread(workingDir,spreadSheetName,'B11:M14'); % site B
moistureProfileRaw{3} = xlsread(workingDir,spreadSheetName,'B18:M21'); % site C
moistureProfileRaw{4} = xlsread(workingDir,spreadSheetName,'B25:M28'); % site D

% Carbon isotope profile
carbonateIsotopeRaw = xlsread(workingDir,spreadSheetName,'B33:D62');

% Soil gas CO2 concentration and isotope profile
CO2Raw = xlsread(workingDir,spreadSheetName,'P3:AE29');

%% Data rearrangement
% Moisture profile {seasons,[ave max min],sites}
moistureProfile = cell(4,3,4);
for i=1:4 % Combine moisture profiles of 4 sites (4 columns) at different season
    for j=1:3
        for k=1:4
            moistureProfile{i,j,k} = moistureProfileRaw{k}(:,(i-1)*3+j);
        end
    end
end

% Carbon isotope profile {sites}
carbonateIsotope = cell(1,4);
carbonateIsotope{1} = carbonateIsotopeRaw(1:10,:);
carbonateIsotope{2} = carbonateIsotopeRaw(11:18,:);
carbonateIsotope{3} = carbonateIsotopeRaw(19:25,:);
carbonateIsotope{4} = carbonateIsotopeRaw(26:30,:);

% Soil gas CO2 profile {months,[temp d13C pCO2],sites}
CO2DepthProfile = cell(1,4);
CO2 = cell(5,3,4);
CO2DepthProfile{1} = CO2Raw(1:12,1);
CO2DepthProfile{2} = CO2Raw(13:17,1);
CO2DepthProfile{3} = CO2Raw(18:22,1);
CO2DepthProfile{4} = CO2Raw(23:27,1);
for i=1:5
    for j=1:3
        CO2{i,j,1} = CO2Raw(1:12,(i-1)*3+j+1);
        CO2{i,j,2} = CO2Raw(13:17,(i-1)*3+j+1);
        CO2{i,j,3} = CO2Raw(18:22,(i-1)*3+j+1);
        CO2{i,j,4} = CO2Raw(23:27,(i-1)*3+j+1);
    end
end

%% CO2 concentration and d13C profile calculation
CO2Calculated = cell(4,2,4,3); % {seasons,[max min],sites,[our C&Q diffusivityOnly]}
CO2IsotopeCalculated = cell(4,2,4,3); % {seasons,[max min],sites,[our C&Q diffusivityOnly]}
surfaceFlux = cell(4,2,4,3); % {seasons,[max min],sites,[our C&Q diffusivityOnly]}
maxRespirationRate = [0.7,2,2;0.1,0.45,0.3;0.15,0.6,0.5;0.2,0.9,0.6]; % [sites,[our C&Q diffusivityOnly]]
% [0.7,2,2;0.1,0.45,0.3;0.15,0.6,0.5;0.2,0.9,0.6] for peakPosition = 0.6
% [0.5,1.6,1.5;0.072,0.35,0.22;0.11,0.5,0.35;0.15,0.7,0.44] for peakPosition = 0.3
% [1.2,3.5,3.5;0.18,0.75,0.48;0.27,0.95,0.75;0.32,1.35,0.95] for peakPosition = 1.2
isotopeRespired = [-17,-25,-25,-25]; % Four sites
for i=1:4 % seasons
    for j=1:2 % [max min]
        for k=1:4 % sites
            for l=1:3 % options
                [CO2Calculated{i,j,k,l},CO2IsotopeCalculated{i,j,k,l},surfaceFlux{i,j,k,l}] = ...
                    diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{i,j+1,k}/porosity,400,-6.5,isotopeRespired(k),0.6,maxRespirationRate(k,l),0,l);
            end
        end
    end
end

% Calculating annual surface flux
surfaceAnnual = zeros(2,4,3);
for i=1:4
    for j=1:3
        surfaceAnnual(1,i,j) = (surfaceFlux{1,1,i,j}+surfaceFlux{2,1,i,j}+surfaceFlux{3,1,i,j}+surfaceFlux{4,1,i,j})/4;
        surfaceAnnual(2,i,j) = (surfaceFlux{1,2,i,j}+surfaceFlux{2,2,i,j}+surfaceFlux{3,2,i,j}+surfaceFlux{4,2,i,j})/4;
    end
end

%% Plotting three figures representing DR, CQ, and DO model output respectively
for j=1:3
    figure;
    for i=1:4
        subplot(2,2,i);
        plot(CO2{1,2,i},CO2DepthProfile{i},'*g','MarkerSize',12,'LineWidth',3); hold on;
        plot(CO2{2,2,i},CO2DepthProfile{i},'+b','MarkerSize',12,'LineWidth',3);
        plot(CO2{3,2,i},CO2DepthProfile{i},'^r','MarkerSize',12,'LineWidth',3);
        plot(CO2{4,2,i},CO2DepthProfile{i},'og','MarkerSize',12,'LineWidth',3);
        plot(CO2{5,2,i},CO2DepthProfile{i},'sg','MarkerSize',12,'LineWidth',3);
        plot(CO2IsotopeCalculated{2,1,i,j},1:max(moistureDepthProfile),'-g','LineWidth',3); 
        plot(CO2IsotopeCalculated{2,2,i,j},1:max(moistureDepthProfile),'--g','LineWidth',3);
        plot(CO2IsotopeCalculated{3,1,i,j},1:max(moistureDepthProfile),'-b','LineWidth',3); 
        plot(CO2IsotopeCalculated{3,2,i,j},1:max(moistureDepthProfile),'--b','LineWidth',3);
        plot(CO2IsotopeCalculated{4,1,i,j},1:max(moistureDepthProfile),'-r','LineWidth',3); 
        plot(CO2IsotopeCalculated{4,2,i,j},1:max(moistureDepthProfile),'--r','LineWidth',3);
        set(gca,'ydir','reverse');
        set(gca,'fontsize',18);
        set(gca, 'FontName', 'Times New Roman');
        xlabel('Soil d13C (VPDB)','FontSize',21);
        ylabel('Depth (cm)','FontSize',21);
        set(gca,'XColor','k');
        set(gca,'YColor','k');
        set(gca,'box','off');
    end
end

%% Hypothetical moisture profile (sensitivity analysis)
% Intercept 0 - 0.2
% peakPosition 0.3 - 1.2
% [conc1a,iso1a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,0.3,0.7,0,1);
% [conc2a,iso2a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,0.3,2.0,0,2);
% [conc3a,iso3a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,0.3,2.0,0,3);
% [conc4a,iso4a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,0.6,0.7,0,1);
% [conc5a,iso5a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,0.6,2.0,0,2);
% [conc6a,iso6a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,0.6,2.0,0,3);
% [conc7a,iso7a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,1.2,0.7,0,1);
% [conc8a,iso8a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,1.2,2.0,0,2);
% [conc9a,iso9a,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,1,1}/porosity,400,-6.5,-17,1.2,2.0,0,3);
% 
% [conc1b,iso1b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,0.3,0.7,0,1);
% [conc2b,iso2b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,0.3,2.0,0,2);
% [conc3b,iso3b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,0.3,2.0,0,3);
% [conc4b,iso4b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,0.6,0.7,0,1);
% [conc5b,iso5b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,0.6,2.0,0,2);
% [conc6b,iso6b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,0.6,2.0,0,3);
% [conc7b,iso7b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,1.2,0.7,0,1);
% [conc8b,iso8b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,1.2,2.0,0,2);
% [conc9b,iso9b,~] = diffusion_with_two_isotopes_func(moistureDepthProfile,moistureProfile{1,2,1}/porosity,400,-6.5,-17,1.2,2.0,0,3);
% iso1 = (iso1a + iso1b)/2;
% iso2 = (iso2a + iso2b)/2;
% iso3 = (iso3a + iso3b)/2;
% iso4 = (iso4a + iso4b)/2;
% iso5 = (iso5a + iso5b)/2;
% iso6 = (iso6a + iso6b)/2;
% iso7 = (iso7a + iso7b)/2;
% iso8 = (iso8a + iso8b)/2;
% iso9 = (iso9a + iso9b)/2;
% figure;
% for i=1:4
%     plot(CO2{1,2,i},CO2DepthProfile{i},'*g','MarkerSize',12,'LineWidth',3); hold on;
% %         plot(CO2{2,2,i},CO2DepthProfile{i},'+b','MarkerSize',12,'LineWidth',3);
% %         plot(CO2{3,2,i},CO2DepthProfile{i},'^r','MarkerSize',12,'LineWidth',3);
%     plot(CO2{4,2,i},CO2DepthProfile{i},'og','MarkerSize',12,'LineWidth',3);
%     plot(CO2{5,2,i},CO2DepthProfile{i},'sg','MarkerSize',12,'LineWidth',3);
% end
% plot(iso1,1:100,'--r','LineWidth',3); hold on;
% plot(iso2,1:100,'--b','LineWidth',3); hold on;
% plot(iso3,1:100,'--k','LineWidth',3); hold on;
% plot(iso4,1:100,'r','LineWidth',3); 
% plot(iso5,1:100,'b','LineWidth',3);
% plot(iso6,1:100,'k','LineWidth',3);
% plot(iso7,1:100,'.r','LineWidth',3); 
% plot(iso8,1:100,'.b','LineWidth',3);
% plot(iso9,1:100,'.k','LineWidth',3);
% set(gca,'ydir','reverse');
% set(gca,'fontsize',18);
% set(gca, 'FontName', 'Times New Roman');
% xlabel('Soil d^{13}C (VPDB)','FontSize',21);
% ylabel('Depth (cm)','FontSize',21);
% set(gca,'XColor','k');
% set(gca,'YColor','k');
% set(gca,'box','off');
% % legend('DR model, peak position = 0.3','CQ model, peak position = 0.3','DIFF model, peak position = 0.3',...
% %     'DR model, peak position = 0.6','CQ model, peak position = 0.6','DIFF model, peak position = 0.6',...
% %     'DR model, peak position = 1.2','CQ model, peak position = 1.2','DIFF model, peak position = 1.2')
% % % legend('DR model, c=0','CQ model, c=0','DO model, c=0', ...
% % %     'DR model, c=0.2','CQ model, c=0.2','DO model, c=0.2')