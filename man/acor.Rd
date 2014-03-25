\name{acor}
\alias{acor}
\title{autocorrelation}
\description{autocorrelation of a sequence}
\usage{
acor(X, k = 1, na.rm = FALSE)
}
\arguments{
  \item{X}{a numeric vector or \code{\link{zoo}} vector}
  \item{k}{the number of lags for which to compute the autocorrelation.  Default: 1}
  \item{na.rm}{a boolean, which if TRUE, indicates that NA values should be removed
    from the series prior to computing the autocorrelation.  Default: FALSE}
}
\value{
Returns the lag \code{k} autocorrelation of \code{X}, e.g., the correlation
of \code{X[i]} with \code{X[i-k]}.  
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\note{
It's a bit surprising that this is not a part of the core \R distribution,
but I can't find it.  Perhaps it was thought to be too trivial to include.
}
\seealso{
\code{\link{acf}}
}
\examples{
acor(1:10)                # a perfect correlation
acor(rnorm(100))          # should be close to zero
acor(cumsum(rnorm(100)))  # slightly less than one
acor(rar1(1000, a1=0.8))  # slightly less than 0.8
acor(rar1(1000, a1=0.8), k=2)  # about 0.64
acor(rar1(1000, a1=0.8), k=3)  # about 0.51
}
\keyword{ts}
