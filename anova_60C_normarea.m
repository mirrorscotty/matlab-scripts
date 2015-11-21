normarea1 = [0.9832840888,1.0099868859,0.9976447262,...
    0.8640104752,0.8882813914,0.841142214,0.8822130686,...
    0.8820353268,0.8802245797,0.8830777176,0.9210391154,...
    0.8963719005,0.9039881806,0.9005208322,...
    0.8622359358,0.8301304867,0.8546849405];
normarea2 = [0.8614485429,0.8581990295,0.8477424938,...
    0.7733522056,0.8080616897,0.7845606678,0.8046238926,...
    0.8501022679,0.8542040601,0.8343162768,0.9172367589,...
    0.8453136615,0.8172976327,0.8195511991,...
    0.8837797118,0.8533580702,0.880397312];
salt = {'K2SO4', 'K2SO4', 'K2SO4',...
    'KNO3','KNO3','KNO3','KNO3',...
    'K2CO3','K2CO3','K2CO3','K2CO3',...
    'NaCl','NaCl','NaCl',...
    'LiCl','LiCl','LiCl'};

[p1, tbl1, stats1] = anova1(normarea1, salt)
[p2, tbl2, stats2] = anova1(normarea2, salt)