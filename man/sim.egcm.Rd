\name{sim.egcm}
\alias{sim.egcm}
\title{
Generate simulated data from an Engle-Granger cointegration model
}
\description{
Given an Engle-Granger cointegration model and the number of steps 
to simulate, generates a simulated realization of that model for 
the specified number of steps.  
}
\usage{
sim.egcm(E, nsteps, X0, Y0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{E}{
the Engle-Granger model to be simulated.  See \code{\link{egcm}}
}
  \item{nsteps}{
the number of steps to simulate
}
  \item{X0}{
the starting value of \code{X} to be used in the simulation.
If not specified, uses the last value of \code{X} in \code{E}.
}
  \item{Y0}{
the starting value of \code{Y} to be used in the simulation.
If not specified, uses the last value of \code{Y} in \code{E}.
}
}
\value{
Returns a two-column data.frame, where the first column contains the simulated values of \code{X}, and the second column contains the simulated
values of \code{Y}.
}
\author{
  Matthew Clegg \email{matthewcleggphd@gmail.com}
}
\seealso{
\code{\link{egcm}}
\code{\link{rcoint}}
}
\examples{
# Generate a random pair of cointegrated vectors
cv1 <- rcoint(1000)
# Construct a cointegration model from them
e1 <- egcm(cv1)
# Simulate the model for an additional 1000 steps
cv2 <- sim.egcm(e1, 1000)
# Construct a cointegration model from the simulated data
e2 <- egcm(cv2)
# Compare the original model to the model obtained from simulation
e1
e2
}
