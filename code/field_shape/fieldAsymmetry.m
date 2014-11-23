function k = fieldAsymmetry(xsUnfolded,rateUnfolded)

fieldMid = mean(xsUnfolded(rateUnfolded > 0));

rateTotal = sum(rateUnfolded);

k = (sum(rateUnfolded(xsUnfolded > fieldMid)) - ...
     sum(rateUnfolded(xsUnfolded < fieldMid))) ...
    / rateTotal;