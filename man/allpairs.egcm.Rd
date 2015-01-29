\name{allpairs.egcm}
\alias{allpairs.egcm}
\title{Perform cointegration tests for all pairs of securities in a list}
\description{
Given a list of ticker symbols, downloads the adjusted daily closing prices
of each of the symbols from Yahoo, and performs a cointegration test for
each pair of symbols.  Returns a \code{data.frame} containing the results of the
tests.
}
\usage{
allpairs.egcm(tickers, 
  startdate = as.numeric(format(Sys.Date() - 365, "\%Y\%m\%d")), 
  enddate = as.numeric(format(Sys.Date(), "\%Y\%m\%d")), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{tickers}{ A list of ticker symbols whose data is to be downloaded
    from Yahoo!.  Alternatively, this may be a \code{data.frame} containing
    the price series to be checked, one series per column.}
  \item{startdate}{The starting date for which to download the data.  
    Given in the form \code{YYYYMMDD}.  Defaults to one year ago.}
  \item{enddate}{The ending date for which to download the data.
    Given in the form \code{YYYYMMDD}.  Defaults to today.}
  \item{\dots}{Other parameters to be passed to \code{\link{egcm}}}
}
\value{
A \code{data.frame} containing the following columns:

\itemize{
\item{series1:}  {Name of the first ticker in this cointegration test}
\item{series2:}  {Name of the second ticker in this cointegration test}
\item{log:}      {Boolean which if TRUE indicates that the cointegration
                 test is performed on the logs of the series}
\item{i1test:}   {Name of the test used for checking that the series are
                 integrated.}
\item{urtest:}   {Name of the test used for checking for a unit root in
                 the residual series}
\item{alpha:}    {Constant term of the linear relation between the series}
\item{alpha.se:} {Standard error of alpha}
\item{beta:}     {Linear term of the linear relation between the series}
\item{beta.se:}  {Standard error of beta}
\item{rho:}      {Coefficient of mean reversion}
\item{rho.se:}   {Standard error of rho}
\item{s1.i1.stat:} {Statistic computed for integration test of first series}
\item{s1.i1.p:}   {p-value for integration test of first series}
\item{s2.i1.stat:} {Statistic computed for integration test of second series}
\item{s2.i1.p:}   {p-value for integration test of second series}
\item{r.stat:}    {Statistic computed for cointegration test (e.g. whether
                  the residual series contains a unit root)}
\item{r.p:}       {p-value associated with r.stat}
\item{eps.ljungbox.stat:}  {Ljung-Box statistic computed on the innovations
                  of the series}
\item{eps.ljungbox.p:}  {p-value associated with the Ljung-Box statistic}
\item{s1.dsd:}    {Standard deviation of the first differences of the first series}
\item{s2.dsd:}    {Standard deviation of the first differences of the second series}
\item{residuals.sd:} {Standard deviation of the residual series}
\item{eps.sd:}    {Standard deviation of the innovations}
\item{is.cointegrated:} {\code{TRUE} if the pair is cointegrated at the 5\% confidence level}

}
}
\author{Matthew Clegg \email{matthewcleggphd@gmail.com}}
\seealso{
\code{\link{egcm}}
}
\examples{
\dontrun{
    # Check if any of the oil majors are cointegrated:
    allpairs.egcm(c("BP","CVX","RDS.A","TOT","XOM"))
}
}
\keyword{ ts }
\keyword{ models }
