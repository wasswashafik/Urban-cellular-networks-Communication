% algorithm to associate each user to a base station defined by its tier.


Ux = (U(:, 1));
Uy = (U(:, 2));
BSx = BSLocation(:, 1);
BSy = BSLocation(:, 2);



Pt_dB = zeros(1, length(BSx));
Pr_dB = zeros(nU, length(BSx));
L_dB = zeros(nU, length(BSx));
power_dB = zeros(nU,1);
BS_associated = zeros(nU,1);
association_matrix = zeros(nU, length(BSx));
d = zeros(nU, length(BSx));
antenna_gain = [getDownlinkAntennaGain(0, 1).*ones([1 nBS_0])  getDownlinkAntennaGain(1, 1).*ones([1 nBS_1])   getDownlinkAntennaGain(2, 1).*ones([1 nBS_2])];  %add antenna gain

for i = 1 : nU
    d(i, :) = sqrt( (Ux(i) - BSx).^2 + (Uy(i) - BSy).^2 );
    [Pt_dB, B, f, subcarriers] = getBSProperties(BSType);                                    
    Pt_dB = 10.*log10(10.^(Pt_dB./10));                       %CHECK TRANSMIT POWER
    L_dB(i, :) = getPathLoss(BSType, d(i, :));
    Pr_dB(i, :) = Pt_dB(1,:) - L_dB(i, :);       
     
     Pr_dB(i,:) = Pr_dB(i,:) + antenna_gain;
    bias_array = [getBiasFactor(0).*ones([1 nBS_0])  getBiasFactor(1).*ones([1 nBS_1])   getBiasFactor(2).*ones([1 nBS_2])];  %add biasing factor
   
   
    [power_dB(i), BS_associated(i)] = max(Pr_dB(i, :)+bias_array);
  
    
     power_dB(i) = power_dB(i) - getBiasFactor(getTier(BS_associated(i),nBS_0, nBS_1, nBS_2));
     association_matrix(i, BS_associated(i)) = 1;
      
end

