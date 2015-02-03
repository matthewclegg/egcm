\name{rar1}
\alias{rar1}
\title{Random AR(1) vector}
\description{Generates a random realization of an AR(1) sequence}
\usage{
rar1(n, a0 = 0, a1 = 1, trend = 0, sd = 1, x0 = 0)
}
\arguments{
  \item{n}{Length of vector to produce}
  \item{a0}{Constant term in AR(1) sequence}
  \item{a1}{Coefficient of mean-reversion}
  \item{trend}{Linear trend}
  \item{sd}{Standard deviation of sequence of innovations}
  \item{x0}{Starting value of sequence}
}
\value{
If \code{trend=0}, returns a vector of length \code{n} representing 
a simulation of an AR(1) process   
\deqn{X[k] = a_0 +  a_1 * X[k-1] + \epsilon[t]}
where \eqn{\epsilon[t]} is a sequence of independent and identically 
distributed samples from a normal distribution with mean zero and
standard deviation \code{sd}.

If \code{trend != 0}, returns a vector of length \code{n} representing
a simulation of a trend-stationary AR(1) process
  \deqn{R[k] = a_0 +  a_1 * R[k-1] + \epsilon[t]}
  \deqn{X[k] = k * trend + R[k]}
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\seealso{
\code{\link{rcoint}}
}
\examples{
rar1(100, 0, 0)          # Equivalent to rnorm(100)
rar1(100, 0, 1)          # Equivalent to cumsum(rnorm(100))
acor(rar1(100, 1, .5))   # Should be about 0.5
tseries::adf.test(rar1(100, 0, .5))  # Should have a low p-value
}
\keyword{ts}
