%% Plot speed vs. force

force20 = [1.75e-4 3.77e-4 5.79e-4];
force24 = [2.24e-4 4.65e-4 0.00e-4];
force30 = [7.49e-4 1.60e-3 2.30e-3];
velocity = [20 40 60];

force20FitParams = polyfit(velocity,force20,1);
force24FitParams = polyfit(velocity,force24,1);
force30FitParams = polyfit(velocity,force30,1);

force20Fit = @(v) force20FitParams(1).*v + force20FitParams(2);
force24Fit = @(v) force24FitParams(1).*v + force24FitParams(2);
force30Fit = @(v) force30FitParams(1).*v + force30FitParams(2);

color20 = [207 54 54]./255;
color24 = [62 146 70]./255;
color30 = [51 103 207]./255;
textColor = [36 36 36]./255;

figure('Position',[100 100 800 600])
hold on;
fplot(force20Fit,[0 100],'--','Color',color20)
fplot(force24Fit,[0 100],'--','Color',color24)
fplot(force30Fit,[0 100],'--','Color',color30)
plot(velocity, force20,'o','MarkerSize',12,'MarkerEdgeColor',color20,'MarkerFaceColor',color20)
plot(velocity, force24,'o','MarkerSize',12,'MarkerEdgeColor',color24,'MarkerFaceColor',color24)
plot(velocity, force30,'o','MarkerSize',12,'MarkerEdgeColor',color30,'MarkerFaceColor',color30)
axis([0 80 0 2.5e-3])
title('Effect of Piston Velocity on Damping Force','Color',textColor)
xlabel('Piston Velocity [mm/s]','Color',textColor)
ylabel('Damping Force [N-m^2/kg]','Color',textColor)
legend('30mm Piston','24mm Piston','20mm Piston','location','NW')
set(gca,'FontName','Lato','FontSize',18,'XColor',textColor,'YColor',textColor)

%% Plot force vs. piston width

force20 = [1.75e-4 2.24e-4 7.49e-4];
force40 = [3.77e-4 4.65e-4 1.60e-3];
force60 = [5.79e-4 0.00e-4 2.30e-3];
width = [20 24 30];

force20FitParams = polyfit(width,force20,2);
force40FitParams = polyfit(width,force40,2);
force60FitParams = polyfit(width,force60,2);

force20Fit = @(w) force20FitParams(1).*w.^2 + force20FitParams(2).*w + force20FitParams(3);
force40Fit = @(w) force40FitParams(1).*w.^2 + force40FitParams(2).*w + force40FitParams(3);
force60Fit = @(w) force60FitParams(1).*w.^2 + force60FitParams(2).*w + force60FitParams(3);

color20 = [207 54 54]./255;
color40 = [62 146 70]./255;
color60 = [51 103 207]./255;
textColor = [36 36 36]./255;

figure('Position',[100 100 900 600])
hold on
% fplot(force20Fit,[10 50],'--','Color',color20)
% fplot(force40Fit,[10 50],'--','Color',color40)
% fplot(force60Fit,[10 50],'--','Color',color60)
plot(width, force20,'-o','Color',color20,'MarkerSize',12,'MarkerEdgeColor',color20,'MarkerFaceColor',color20)
plot(width, force40,'-o','Color',color40,'MarkerSize',12,'MarkerEdgeColor',color40,'MarkerFaceColor',color40)
plot(width, force60,'-o','Color',color60,'MarkerSize',12,'MarkerEdgeColor',color60,'MarkerFaceColor',color60)
axis([15 35 0 2.5e-3])
title('Effect of Piston Width on Damping Force','Color',textColor)
xlabel('Piston Width [mm]','Color',textColor)
ylabel('Damping Force [N-m^2/kg]','Color',textColor)
legend('20mm/s Piston Velocity','40mm/s Piston Velocity','60mm/s Piston Velocity','location','NW');
set(gca,'FontName','Lato','FontSize',18,'XColor',textColor,'YColor',textColor)



