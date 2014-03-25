\name{yegcm}
\alias{yegcm}
\title{
Engle-Granger cointegration model from Yahoo! price series
}
\description{
Fetches the Yahoo! price series for two securities and constructs an 
Engle-Granger cointegration model from them
}
\usage{
yegcm(ticker1, ticker2, start = YMD(-365), end = YMD(), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ticker1}{the ticker symbol of the first security}
  \item{ticker2}{the ticker symbol of the second security}
  \item{start}{starting date, given in the format YYYYMMDD.  Default: One year ago.}
  \item{end}{ending date, given in the format YYYYMMDD.  Default: Today.}
  \item{...}{additional parameters passed to \code{\link{egcm}}}
}
\details{
Uses the \code{\link[TTR]{getYahooData}} function of the \code{TTR} package
to retrieve the adjusted closing prices of the two securities over
the specified date range.  Then, constructs an Engle-Granger cointegration
model from this data, and returns it.
}
\value{
An Engle-Granger cointegration model
}
\references{
  Engle, R. F. and C. W. Granger.  (1987)
  Co-integration and error correction: representation, estimation, and testing.
  \emph{Econometrica}, 251-276.
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\seealso{
\link{egcm}
\link[TTR]{getYahooData}
}
\examples{
\donttest{
e <- yegcm("SPY", "VOO", 20130101, 20140101)
print(e)
plot(e)
summary(e)
}}
\keyword{models}
\keyword{ts}
