function L_trimStretched = performTailTrimStretch(L, t, H_normCmlCount)
%PERFORMTAILTRIMSTRETCH Perform tail trim stretch on a given image.
%   This function takes an image and its normalised cumulative count
%   histogram as input arguments. Then finds 5th and 95th percentile
%   the histogram values and performs a tail trim stretch with these values

% Convert L (image) to double for stretch calculation
L = double(L);

% Set x for pixel values given normalised cumulative count value
x = 0:255;

% Get trimmed values at 5th and 95th percentile & set tolerance value
% because H_normCmlCount is of type 'double'.
tol = 0.01;
minTrim = x(abs(H_normCmlCount-0.05) < tol); % get 5th percentile.

% Caluclate mean of minTrim (multiple pixel values matching
% 'H_normCmlCount-0.05').
L_trimmedMin = mean(minTrim);

% Get 95th percentile
maxTrim = x(abs(H_normCmlCount-0.95) < tol);
% Calculate mean of maxTrim (multiple pixel values matching
% 'H_normCmlCount-0.05').
L_trimmedMax = mean(maxTrim);

% Perform stretching formula, use trimmed values for luminance minumum
% and maximum.
L_trimStretched = (L-L_trimmedMin).*(t/(L_trimmedMax-L_trimmedMin));
L_trimStretched = uint8(L_trimStretched);

end

