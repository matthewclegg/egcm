\name{bvr.test}
\alias{bvr.test}
\alias{bvr_rho}
\title{
Unit root test based upon Breitung's variance ratio
}
\description{
Unit root test based upon Breitung's variance ratio
}
\usage{
bvr.test(Y, detrend = FALSE)
bvr_rho(Y, detrend = FALSE)
}
\arguments{
  \item{Y}{A vector or zoo-vector}
  \item{detrend}{A boolean, which if TRUE, indicates that the test should
    be performed after removing a linear trend from \code{Y}}
}
\details{
Breitung's variance ratio is given by the formula:
\deqn{\rho_T = \frac{T^{-2} \sum_{t=1}^T Y_t^2}{T^{-1} \sum_{t=1}^T y_t^2}}{%
  rho = (1/T) * sum(cumsum(Y)^2)/sum(Y^2)}
where \eqn{T} is the length of the vector \eqn{Y}.  (See equation (5) 
of his paper.)

The advantage of Breitung's variance ratio is that, in contrast to
the Dickey-Fuller test and other related tests, it is a nonparametric
statistic.  In simulations, it seems to perform favorably with respect
to the Hurst exponent.

Simulation has been used to determine the distribution of the statistic,
and table lookup is used to determine p-values.

If \code{detrend=TRUE}, then a linear trend is removed from the data
prior to computing the estimator \eqn{\rho_{T}}{rho}.  A separate table has been
computed of the distribution of values of \eqn{\rho_{T}}{rho} after detrending.
}
\value{
\code{bvr_rho} returns the value \eqn{\rho_{T}}{rho} of Breitung's variance
ratio.

\code{bvr.test} returns a list with class \code{"htest"} containing the following components:
  \item{statistic}{the value of the test statistic.}
  \item{parameter}{the truncation lag parameter.}
  \item{p.value}{the p-value of the test.}
  \item{method}{a character string indicating what type of test was
    performed.}
  \item{data.name}{a character string giving the name of the data.}
}
\references{
  Breitung, J. (2002). 
  Nonparametric tests for unit roots and cointegration. 
  \emph{Journal of econometrics}, 108(2), 343-363.

  Breitung, J. and Taylor, A.M.R. (2003)
  Corrigendum to "Nonparametric tests for unit roots and cointegration"
  [J. Econom. 108 (2002) 343-363]
  \emph{Journal of econometrics}, 117(2), 401-404.
}
\author{Matthew Clegg \email{matthewcleggphd@gmail.com}}
\seealso{
  \code{\link[pracma]{hurstexp}}
  \code{\link{egcm}}
}
\examples{
# The following should produce a low p-value
bvr_rho(rnorm(100))
bvr.test(rnorm(100))

# The following should produce a high p-value
bvr_rho(cumsum(rnorm(100)))
bvr.test(cumsum(rnorm(100)))

# Test with an autoregressive sequence where rho = 0.8
bvr.test(rar1(100, a1=0.8))

# If there is a linear trend, bvr.test with detrend=FALSE
# is likely to find a unit root when there is none:
bvr.test(1:100 + rnorm(100))
bvr.test(1:100 + rnorm(100), detrend=TRUE)

# Display the power of the test for various values of rho and n:
bvr_power(a1=0.8, n=100, nrep=100)
bvr_power(a1=0.9, n=250, nrep=100)
bvr_power(a1=0.95, n=250, nrep=100)

# This is to be compared to the power of the adf.test at this level:
adf_power(a1=0.8, n=100, nrep=100)
adf_power(a1=0.9, n=250, nrep=100)
adf_power(a1=0.95, n=250, nrep=100)
}
\keyword{ts}
