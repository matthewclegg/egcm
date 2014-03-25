# egcm_extras.R
# Copyright (C) 2014 by Matthew Clegg

# A few extra helper routines for the egcm module.

#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/

yegcm <- function(ticker1, ticker2, 
    start=YMD(-365),   # Starting date for which egcm model is to be constructed
    end=YMD(),         # Ending date for which egcm model is to be constructed
    ...) { # Additional parameters to be passed to egcm
    # Fetches the price series of two securities from Yahoo
    # and constructs a cointegration model from them.

    require(TTR)
    p1 <- getYahooData(ticker1, start, end)
    p2 <- getYahooData(ticker2, start, end)
    prices <- cbind(p1$Close, p2$Close)
    colnames(prices) <- c(ticker1, ticker2)
	e <- egcm(prices, ...)
	e
}
