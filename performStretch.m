function L_stretched = performStretch(L, t)
%PERFORMSTRETCH Perform stretch on a given image.
%   This function takes an image and calculates its minimum and maximum
%   luminance with min(min()). Then performs a stretch with the min and
%   max values using the stretch formula.

% Convert L to double for stretch calculation
L = double(L);

% Get minimum and maximum luminance of image
L_min = min(min(L));
L_max = max(max(L));

% Use stretch formula to perform stretch procedures for contrast
% enhancement in the image.
L_stretched = (L-L_min).*(t/(L_max-L_min));
% Set L_stretched to 'uint8' datatype.
L_stretched = uint8(L_stretched);

end

