function k = fieldAsymmetry(xsUnfolded,rateUnfolded)

fieldXs  = xsUnfolded(rateUnfolded > 0);

peakInd = find(rateUnfolded == max(rateUnfolded), 1, 'first');

k = (xsUnfolded(peakInd) - min(fieldXs)) / (max(fieldXs) - min(fieldXs));

%wid = max(fieldXs) - min(fieldXs);

%k(wid < 0.6) = 0;

%fieldMid = mean(fieldXs);

%frontActivity = sum(rateUnfolded(xsUnfolded > fieldMid));
%backActivity = sum(rateUnfolded(xsUnfolded < fieldMid));

%k = frontActivity / (frontActivity + backActivity);