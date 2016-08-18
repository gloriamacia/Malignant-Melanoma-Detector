clc; close all; clear all;
%%
% UPLOAD TRAINING IMAGES & EXTRACT FEATURES 
% Specify the folder where NORMAL samples are.
myFolder = 'C:\Users\Usuari\Aptana Rubles\Favorites\Downloads\MelanomaDetector\Normal';
% Check to make sure that folder actually exists. Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.bmp'); % Samples images are bmp format. Modify it if necessary.
theFiles = dir(filePattern);
% Initialize matrix of normal features
n = length(theFiles);
normal_features = zeros(n,4); 
normal_features(:,4) = zeros(n,end);
for i = 1 : n
  baseFileName = theFiles(i).name;
  fullFileName = fullfile(myFolder, baseFileName);
  RGB_sample = imread(fullFileName); % Read RGB image.
  RGB_sample = RGB_sample(:,round(size(RGB_sample,1)/3):end-8,:); % Remove black border at the right. Remove line of code if necessary.
  gray_sample = rgb2gray(RGB_sample); % Convert RGB image to gray scale. 
  threshold= 120; % Threshold value. Modify if necessary.
  BW = gray_sample<threshold; % Convert gray scale image to black and white. 
  R = 3; % Disk radius. Adjust if necessary. 
  se = strel('disk', R);
  BW = imdilate(BW, se);
  se = strel('disk', R);
  BW = imerode(BW, se);
  
  % Melanoma features
  % Nuclei to Cytoplasm Ratio (NCR)
  normal_features(i,1) = NCR(BW); 

  % Nuclei Count Function 
  BW = gray_sample<threshold; 
  [nuclei, V] = nuclei_counter(BW); % Adjust intern parameters if necessary. 
  normal_features(i,2) = nuclei;
  normal_features(i,3) = V;
end


% Specify the folder where CANCER samples are.
myFolder = 'C:\Users\Usuari\Aptana Rubles\Favorites\Downloads\MelanomaDetector\Cancer';
% Check to make sure that folder actually exists. Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.bmp'); % Samples images are bmp format. Modify it if necessary.
theFiles = dir(filePattern);
% Initialize matrix of normal features
n = length(theFiles);
cancer_features = zeros(n,4); 
cancer_features(:,4) = ones(n,end);
for i = 1 : n
  baseFileName = theFiles(i).name;
  fullFileName = fullfile(myFolder, baseFileName);
  RGB_sample = imread(fullFileName); % Read RGB image.
  RGB_sample = RGB_sample(:,round(size(RGB_sample,1)/3):end-8,:); % Remove black border at the right. Remove line of code if necessary.
  gray_sample = rgb2gray(RGB_sample); % Convert RGB image to gray scale. 
  threshold= 120; % Threshold value. Modify if necessary.
  BW = gray_sample<threshold; % Convert gray scale image to black and white. 
  R = 3; % Disk radius. Adjust if necessary. 
  se = strel('disk', R);
  BW = imdilate(BW, se);
  se = strel('disk', R);
  BW = imerode(BW, se);
  
  % Melanoma features
  % Nuclei to Cytoplasm Ratio (NCR)
  cancer_features(i,1) = NCR(BW); 

  % Nuclei Count Function 
  BW = gray_sample<threshold; 
  [nuclei, V] = nuclei_counter(BW); % Adjust intern parameters if necessary. 
  cancer_features(i,2) = nuclei;
  cancer_features(i,3) = V;
end

%% VISUALIZE THE EXTRACTED FEATURES 
close all; clc
n = size(normal_features,1);
features = [normal_features; cancer_features];
Visualize(features,n); % Visualize the extracted features.
[linear_corr,pval] = corr(features(:,1:3)) % Asses correlation in the data. 
% If p-value is smaller than 0.05, correlation is significantly different
% from 0. 

%% PERFORM PRINCIPAL COMPONENT ANALYSIS (PCA)
% This step may not be necessary (although recommended) if there is no
% correlation in your data. 
[V1,V2,V3,pca_3d] = PCA(features,normal_features);

