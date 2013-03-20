function [ ll, aic, bic, ks, aks, snc ] = fitstat( copulaparams, U )
%COPULA.FITSTAT Given copula structure and data U compuates fit statistics.
%   Computes LL, AIC and BIC statistics.

[n, d] = size(U);

% Compute log likelihood
Y = copula.pdf(copulaparams, U);
ll = sum(log(Y));
k = copulaparams.numParams;

% Compute aic
aic = -2*ll + (2*n*k)/(n-k-1);
% Compute bic
bic = -2*ll + k*log(n);

% Compute KS measure
E = copula.pit( copulaparams, U );
% Produce chi-squared vector
C = sum( norminv( E ) .^ 2, 2 );
% Compute KS statistics
ks = sqrt(n) * max(abs(chi2cdf(C, d) - uniform(C)));
% Compute AKS statistics
aks = sum(abs(chi2cdf(C, d) - uniform(C))) / sqrt(n);
% Compute S(n)c statistics
snc = sum((copula.emp(E) - prod(E, 2)) .^ 2);

end

