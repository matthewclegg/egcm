\name{rcoint}
\alias{rcoint}
\title{Random generation of cointegrated sequences}
\description{Generates a random pair of cointegrated sequences}
\usage{
rcoint(n, 
  alpha = runif(1, -10, 10), 
  beta = runif(1, -10, 10), 
  rho = runif(1, 0, 1), 
  sd_eps = 1, 
  sd_delta = 1,
  X0=0,
  Y0=0)
}
\arguments{
  \item{n}{number of observations in each sequence}
  \item{alpha}{constant term of linear relation}
  \item{beta}{slope term of linear relation}
  \item{rho}{coefficient of mean reversion}
  \item{sd_eps}{standard deviation of innovations in first sequence}
  \item{sd_delta}{standard deviation of innovations in residual sequence}
  \item{X0}{initial value of first sequence}
  \item{Y0}{initial value of second sequence}
}
\details{
Generates a random pair of cointegrated sequences.  The sequences are constructed
by first generating two random sequences that are independent and normally distributed.  
The elements of the first sequence, \eqn{\epsilon[i]}{epsilon[i]}, 
have standard deviation \code{sd_eps},
while those of the second sequence, \eqn{\delta[i]}{delta[i]}, 
have standard deviation \code{sd_delta}.
Having generated these two sequences, the cointegrated sequences \code{X[i]} and
\code{Y[i]} are generated according to the following relations:
  \deqn{X[i] = X[i-1] + \epsilon[i]}{X[i] = X[i-1] + epsilon[i]}
  \deqn{R[i] = \rho R[i-1] + \delta[i]}{R[i] = rho * R[i-1] + delta[i]}
  \deqn{Y[i] = \alpha + \beta X[i] + R[i]}{Y[i] = alpha + beta * X[i] + R[i]}
}
\value{
Returns a two-column data.frame containing the randomly generated
cointegrated sequences.
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\seealso{
  \code{\link{rar1}}
  \code{\link{sim.egcm}}
  \code{\link{egcm}}
}
\examples{
xy <- rcoint(1000, alpha = 1, beta = 2, rho = 0.8)
egcm(xy)
}
\keyword{ts}
