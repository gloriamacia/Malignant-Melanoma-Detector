function[] = Visualize(features,n)
% This function plots the extracted feature so that patterns in the data
% can be observed (e.g.using the sample data, there seems to be a
% correlation between Nuclei count and NCR). 

figure
subplot(2,2,1)
plot3(features(1:n,1),features(1:n,2),features(1:n,3),'x')
hold on; 
plot3(features(n+1:end,1),features(n+1:end,2),features(n+1:end,3),'rx')
xlabel('NCR'); ylabel('Nuclei Count'); zlabel('Size Var'); 
grid on

subplot(2,2,2)
scatter(features(1:n,1),features(1:n,2),'x')
hold on;
scatter(features(n+1:end,1),features(n+1:end,2),'rx')
xlabel('NCR'); ylabel('Nuclei Count');
legend('Normal','Cancer','Location','NorthEast')

subplot(2,2,3)
scatter(features(1:n,2),features(1:n,3),'x')
hold on;
scatter(features(n+1:end,2),features(n+1:end,3),'rx')
xlabel('Nuclei Count'); ylabel('Size Var')

subplot(2,2,4)
scatter(features(1:n,1),features(1:n,3),'x')
hold on;
scatter(features(n+1:end,1),features(n+1:end,3),'rx')
xlabel('NCR'); ylabel('Size Var')

end

