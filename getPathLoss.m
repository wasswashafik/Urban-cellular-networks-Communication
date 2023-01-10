function [ L_dB ] = getPathLoss( tier, distance)

%using pathloss formula, distance, and tier, calculate pathloss


c = 3e8;

%Get pathloss exponent
PLE = assignPLE(tier, distance);

%refernece distance
%redundant variable
do = 1;

%path loss =           fixed                 +         distance dependent

a = 20.*log10(4*pi*(10^9)./c);
a1 = 20.*log10(getFrequency(tier)./10^9);
b= (10.*PLE).*log10((distance)./do);
L_dB = 20.*log10(4*pi*getFrequency(tier)./c) + (10.*PLE).*log10((distance)./do);    


end

