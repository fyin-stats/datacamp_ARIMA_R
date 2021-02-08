################ chapter 3
################ integrated ARMA
###############
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    try(sapply(pkg, require, character.only = TRUE), silent = TRUE)
}
packages <- c("astsa", "xts")
ipak(packages)
################ Identifying ARIMA
################ A time series exhibits ARIMA behavior if the differenced data has ARMA behavior
################ 
x <- arima.sim(list(order = c(1,1,0), ar = 0.9), n = 200)
plot(x, main = "ARIMA(p=1, d=1, q=0)")
plot(diff(x), main = "ARMA(p=1,d=0,q=0)")

################
################
################
x <- arima.sim(list(order = c(1,1,0), ar = 0.9), n=200)
acf2(x)

acf2(diff(x))

################
################
################
################
################

ARIMA(1,1,1)


################
################
# ARIMA diagnostics
################
################
# weekly oil prices ARIMA(1,1,1)
################
################
window(oil, end = 2006)

################
################

# Exellent! Your model diagnostics suggest that both the ARIMA(0,1,2) 
# and the ARIMA(1,1,1) are reasonable models. 
# However, the AIC and BIC suggest that the ARIMA(0,1,2) performs slightly better, 
# so this should be your preferred model. Although you were not asked to do so, 
# you can use overfitting to assess the final model. For example,
# try fitting an ARIMA(1,1,2) or an ARIMA(0,1,3) to the data. 


################
# Forecasting ARIMA 
################

# the model describes how the dynamics of the time series behave over time
# forecasting simply continues the model dynamics into the future
# sarima.for() to forecast in the astsa package

# Forecasting ARIMA processes
# use window function to extract a subset of the time series
oil <- window(astsa::oil, end = 2006)
oilf <- window(astsa::oil, end = 2007)

sarima.for(oil, n.ahead = 52, 1, 1, 1) # forcast ahead 52 weeks
lines(oilf) # add the held-out data to the figure

#
# Plot P/ACF pair of differenced data 
acf2(diff(x))

# Fit model - check t-table and diagnostics
sarima(x, p = 1, d = 1, q = 0)

# Forecast the data 20 time periods ahead
sarima.for(x, n.ahead = 20, p = 1, d = 1, q = 0) 
lines(y)


# 


