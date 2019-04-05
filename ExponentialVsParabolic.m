%% Plotting exponential decrease vs parabolic
clear;

%% Set up the parabolic
moisture = 0.1:0.01:1;
peakValue = 2;
peakPosition = 0.6;
intercept = 0;
coeff_a = -(peakValue-intercept)/peakPosition^2; % the coefficient in polynomial a*Se^2 + b*Se + c= respiration rate
coeff_b = -2*peakPosition*coeff_a; % the coefficient in polynomial a*Se^2 + b*Se + c= respiration rate
R_para = zeros(1,length(moisture));
R_total_para = zeros(1,length(moisture));
R_total_exp = zeros(1,length(moisture));
for i=1:length(moisture)
    R_para(i) = (coeff_a*moisture(i)^2 + coeff_b*moisture(i) + intercept);
    R_total_para(i) = R_para(i)*exp(-i/25);
end
for i=1:length(moisture)
    R_total_exp(i) = max(R_total_para)*exp(-i/25);
end

%% Plotting
plot(R_total_para,1:length(moisture),'r','LineWidth',3); hold on;
plot(R_total_exp,1:length(moisture),'b','LineWidth',3);
set(gca,'ydir','reverse');
set(gca,'fontsize',18);
set(gca, 'FontName', 'Times New Roman');
xlabel('Soil respiration rate [g-C/m3/h]','FontSize',21);
ylabel('Depth (cm)','FontSize',21);
set(gca,'XColor','k');
set(gca,'YColor','k');
set(gca,'box','off');
legend('Parabolic','Constant');
