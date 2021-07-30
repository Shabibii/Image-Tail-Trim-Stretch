%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Histogram tail trim stretch
% Author:       Samir Habibi
% Rev. Date:    24/11/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; % Delete all variables.
close all; % Close all windows.
clc; % Clear command window.

% Ask user for file by presenting options with menu() command.
fileChoice = menu('File', 'Lena Greyscale', 'Poor Contrast CCTV1' , 'Choose own');

% Use switch() to read file based on user's choice (fileChoice).
switch (fileChoice)
    case 1
        filename = ('lenaGreyscale.bmp');
        L = imread(filename);
    case 2
        filename = ('poorContrastCCTV1.bmp');
        L = imread(filename);
    case 3
        filename = uigetfile('');
        L = imread(filename);
end % End the switch-statement after obtaining image in L.

% Request valid value from user for 't' in stretch formula.
t = input('Enter desired highest pixel value (255, most common): ');
% While input is not valid, keep asking user.
while (t < 0) || (t > 255) % Limits.
    t = input('Enter number between 1 and 255: ');
end % End if correct value for userInput is found.

% Get row and columns of the image.
M = size(L, 1);
N = size(L, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get histogram with imhist(), then the cumulative count histogram with
% cumsum(), and eventually the normalised cumulative count histogram by
% dividing the cumulative count histogram by the number of rows (M) and
% columns(N) of image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make count histograms.
H = imhist(L);

% Make cumulative histogram from count histogram.
H_cml = cumsum(H);

% Make normalised cumulative count histogram from cumulative histogram.
H_normCmlCount = H_cml./(M*N);

% Call method performStretch().
L_stretched = performStretch(L, t);

% Call method performTailTrimStretch().
L_trimStretched = performTailTrimStretch(L, t, H_normCmlCount);

figure;
% Display original image.
subplot(2, 3, 1);
imshow(L);
title('Original Image', 'FontSize', 9, 'FontWeight', 'bold');

% Display image after stretch contrast enhancement.
subplot(2, 3, 2);
imshow(L_stretched);
title('Stretched Image', 'FontSize', 9, 'FontWeight', 'bold');

% Display image after tail trim stretch contrast enhancement.
subplot(2, 3, 3);
imshow(L_trimStretched);
title('Tail Trim Stretched Image', 'FontSize', 9, 'FontWeight', 'bold');

% Plot the count histogram of image L
subplot(2, 3, 4)
countHist = bar((0:255), imhist(uint8(L)));
title('Count Histogram', 'FontSize', 9, 'FontWeight', 'bold');
xlabel('Luminance', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Count', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
xlim([0, 255]);ylim([0, max(imhist(uint8(L)))]);
axis square;

% Plot the cumulative count histogram of image L
subplot(2, 3, 5)
cumulCountHist = bar((0:255), H_cml);
title('Cumul. Count Histogram', 'FontSize', 9, 'FontWeight', 'bold');
xlabel('Luminance', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Cumulative Count', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
xlim([0, 255]);ylim([0, max(H_cml)]);
axis square;

% Plot the normalised cumulative count histogram.
% This histogram is used for the 5th and 95th percentile method /
% tail trim stretch enhancement technique.
subplot(2, 3, 6)
histBar = bar((0:255), H_normCmlCount);
title('Norm. Cumul. Count Histogram', 'FontSize', 9, 'FontWeight', 'bold');
xlabel('Luminance', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Normalised Cumulative Count', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
xlim([0, 255]);ylim([0, max(H_normCmlCount)]);
axis square;

figure;
% Display original image.
subplot(2, 3, 1);
imshow(L);
title('Original Image', 'FontSize', 9, 'FontWeight', 'bold');

% Display image after stretch contrast enhancement.
subplot(2, 3, 2);
imshow(L_stretched);
title('Stretched Image', 'FontSize', 9, 'FontWeight', 'bold');

% Display image after tail trim stretch contrast enhancement.
subplot(2, 3, 3);
imshow(L_trimStretched);
title('Tail Trim Stretched Image', 'FontSize', 9, 'FontWeight', 'bold');

% Plot the count histogram of image L
subplot(2, 3, 4)
countHist2 = bar((0:255), imhist(uint8(L)));
title('Original Histogram', 'FontSize', 9, 'FontWeight', 'bold');
xlabel('Luminance', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Count', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
xlim([0, 255]);ylim([0, max(imhist(uint8(L)))]);
axis square;

% Plot the count histogram of stretched image L
subplot(2, 3, 5)
stretchHist = bar((0:255), imhist(L_stretched));
title('Stretched Histogram', 'FontSize', 9, 'FontWeight', 'bold');
xlabel('Luminance', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Count', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
xlim([0, 255]);ylim([0, max(imhist(uint8(L)))]);
axis square;

% Plot the count histogram of tail trim stretched image L
subplot(2, 3, 6)
tailStretchHist = bar((0:255), imhist(L_trimStretched));
title('Tail Trim Stretched Histogram', 'FontSize', 9, 'FontWeight', 'bold');
xlabel('Luminance', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
ylabel('Count', 'FontName', 'Courier', 'FontSize', 8, 'FontWeight', 'bold');
xlim([0, 255]);ylim([0, max(imhist(uint8(L)))]);
axis square;