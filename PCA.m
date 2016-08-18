function [V1,V2,V3,pca_3d] = PCA(features,normal_features)
% Perform Principal Component Analysis on the features 
% Mean normalization and feature scaling 
features = features(:,1:3); % Discard the ground truth column
mean_substracted = (features - repmat(mean(features,1),size(features,1),1));
features_scaled =mean_substracted./repmat(std(features,1),size(features,1),1);
% Perform PCA
coeff = pca(features_scaled);
V1 = coeff(:,1); V2 = coeff(:,2); V3 = coeff(:,3);
% Project the features data into the new coordinate space 
m = size(features_scaled,1);
n = size(features_scaled,2);
pca_3d = zeros(m,n); 
for i = 1:m
    pca_3d(i,:) = [dot(V1,features_scaled(i,:)) dot(V2,features_scaled(i,:)) dot(V3,features_scaled(i,:))];
end
% Plot pca results 
figure
quiver3(0,0,0,V1(1),V1(2),V1(3),'color','m');
hold on; 
quiver3(0,0,0,V2(1),V2(2),V2(3),'color','g');
quiver3(0,0,0,V3(1),V3(2),V3(3),'color','k');
n = size(normal_features,1); 
plot3(pca_3d(1:n,1),pca_3d(1:n,2),pca_3d(1:n,3),'bx') % normal
plot3(pca_3d(n+1:end,1),pca_3d(n+1:end,2),pca_3d(n+1:end,3),'rx') % cancer
legend('V1','V2','V3','normal','cancer')
xlabel('PCA1'); ylabel('PCA2'); zlabel('PCA3')
limits = [-2 2]; % Modify if necessary
xlim(limits)
ylim(limits)
zlim(limits)
end

