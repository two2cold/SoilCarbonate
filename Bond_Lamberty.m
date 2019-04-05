%% Bond-Lamberty dataset
% clear;

%% Import data
workingDir = "~/Documents/Works/Papers/4. How does changing soil moisture/GLOBAL_SRDB_V3_1235/srdb-data-V3.xlsx";
MAP = xlsread(workingDir,'srdb-data-V3','AF2:AF5174');
Rs_annual = xlsread(workingDir,'srdb-data-V3','AN2:AN5174');
% Delete NaN
i = 1;
while true
    if length(MAP)<i
        break;
    end
    if isnan(MAP(i)) || isnan(Rs_annual(i)) || Rs_annual(i)<0
        MAP(i) = [];
        Rs_annual(i) = [];
        continue;
    end
    i = i+1;
end

%% Try linear fitting respiration rate with MAP under 300
MAP_selected = [];
Rs_annual_selected = [];
for i=1:length(MAP)
    if MAP(i)<=500
        MAP_selected = [MAP_selected MAP(i)];
        Rs_annual_selected = [Rs_annual_selected Rs_annual(i)];
    end
end
paramsLinear_selected = MAP_selected'\Rs_annual_selected';
% paramsLinear_selected = FitLinear(MAP_selected,Rs_annual_selected); % intercept~=0
paramsLinear = [0.238947174150511,517.676487636691];
paramsParabolic = [-6.47064799455760e-05,0.500212678161730,338.587640794779];

%% AIC calculation
RSSLinear = 0;
RSSParabolic = 0;
for i=1:length(MAP)
    RSSLinear = RSSLinear + (paramsLinear(1)*MAP(i) + paramsLinear(2) - Rs_annual(i))^2;
    RSSParabolic = RSSParabolic + (paramsParabolic(1)*MAP(i)^2 + paramsParabolic(2)*MAP(i) + paramsParabolic(3) - Rs_annual(i))^2;
end
AICLinear = length(MAP)*log(RSSLinear/length(MAP)) + 2*2;
AICParabolic = length(MAP)*log(RSSParabolic/length(MAP)) + 2*3;

%% Plotting
plot(MAP,Rs_annual,'.','color',[.7 .7 .7]); hold on;
% plot([0 max(MAP)],[paramsLinear(2) paramsLinear(1)*max(MAP)+paramsLinear(2)],'b','LineWidth',2);
% plot(0:max(MAP),paramsParabolic(1)*(0:max(MAP)).^2+paramsParabolic(2)*(0:max(MAP))+paramsParabolic(3),'k','LineWidth',2);
plot([78 78],surfaceAnnual(:,1,2),'b*-',[134 134],surfaceAnnual(:,2,2),'b*-',[178 178],surfaceAnnual(:,3,2),'b*-',[214 214],surfaceAnnual(:,4,2),'b*-','LineWidth',2);
plot([78 78],surfaceAnnual(:,1,3),'g*-',[134 134],surfaceAnnual(:,2,3),'g*-',[178 178],surfaceAnnual(:,3,3),'g*-',[214 214],surfaceAnnual(:,4,3),'g*-','LineWidth',2);
plot([78 78],surfaceAnnual(:,1,1),'r*-',[134 134],surfaceAnnual(:,2,1),'r*-',[178 178],surfaceAnnual(:,3,1),'r*-',[214 214],surfaceAnnual(:,4,1),'r*-','LineWidth',2);
plot(0:300,paramsLinear_selected*(0:300),'k','LineWidth',2);
% legend('Bond-Lamberty dataset','Linear regression, R^2=0.1461','Quadratic regression, R^2=0.1694');
legend('CQ model','DO model','DR model');
set(gca,'box','off');
set(gca, 'FontName', 'Times New Roman');
set(gca,'FontSize',18);
xlim([0 600]);
xlabel('MAP (mm)');
ylabel('Annual C flux (g-C/m^2/yr)');