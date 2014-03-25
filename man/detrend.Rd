\name{detrend}
\alias{detrend}
\title{
Remove a linear trend from a vector
}
\description{
Given a numeric vector \code{Y}, removes a linear trend from it.
}
\usage{
detrend(Y)
}
\arguments{
  \item{Y}{numeric vector to be de-trended}
}
\value{
  Returns a vector \code{X} where \code{X[i] = Y[i] - a - b * i},
  where \code{a} and \code{b} describe the linear trend in Y.
}
\author{
Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\examples{
detrend(rep(1,10))  # == 0 0 0 0 0 0 0 0 0 0
detrend(1:10)       # == 0 0 0 0 0 0 0 0 0 0
detrend((1:10)^2)   # == 12  4 -2 -6 -8 -8 -6 -2  4 12

mean(detrend(rnorm(1:100) + 1:100))  # should be very close to 0
sd(rnorm(1:100) + 1:100)             # approximately 29
sd(detrend(rnorm(1:100) + 1:100))    # approximately 1
}
