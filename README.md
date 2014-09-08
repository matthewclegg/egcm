egcm
====

Engle-Grainger cointegration models in R

This package provides a simplified implementation of the Engle-Granger
cointegration model that is geared towards the analysis of securities prices.
Summary and plot functions are provided, and a convenient interface to
the TTR package is given. A variety of standard unit root tests are supported,
and an improved unit root test is included.

This package implements a test for a simplified form of cointegration. Namely,
it checks whether or not a linear combination of two time series follows an
autoregressive model of order one. In other words, given two series X and
Y, it searches for parameters alpha, beta and rho such that:

Y[i] = alpha + beta * X[i] + R[i]
R[i] = rho * R[i-1] + epsilon

If |rho| < 1, then X and Y are cointegrated.

Cointegration is a useful tool in many areas of economics, but this
implementation is especially geared towards the analysis of securities
prices.  Testing for cointegration has been proposed as means for assessing
whether or not two securities are suitable candidates for pairs trading.

In addition, this package implements two previously unavailable unit root tests.
A test based upon the weighted symmetric estimator rho_ws of Pantula,
Gonzales-Farias and Fuller is implemented as pgff.test. This test seems
to provide superior performance to the standard Dickey-Fuller test
adf.test and also improves upon the performance of a number of other
tests previously available in R.

The variance ratio test proposed by J. Breitung is implemented as
bvr.test.  It has the advantage that it is a non-parametric test,
and it seems to provide superior performance to other variance ratio
tests available in R, although it does not perform as well as pgff.test.

Users who wish to explore more general models for cointegration are
referred to the urca package of Bernard Pfaff.
 
DISCLAIMER: The software in this package is for general information purposes
only. It is hoped that it will be useful, but it is provided WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. It is not intended to form the basis of any investment
decision. USE AT YOUR OWN RISK!


References
----------

  Breitung, J. (2002). 
  Nonparametric tests for unit roots and cointegration. 
  Journal of econometrics, 108(2), 343-363.

  Chan, E. (2013). 
  Algorithmic trading: winning strategies and their rationale.
  (Vol. 625). John Wiley & Sons.

  Clegg, M. (2014).
  On the Persistence of Cointegration in Pairs Trading,
  Available at SSRN:  http://ssrn.com/abstract=2491201.
  
  Ehrman, D.S. (2006).
  The handbook of pairs trading: strategies using equities, options, 
    and futures. 
  (Vol. 240). John Wiley & Sons.

  Engle, R. F. and C. W. Granger.  (1987)
  Co-integration and error correction: representation, estimation, and testing.
  Econometrica, 251-276.
  
  Pantula, S. G., Gonzalez-Farias, G., and Fuller, W. A. (1994).
  A comparison of unit-root test criteria.
  Journal of Business & Economic Statistics, 12(4), 449-459. 

  Pfaff, B. (2008) 
  Analysis of Integrated and Cointegrated Time Series with R. Second Edition. 
  Springer, New York. ISBN 0-387-27960-1

  Vidyamurthy, G.  (2004).
  Pairs trading: quantitative methods and analysis.
  (Vol 217).  Wiley.com.
  
Examples
--------

```
library(ttr)
prices.spy <- getYahooData("SPY", 20130101, 20140101)$Close
prices.voo <- getYahooData("VOO", 20130101, 20140101)$Close
egcm(prices.spy, prices.voo)
plot(egcm(prices.spy, prices.voo))
summary(egcm(prices.spy, prices.voo))

# The yegcm method provides a convenient interface to the TTR
# package, which can fetch closing prices from Yahoo.  Thus, 
# the above can be simplified as follows:

e <- yegcm("SPY", "VOO", 20130101, 20140101)
print(e)
plot(e)
summary(e)
```
