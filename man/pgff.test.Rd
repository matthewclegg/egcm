\name{pgff.test}
\alias{pgff.test}
\alias{pgff_rho_ws}
\title{
Unit root test of Pantula, Gonzales-Farias and Fuller
}
\description{
Unit root test based upon the weighted symmetric estimator of
Pantula, Gonzales-Farias and Fuller
}
\usage{
pgff.test(Y, detrend = FALSE)
pgff_rho_ws(Y, detrend = FALSE)
}
\arguments{
  \item{Y}{A vector or zoo-vector}
  \item{detrend}{A boolean, which if TRUE, indicates that the test should
    be performed after removing a linear trend from \code{Y}}
}
\details{
The weighted symmetric estimator \eqn{\rho_{WS}}{rho_ws} of Pantula, 
Gonzales-Farias and Fuller is given as follows:
\deqn{\hat{\rho}_{WS}=\frac{\sum_{t=2}^n Y_{t-1} Y_t}{%
  \sum_{t=2}^{n-1} Y_t^2 + n^{-1} \sum_{t=1}^n Y_t^2}}{%
  rho_ws = sum(Y[1:(n-1)]*Y[2:n])/(sum(Y[2:(n-1)]^2) + (1/n)*sum(Y^2)}

where \eqn{n} is the length of the sequence \code{Y}.

The authors give an associated pivotal statistic and derive the limiting distribution for it, however the approach taken in this implementation was
simply to determine the distribution of \eqn{\rho_{WS}}{rho_ws} through simulation.
Table lookup is used to determine the p-value associated with a given
value of the statistic.

If \code{detrend=TRUE}, then a linear trend is removed from the data
prior to computing the estimator \eqn{\rho_{WS}}{rho_ws}.  A separate table has been
computed of the distribution of values of \eqn{\rho_{WS}}{rho_ws} after detrending.

This unit root test is intended to identify autoregressive sequences
of order one.  However, the authors state that, 
"A Monte Carlo study indicates that the weighted symmetric estimator
performs well in second order processes."
}
\value{
\code{pgff_rho_ws} returns the value \eqn{\rho_{WS}}{rho_ws} of the weighted
symmetric estimator.

\code{pgff.test} returns a list with class \code{"htest"} containing the following components:
  \item{statistic}{the value of the test statistic.}
  \item{parameter}{the truncation lag parameter.}
  \item{p.value}{the p-value of the test.}
  \item{method}{a character string indicating what type of test was
    performed.}
  \item{data.name}{a character string giving the name of the data.}

}
\references{
  Pantula, S. G., Gonzalez-Farias, G., and Fuller, W. A. (1994).
  A comparison of unit-root test criteria.
  \emph{Journal of Business & Economic Statistics}, 12(4), 449-459. 
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\seealso{
\code{\link{adf.test}}
\code{\link{egcm}}
}
\examples{
# The following should produce a low p-value
pgff_rho_ws(rnorm(100))
pgff.test(rnorm(100))

# The following should produce a high p-value
pgff_rho_ws(cumsum(rnorm(100)))
pgff.test(cumsum(rnorm(100)))

# Test with an autoregressive sequence where rho = 0.8
pgff.test(rar1(100, a1=0.8))

# If there is a linear trend, pgff.test with detrend=FALSE
# is likely to find a unit root when there is none:
pgff.test(1:100 + rnorm(100))
pgff.test(1:100 + rnorm(100), detrend=TRUE)

# Display the power of the test for various values of rho and n:
pgff_power(a1=0.8, n=100, nrep=100)
pgff_power(a1=0.9, n=250, nrep=100)
pgff_power(a1=0.95, n=250, nrep=100)

# This is to be compared to the power of the adf.test at this level:
adf_power(a1=0.8, n=100, nrep=100)
adf_power(a1=0.9, n=250, nrep=100)
adf_power(a1=0.95, n=250, nrep=100)
}
\keyword{ts}
