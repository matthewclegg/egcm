\name{egcm}
\alias{egcm}
\alias{plot.egcm}
\alias{summary.egcm}
\alias{is.cointegrated}
\alias{is.ar1}
\title{Simplified Engle-Granger Cointegration Model}
\description{
Performs the two-step Engle Granger cointegration procedure on a pair of time
series, and creates an object representing the results of the analysis.  
}
\usage{
egcm(X, Y, na.action, log = FALSE, normalize = FALSE, 
  debias = TRUE, robust=FALSE, include.const=TRUE,
  i1test = egcm.default.i1test(), 
  urtest = egcm.default.urtest(), 
  p.value = egcm.default.pvalue())

is.cointegrated(E)
is.ar1(E)
}
\arguments{
  \item{X}{
  the first time series to be considered in the cointegration test.
  A plain or \code{\link{zoo}} vector.  Alternatively, a two-column 
  matrix or data.frame, in which case \code{Y} should be omitted.
}
  \item{Y}{
  the second time series to be considered in the cointegration test.
  A plain or \code{\link{zoo}} vector.
}
  \item{E}{
  an object of class \code{"egcm"} returned from a previous call to \code{egcm}
}
  \item{na.action}{
  a function that indicates what should happen when the data contain NAs.
  See \code{\link{lm}}.
}
  \item{log}{
  a boolean value which if \code{TRUE}, indicates that the model should be
  fit to the logs of the input vectors \code{X} and \code{Y}.  Default: FALSE.
}
  \item{normalize}{
  a boolean value which if \code{TRUE}, indicates that each series should be 
  normalized to start at 1.  This is performed by dividing the series
  by its first element.  Default: FALSE.
}
  \item{debias}{
  a boolean value which if \code{TRUE}, indicates that the value of \eqn{rho}
  that is reported should be debiased.  Default: TRUE.
}
  \item{robust}{
  a boolean value which if \code{TRUE}, indicates that the two-step
  Engle-Granger procedure should be performed using a robust linear
  model rather than a standard linear model.  See \code{\link{rlm}}.
  Default: FALSE.
}
  \item{include.const}{
  a boolean which if \code{TRUE}, indicates that the constant term \eqn{alpha}
  should be included in the model.  Otherwise, sets \eqn{alpha=0}.
  Default:  TRUE.
}
  \item{i1test}{
  a mnemonic indicating the name of the test that should be used for
  checking if the input series \code{X} and \code{Y} are integrated.  
  If none is specified, then defaults to the value reported by
  \code{egcm.default.i1test()}.  The installation default is \code{"pp"}.
  The following tests are supported:
  \itemize{
    \item \code{"adf"} Augmented Dickey-Fuller test (see \code{\link{adf.test}})
    \item \code{"pp"}  Phillips-Perron test (see \code{\link{pp.test}})
    \item \code{"pgff"} Pantula, Gonzales-Farias and Fuller weighted
     symmetric estimate (see \code{\link{pgff.test}})
    \item \code{"bvr"} Breitung's variance ratio (see \code{\link{bvr.test}})
  }
}
  \item{urtest}{
  a mnemonic indicating the name of the test that should be used for
  checking if the residual series contains a unit root.  If none is
  specified, then defaults to the value reported by 
  \code{egcm.default.urtest()}.  The installation default is \code{"pp"}.
  The following tests are supported:
  \itemize{
    \item \code{"adf"} Augmented Dickey-Fuller test (see \code{\link{adf.test}})
    \item \code{"pp"}  Phillips-Perron test (see \code{\link{pp.test}})
    \item \code{"pgff"} Pantula, Gonzales-Farias and Fuller weighted
       symmetric estimate (see \code{\link{pgff.test}})
    \item \code{"bvr"} Breitung's variance ratio (see \code{\link{bvr.test}})
    \item \code{"jo-e"} Johansen's eigenvalue test (see \code{\link[urca]{ca.jo}})
    \item \code{"jo-t"} Johansen's trace test (see \code{\link[urca]{ca.jo}})
    \item \code{"ers-p"} Elliott, Rothenberg and Stock point optimal test
      (see \code{\link[urca]{ur.ers}})
    \item \code{"ers-d"} Elliott, Rothenberg and Stock DF-GLS test
      (see \code{\link[urca]{ur.ers}})
    \item \code{"sp-r"} Schmidt and Phillips rho statistic
      (see \code{\link[urca]{ur.sp}})
    \item \code{"hurst"} Hurst exponent calculated using the
      corrected empirical method (see \code{\link[pracma]{hurstexp}})
  } %\itemize
} %\item{urtest}
  \item{p.value}{the p-value to be used in the above tests.
    If none is specified, then defaults to the value reported
    by \code{egcm.default.pvalue()}.  The installation default is 0.05.
}
}
\details{
The two-step Engle Granger procedure searches for parameters
\eqn{\alpha}, \eqn{\beta}, and \eqn{\rho} that yield the best
fit to the following model:

\deqn{Y[i] = \alpha + \beta * X[i] + R[i]}
\deqn{R[i] = \rho * R[i-1] + \epsilon[i]}
\deqn{\epsilon[i] \sim N(0, \sigma^2)}

In the first step, \eqn{alpha} and \eqn{beta} are found using
a linear fit of \code{X[i]} with respect to \code{Y[i]}.  The 
residual sequence \code{R[i]} is then determined.
Then, in the second step, \eqn{\rho} is determined, again using
a linear fit.  

Engle and Granger showed that if \eqn{X} and \eqn{Y} are cointegrated,
then this procedure will yield consistent estimates of the parameters.
However, there are several ways in which this estimation procedure
can fail:

\itemize{
\item Either \code{X} or \code{Y} (or both) may already be
  mean-reverting.  In this case, there is no point in forming
  the difference \eqn{Y - \beta X}.  If one series is mean-reverting
  and the other is not, then any non-trivial linear combination will
  not be mean-reverting.
\item The residual series \code{R[i]} may not be mean-reverting.
  In the language of cointegration theory, it is then said to
  contain a unit root.  In this case, there is no benefit to
  forming the linear combination \eqn{Y - \beta X}.
\item The residual series \code{R[i]} may be mean-reverting, but
  the relation \eqn{R[i] = \rho R[i-1] + \epsilon[i]} may not be
  the right model.  In other words, the residual series
  may not be adequately described by an auto-regressive
  series of order one.  In this case, the parameters \eqn{\alpha}
  and \eqn{\beta} will be correct, however the specification for
  the residuals \code{R[i]} will not be.  The user may wish to try
  fitting the residuals using another function, such as \code{\link{arima}}.
}

The \code{egcm} function checks for each of the above contingencies,
using an appropriate statistical test.
If one of the above conditions is found, then a warning message is
displayed when the model is printed.

The p-value used in the above tests is given by the
parameter \code{p.value}.  This can be changed by setting the value
of the parameter, or by changing the default value with
\code{\link{egcm.set.default.pvalue}}.  For all of the unit root
tests, the p-values of the corresponding test statistics have been
recomputed through simulation and a table lookup is used.  The
Ljung-Box test (see \code{\link{Box.test}}) is used to assess whether
or not the residual series can be adequately fit with an autoregressive
series of order one.

The estimates of \eqn{\alpha} and \eqn{\beta} are not only
consistent but also unbiased.  Unfortunately, the estimate obtained
for \eqn{\rho} may be biased.  Therefore, a bias correction has been
implemented for \eqn{\rho}.  A pre-computed table of biases has been
determined through simulation, and a table lookup is performed to
determine the appropriate bias correction.  To turn off this
feature, set \code{debias = FALSE}.

The helper function \code{is.cointegrated()} takes as input an \code{"egcm"}
object \code{E}.  It returns TRUE if \code{E}
appears to represent a valid pair of cointegrated series.  In other words, it checks that both \code{X} and \code{Y} are
integrated and that the residual series \code{R} is free of unit roots.
The helper function \code{is.ar1()} also takes as input an \code{"egcm"}
object \code{E}.  It returns TRUE if the
residual series \code{R} can be adequately fit by an autoregressive model
of order one.  

From the standpoint of securities trading, cointegration is thought
to provide a useful model for pairs trading.  If the price series of
two securities are cointegrated, then the corresponding residual
series \code{R[i]} will be mean-reverting.  When the magnitude of the residual
\code{R[N]} is large, a trader might establish a long position in the
undervalued security and a short position in the overvalued security.
With high probability, the positions will converge in value, and a
profit can be collected.  Numerous scholarly articles and several
books have been written on pairs trading.

Data mining for cointegrated pairs is not recommended, though.
As with any statistical test, the cointegration test will generate
false positives.  Experience shows that at least in the case of the
components of the S&P 500, the number of false positives overwhelms
the number of truly cointegrated series.

}
\value{
Returns an S3 object of class \code{"egcm"}.  This can then be
\code{print}ed or \code{plot}ted.  There is also a \code{summary} method.

The following is a copy of the printed output that was obtained from 
running the first example below:
\preformatted{
VOO[i] =   0.9201 SPY[i] -   0.6845 + R[i], 
          (0.0005)          (0.0845)     
R[i] =  -0.0004 R[i-1] + eps[i], eps ~ N(0,  0.0779^2)
        (0.0633)
R[2013-12-31] = -0.0987 (t = -1.265)}

The first line of the output shows the fit that was found.  
The parameters were determined to be \eqn{\beta = 0.9201},
\eqn{\alpha = -0.6845} and \eqn{\rho = -0.0004}.  The standard
deviation of the sequence \eqn{\epsilon} of innovations was
found to be \eqn{0.0779}.  The standard errors of \eqn{\alpha},
\eqn{\beta} and \eqn{\rho} were found to be \eqn{0.0845},
\eqn{0.0005} and \eqn{0.0633} respectively.

The third line of output shows the value of the residual as
of the last observation in the series.  The sign of the value
\eqn{-0.0987} indicates that \code{VOO} was relatively undervalued
on this date and that the difference between the two series was
\eqn{-1.265} standard deviations from their historical mean.
\cr
\cr

The fields of the \code{"egcm"} object are as follows:

\item{S1}{the first data series (\code{X[i]})}
\item{S2}{the second data series (\code{Y[i]})}
\item{residuals}{the residual series (\code{R[i]})}
\item{innovations}{the sequence of innovations (\eqn{\epsilon}\code{[i]})}
\item{index}{the index vector for the series}
\item{i1test}{the name of the test used for verifying
  that \code{X} and \code{Y} are integrated}
\item{urtest}{the name of the test used for
  verifying that the residual series does not contain
  a unit root}
\item{pvalue}{the p-value that is used for the various tests used
  by this model}
\item{log}{Boolean, which if true indicates that S1 and S2 are logged}
\item{alpha}{the computed value of \eqn{\alpha}}
\item{alpha.se}{standard error of the estimate of \eqn{\alpha}}
\item{beta}{the computed value of \eqn{\beta}}
\item{beta.se}{standard error of the estimate of \eqn{\beta}}
\item{rho}{the computed and debiased value of \eqn{\rho}}
\item{rho.raw}{the value of \eqn{\rho} determined prior to debiasing}
\item{rho.se}{standard error of the estimate of \eqn{\rho}}
\item{s1.i1.stat}{test statistic found when checking that S1 is integrated}
\item{s1.i1.p}{p-value associated to \code{s1.i1.stat}}
\item{s2.i1.stat}{test statistic found when checking that S2 is integrated}
\item{s2.i1.p}{p-value associated to \code{s2.i1.stat}}
\item{r.stat}{test statistic found when checking whether the residual series
  contains a unit root}
\item{r.p}{p-value associated to \code{r.stat}}
\item{eps.ljungbox.stat}{test statistic found when checking whether an
  AR(1) model adequately fits the residual series}
\item{eps.ljungbox.p}{p-value associated to \code{eps.ljungbox.stat}}
\item{s1.dsd}{standard deviation of \code{diff(S1)}}
\item{s2.dsd}{standard deviation of \code{diff(S2)}}
\item{r.sd}{standard deviation of \code{residuals}}
\item{eps.sd}{standard deviation of the innovations \eqn{\epsilon[i]}}

} % \value
\references{
   Chan, E. (2013). 
   \emph{Algorithmic trading: winning strategies and their rationale}.
   (Vol. 625). John Wiley & Sons.

  Clegg, M. (2014). On the Persistence of Cointegration in Pairs Trading (January 28, 2014). 
  Available at SSRN:  http://ssrn.com/abstract=2491201

  Ehrman, D.S. (2006).
  \emph{The handbook of pairs trading: strategies using equities, options, 
    and futures}. 
  (Vol. 240). John Wiley & Sons.
  
  Engle, R. F. and C. W. Granger.  (1987)
  Co-integration and error correction: representation, estimation, and testing.
  \emph{Econometrica}, 251-276.
  
  Pfaff, B. (2008) 
  \emph{Analysis of Integrated and Cointegrated Time Series with R. Second Edition}. 
  Springer, New York. ISBN 0-387-27960-1
  
  Vidyamurthy, G.  (2004).
  \emph{Pairs trading: quantitative methods and analysis}.
  (Vol 217).  Wiley.com.
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\note{
  Cointegration is a more general concept than has been presented here.
  Users who wish to explore more general models for cointegration are
  referred to the \code{\link[urca:ca.jo]{urca}} package of Bernard Pfaff.
}
\section{Disclaimer}{
  The software in this package is for general information purposes
  only. It is hoped that it will be useful, but it is provided WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
  PARTICULAR PURPOSE. It is not intended to form the basis of any investment
  decision. USE AT YOUR OWN RISK!
}
\seealso{
\link{yegcm}
\link{egcm.default.i1test}
\link{egcm.default.urtest}
\link{egcm.default.pvalue}
\link{sim.egcm}
\link{pgff.test}
\link{bvr.test}
\link[urca]{ca.jo} 
}
\examples{
\dontrun{
library(quantmod)

# SPY and IVV are both ETF's that track the S&P 500.
# One would expect them to be cointegrated, and in 2013 they were.
spy2013 <- getSymbols("SPY", from = "2013-01-01",
          to = "2013-12-31",auto.assign = FALSE)$SPY.Adjusted
ivv2013 <- getSymbols("IVV", from = "2013-01-01", 
         to = "2013-12-31",auto.assign = FALSE)$IVV.Adjusted
egcm(spy2013, ivv2013)

# egcm has a plot method, which can be useful
# In this plot, it appears that there is only one price series,
# but that is because the two price series are so close to each
# other that they are indistinguishable.
plot(egcm(spy2013, ivv2013))

# The yegcm method provides a convenient interface to the quantmod
# package, which can fetch closing prices from Yahoo.  Thus, 
# the above can be simplified as follows:

e <- yegcm("SPY", "VOO", start="2013-01-01", end="2014-01-01")
print(e)
plot(e)
summary(e)

# GLD and IAU both track the price of gold.  
# They too tend to be very tightly cointegrated.
gld.iau.2013 <- yegcm("GLD", "IAU", start="2013-01-01", end="2013-12-31")
gld.iau.2013
plot(gld.iau.2013)

# Coca-cola and Pepsi are often mentioned as an
# example of a pair of securities for which pairs trading
# may be fruitful.  However, at least in 2013, they were not
# cointegrated.
ko.pep.2013 <- yegcm("KO", "PEP", start="2013-01-01", end="2013-12-31")
ko.pep.2013
plot(ko.pep.2013)

# Ford and GM seemed to be even more tightly linked.
# Yet, the degree of linkage was not high enough to pass the
# cointegration test.
f.gm.2013 <- yegcm("F","GM", start="2013-01-01", end="2013-12-31")
f.gm.2013
plot(f.gm.2013)
}}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.  RShowDoc("KEYWORDS")
\keyword{models}
\keyword{ts}
