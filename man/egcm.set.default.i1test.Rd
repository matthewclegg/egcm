\name{egcm.defaults}
\alias{egcm.set.default.i1test}
\alias{egcm.set.default.urtest}
\alias{egcm.set.default.pvalue}
\alias{egcm.default.i1test}
\alias{egcm.default.urtest}
\alias{egcm.default.pvalue}
\alias{egcm.i1tests}
\alias{egcm.urtests}
\title{
Set and get defaults for Engle-Granger cointegration models
}
\description{
Set and get defaults for Engle-Granger cointegration models
}
\usage{
egcm.set.default.i1test(i1test)
egcm.default.i1test()
egcm.i1tests()

egcm.set.default.urtest(urtest)
egcm.default.urtest()
egcm.urtests()

egcm.set.default.pvalue(p)
egcm.default.pvalue()
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{i1test}{
  a mnemonic indicating the name of the test that should be used for
  checking if the input series are integrated.  
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
  checking if the residual series contains a unit root.  
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
\item{p}{
  the p-value should be used for rejecting the null hypothesis in
  the various statistical tests conducted by \code{\link{egcm}}.
  }
} %\arguments{}
\value{
For \code{egcm.default.i1test}, returns the string representing the
currently selected default I(1) test.  For \code{egcm.i1tests},
returns a list of all available I(1) tests.

For \code{egcm.default.urtest}, returns the string represeting the
currently selected unit root test.  For \code{egcm.urtests},
returns a list of all available unit root tests.

For \code{egcm.default.pvalue}, returns the default p-value that
will be used for rejecting the null hypothesis in the various
statistical tests conducted by \code{\link{egcm}}.

The setter functions do not return a value.  
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\note{
Changing the default value only affects \code{egcm} objects created
after the change is made. 
}
\seealso{
\link{egcm}
}
\examples{
# Get and set the current default I(1) test
egcm.default.i1test()
egcm.set.default.i1test("adf")

# Get and set the current default unit root test
egcm.default.urtest()
egcm.set.default.urtest("pp")

# Get and set the current default p-value
egcm.default.pvalue()
egcm.set.default.pvalue(0.01)
}
