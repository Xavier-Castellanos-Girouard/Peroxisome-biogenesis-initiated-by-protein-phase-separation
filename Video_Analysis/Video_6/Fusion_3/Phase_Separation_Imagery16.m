% Quantifying droplet coalescence for liquid-liquid phase separation
% Xavier Castellanos-Girouard, Rini Ravindran Patel
% August 18th 2022


%% Importing data
directory = "/home/xavier/Desktop/Phase_Separation/Results/Video_6/"; % Specify path to tiff file
fileName = "Video_6_multiple_fusions.tif"; % Specify file name 

fullPath = append(directory, fileName); % Complete file path

%full_image_sequence = imread(fullPath); %temp

% Import first image in sequence to set threshold
first_image = imread(fullPath, 330);
first_image=first_image(:,:,1:3);

%imshow(first_image); % Check tiff image (optional)

%% Setting variables

pixel_per_micron = 10; % Temporary value 
time_step = 0.1; % Temporary value

%% Setting the grey image threshold using first image

% Convert image to double precision format
first_image_double = im2double(first_image);

% Convert intensities to (0-1) range (requires Image Processing Toolbox)
ag=mat2gray(first_image_double);

%% TEMP (tried use MSER algorithms for thresholding. Not ideal.
%first_image_grey=rgb2gray(first_image);
%regions = detectMSERFeatures(first_image_grey);
%imshow(first_image_grey); hold on;
%plot(regions);


%% Setting threshold
% Calculate mean value of image (threshold)
%threshold = graythresh(first_image_double); % Method from paper


%threshold=adaptthresh(rgb2gray(first_image_double)); % My method

%%
threshold = 0.370;
% Convert image pixels to binary values
c=im2bw(ag, threshold); % method used in paper

%c=imbinarize(rgb2gray(first_image_double), threshold);


imshow(c);

h=impoly;
BW=createMask(h);

figure, imshow(BW,[]);


%%
%Note: from here, the process may be automated
% Changed a few things because original steps were not working

info = imfinfo(fullPath);
N = numel(info); % currently over 300

for i=1:N
    image=imread(fullPath, i);
    image=image(:,:,1:3);
    image_double = im2double(image);
    %ag_image=mat2gray(first_image_double);
    %c_image=im2bw(ag_image, threshold); % Method used in paper
    c_image=imbinarize(rgb2gray(image_double), threshold);
    %BW_image=insertObjectMask(c_image,BW);
    BW_image = c_image.*BW;
    %BW_image=createMask(h);
    image_regionprops=regionprops(BW_image, 'MajorAxisLength', 'MinorAxisLength');
    MajAx=image_regionprops.MajorAxisLength(1);
    MinAx=image_regionprops.MinorAxisLength(1);
    aspect_ratio = MajAx/MinAx;
    ratios(i)=aspect_ratio;
    axis_major(i)=MajAx;
    %figure, imshow(BW_image)
end


disp(ratios);

%disp(AR0);
%%
writematrix(ratios,'aspect_ratio_values.csv') 

%%
writematrix(axis_major,'axis_major_values.csv')

