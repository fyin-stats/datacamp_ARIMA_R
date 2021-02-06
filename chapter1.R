############## Chapter 1
############## ARIMA Models in R
############## https://learn.datacamp.com/courses/arima-models-in-r
############## astsa package
############## “Statistics can't tell you the emotional story. Sure it can give you credible predictions, 
## but what's missing is the eyebrows.”

###############
ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    try(sapply(pkg, require, character.only = TRUE), silent = TRUE)
}
packages <- c("astsa", "xts")
ipak(packages)

#################


### Time series Regression models
### Regression : white noise (independent normals with common variance)
### Time series: Regress today on yesterday
### Autoregression: X_t = \phi X_t-1 + e_t (e_t white noise)
### Moving average: e_t = W_t + \theta W_t-1
### ARMA (combine them together)
### 



###################
### Data play
###################

# plot time series using function plot if it is of xts class

# A times series is stationary when it is "stable"
# meaning:
# the mean is constant over time (no trend)
# the correlation strucutre remains constant over time

# stationarity
# given data x1, ..., xn, we can estimate by averaging
# for example, if the mean is constant, we can estimate it by
# the sample average
# pairs can be used to estimate correlation on different lags
# (x1, x2) ..., (x4, x5) 1lag
# (x1, x3) ..., (x2, x4) 2lag

# Random walk trend
# not stationary, but differenced data are stationary

# Nonstationary in trend and variability
# first log, then difference

# when a time series is trend stationary, it will have
# stationary behavior around a trend, a simple example
# Y_t = alpha + beta t + X_t
# where X_t is stationary

# a different type of model for trend is random walk, which has the form
# Xt = X_t-1 + W_t, 

# in both cases, simple differencing can remove the trend and coerce
# the data to stationary

# Plot detrended y (trend stationary)
plot(diff(y))

# Plot detrended x (random walk)
plot(diff(x))

# Detrending data
# 
# As you have seen in the previous exercise, differencing is 
# generally good for removing trend from time series data. 
# Recall that differencing looks at the difference between the value of a time series at a certain point in time and its preceding value.
# 
# In this exercise, you will use differencing diff() to 
# detrend and plot real time series data.



# Dealing with trend and heteroscedasticity
# Xt = (1+p_t) X_t-1
# return or growth rate of a time series, and this process is often stable

# 
# astsa and xts are preloaded 

# Plot GNP series (gnp) and its growth rate
par(mfrow = c(2,1))
plot(gnp)
plot(diff(log(gnp)))

# Plot DJIA closings (djia$Close) and its returns
par(mfrow = c(2,1))
plot(djia$Close)
plot(diff(log(djia$Close)))



# Stationary time series: ARMA, why?
# Wold decomposition: Wold proved that any stationary time series may be 
# represented as a linear combination of white noise
# X_t = W_t + a1 W_t-1 + a2 W_t-2 + ...
# Any ARMA model has this form, which means they are suited to modeling time
# series
# Special case of MA(q) is already of this form, where constants are 0 after
# q-th term

# Generating ARMA using arima.sim()
# arima.sim(model, n)
# c(p, d, q) 
# n is the length of time series
# 

# generate MA(1) given by
# X_t = W_t + 0.9 W_t-1
# x = arima.sim(list(order = c(0,0,1), ma = 0.9), n=100)
# plot(x)
# Generating and plotting AR(2)
# X_t = -0.9 X_t-2 + Wt
# 

# Generate and plot white noise
WN <- arima.sim(list(order = c(0,0,0)), n=200)
plot(WN)


# Generate and plot an MA(1) with parameter .9 
MA <- arima.sim(list(order = c(0,0,1), ma = 0.9), n=200)
plot(MA)


# Generate and plot an AR(2) with parameters 1.5 and -.75
AR <- arima.sim(list(order = c(2,0,0), ar = c(1.5, -0.75)), n=200)
plot(AR)
