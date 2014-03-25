\name{ur_power}
\alias{ur_power}
\alias{adf_power}
\alias{bvr_power}
\alias{pgff_power}
\alias{ur_power_table}
\alias{adf_power_table}
\alias{bvr_power_table}
\alias{pgff_power_table}
\title{Power assessment for unit root tests}
\description{A collection of functions designed to assist in determining
  the power of various unit root tests}
\usage{
ur_power (ur_test, a0 = 0, a1 = 0.95, trend=0, n = 250, 
    nrep = 10000, p.value = 0.05, ...)
adf_power (a0=0, a1=0.95, trend=0, n=250, 
    nrep=10000, p.value=0.05, k=1)
bvr_power (a0=0, a1=0.95, trend=0, n=250, 
    nrep=10000, p.value=0.05, detrend=FALSE)
pgff_power (a0=0, a1=0.95, trend=0, n=250, 
    nrep=10000, p.value=0.05, detrend=FALSE)

ur_power_table (ur_test, nrep=1000, p.value=0.05,
    a1=c(0.995, 0.99, 0.98, 0.97, 0.96, 0.95),
    trend=0,
    n=c(100, 250, 500, 750, 1000, 1250),
    ...)
adf_power_table (nrep=1000, p.value=0.05,
    a1=c(0.995, 0.99, 0.98, 0.97, 0.96, 0.95),
    trend=0,
    n=c(250, 500, 750, 1000, 1250),
    k=1)
bvr_power_table (nrep=1000, p.value=0.05,
    a1=c(0.995, 0.99, 0.98, 0.97, 0.96, 0.95),
    trend=0,
    n=c(100, 250, 500, 750, 1000, 1250),
    detrend=FALSE)     
pgff_power_table (nrep=1000, p.value=0.05,
    a1=c(0.995, 0.99, 0.98, 0.97, 0.96, 0.95),
    trend=0,
    n=c(100, 250, 500, 750, 1000, 1250),
    detrend=FALSE)
}
\arguments{
  \item{ur_test}{A function that performs a unit root test.  It should accept
  an argument consisting of a vector of real numbers, and it should return
  an object with the p-value stored in the field \code{p.value}.  Example
  functions that satisfy this criterion include \code{\link{adf.test}},
  \code{\link{pp.test}}, \code{\link{pgff.test}} and \code{\link{bvr.test}}
}
  \item{a0}{
Constant term of AR(1) series
}
  \item{a1}{
Linear term of AR(1) series (e.g. coefficient of mean reversion).  
For the \code{*_power_table} variants, this may be a vector of numbers,
representing different values of the linear term that should be tried.
}
  \item{trend}{
Trend parameter.  This may either
be a scalar or it may be a vector of length \code{nrep}.  In the latter
case, each replication of the test is performed with a different value
from \code{trend}.
}
  \item{n}{
Length of AR(1) series.
For the \code{*_power_table} variants, this may be a vector of numbers,
representing different sequence lengths that should be tried.
}
  \item{nrep}{
Number of repetitions to perform
}
  \item{p.value}{
p-value used as cutoff point for rejecting the null hypothesis
}
\item{detrend}{
A boolean which, if TRUE, indicates that linear trends should be
removed from the AR(1) series prior to performing the unit root
test.
}
\item{k}{Number of lags to consider in Dickey-Fuller test}
  \item{...}{
Additional arguments to be passed to the unit root test \code{ur_test}.
}}
\details{
The purpose of this family of functions is to provide a means for investigating the
power of various unit root tests. The power of a statistical test is the probability
that it will reject the null hypothesis when the null hypothesis is false.

For unit root tests, a common practice for assessing power is to
randomly generate AR(1) sequences of a fixed length and with a fixed coefficient of
mean reversion, and to quantify the power in terms of these two parameters. 
That is the approach taken here.

The \code{*_power} functions generate \code{nrep} random AR(1) sequences
of length \code{n} having the parameters \code{a0} and \code{a1}.  For
each such sequence, the unit root test is performed and a check is made
to see if the null hypothesis is rejected at the level given by
\code{p.value}.  The frequency of rejections is then reported.

The \code{*_power_table} functions generate a table of powers for various
choices of \code{n} and \code{a1}.  These functions can take quite a while
to run.

\code{adf_power} and \code{adf_power_table} report the power of the
augmented Dickey-Fuller test as implemented in \code{\link{adf.test}}.
\code{bvr_power} and \code{bvr_power_table} report the power of 
Breitung's variance ratio as implemented in \code{\link{bvr.test}}.
\code{pgff_power} and \code{pgff_power_table} report the power of
the weighted symmetric estimator of Pantula, Gonzalez-Farias and Fuller
as implemented in \code{\link{pgff.test}}.
}
\value{
For the \code{*_power} functions, returns the frequency of rejections
of the null hypothesis.

For the \code{*_power_table} functions, returns a \code{data.frame}.
Each column corresponds to a value of the mean reversion coefficient
given in the vector \code{a1}, and each row corresponds to a sample
length given in the vector \code{n}.  An entry in the table records
the frequency of rejections of the null hypothesis for the given
sample length and coefficient of mean reversion.
}
\references{
  Breitung, J. (2002). 
  Nonparametric tests for unit roots and cointegration. 
  \emph{Journal of econometrics}, 108(2), 343-363.

  Dickey, D. A., & Fuller, W. A. (1979). 
  Distribution of the estimators for autoregressive time series with a unit root.     
  \emph{Journal of the American statistical association}, 74(366a), 427-431.
  
  Pantula, S. G., Gonzalez-Farias, G., and Fuller, W. A. (1994).
  A comparison of unit-root test criteria.
  \emph{Journal of Business & Economic Statistics}, 12(4), 449-459. 
}
\author{
Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\seealso{
\code{\link{adf.test}}
\code{\link{pp.test}}
\code{\link{bvr.test}}
\code{\link{pgff.test}}
}
\examples{
\donttest{
# The following examples may take a long time to run
    
# Compare the power of various unit root tests for specific
# parameter values:
adf_power(a1=0.9, n=125, p.value=0.1)
bvr_power(a1=0.9, n=125, p.value=0.1)
pgff_power(a1=0.9, n=125, p.value=0.1)
ur_power(pp.test, a1=0.9, n=125, p.value=0.1)

# The following illustrates the importance of de-trending
pgff_power(a1=0.9, n=125, p.value=0.1, trend=10)
pgff_power(a1=0.9, n=125, p.value=0.1, trend=10, detrend=TRUE)

# Generate tables comparing the powers of various unit root tests:
adf_power_table()
bvr_power_table()
pgff_power_table()
ur_power_table(pp.test)
}}
\keyword{ts}
