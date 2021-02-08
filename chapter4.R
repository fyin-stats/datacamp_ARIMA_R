#######################
######################
######################
# chapter 4
# season arima
######################
######################

# Pure seasonal models
# SAR(P=1)_{s=12}
# X_t = \phi X_{t-12} + W_t

######################
######################

## ACF and PACF of pure seasonal models
## 
## ACF: SAR(P)s tails off, SMA(Q)s cuts off lag QS, SARMA(P,Q)s tails off
## PACF: SAR(P)s cuts off lag PS, SMA(Q)s tails off, SARMA(P,Q)s tails off

## Exactly right! The ACF tails off at seasonal lags, 
## while the PACF cuts off after lag 12. This fits with a SAR(1)12 model. 

## Fit a pure seasonal model
## 

# Plot sample P/ACF to lag 60 and compare to the true values
acf2(x, max.lag = 60)

# Fit the seasonal model to x
sarima(x, p = 0, d = 0, q = 0, P = 1, D = 0, Q = 1, S = 12)


# mixed seasonal models
# SARIMA(p,d,q) * (P,D,Q)s
# s indicates seasonal component

# fr example, SARIMA(0,0,1) * (1,0,0)s=12
# X_t = \phi X_{t-12} + W_t + \theta W_{t-1}
# SAR(1): value this month is related to last year's value X_{t-12}
# MA(1): this month's value related to last month's shock W_{t-1} (i.e, error)
# ACF and PACF 
# first focus on the seasonal
# then focus on the non-seasonal
# look at when they tail off and cuts off
# Quarterly occupancy rate: % rooms filled
# remove seasonal persistence by a seasonal difference
# air passengers
# x: airpassengers
# lx: log(x)
# dlx: diff(lx)
# ddlx: diff(dlx, 12)

# ACF and PACF of ddlx
# seasonal: ACF cutting off at lag 1s (s=12); PACF tailing off at lags 1s, 2s, 3s, ...
# this suggests seasonal MA(1), so P = 0, Q = 1
# next, look at non-seasonal lags
# both ACF and PACF are tailing off, this suggests ARMA(1,1)
# 


# as the variance goes up, log is probably a good idea
# as there is obvious trend, differencing data is needed
# then take off the seasonal persistence by seasonal difference
# now the data looks stationary
# at this point, we have d = 1, D=1, s=12
# first examine the acf and PACF at seasonal lags to figure out P and Q
# then examine the acf and pacf to figure out p and q

# conclusion:
# SARIMA(1,1,1) * (0,1,1)_12 model is appropriate on the logged data
# 

# Plot sample P/ACF pair to lag 60 and compare to actual
acf2(x, max.lag=60)

# Fit the seasonal model to x
sarima(x, p=0, d=0, q=1,
       P=0, D=0, Q=1, S=12)


# Plot unemp 
plot(unemp)

# Difference your data and plot
d_unemp <- diff(unemp)
plot(d_unemp)

# Plot seasonal differenced diff_unemp
dd_unemp <- diff(d_unemp, lag = 12)   
plot(dd_unemp)




######## SARIMA model to the monthly US unemployment unemp time series
######## by looking at the sample ACF and PACF of the fully differenced series
######## 
# Plot P/ACF pair of the fully differenced data to lag 60
dd_unemp <- diff(diff(unemp), lag = 12)
acf2(dd_unemp, max.lag = 60)

# Fit an appropriate model
sarima(unemp, p = 2, d = 1, q = 0, P = 0, D = 1, Q = 1, S = 12)



#########
#########
# chicken data set in astsa package

# Plot differenced chicken
plot(diff(chicken)) 

# Plot P/ACF pair of differenced data to lag 60
acf2(diff(chicken), max.lag = 60)

# Fit ARIMA(2,1,0) to chicken - not so good
sarima(chicken, p = 2, d = 1, q = 0)

# Fit SARIMA(2,1,0,1,0,0,12) to chicken - that works
sarima(chicken, p = 2, d = 1, q = 0, P = 1, D = 0, Q = 0, S = 12)


# birth dataset in astsa
# 

# Plot P/ACF to lag 60 of differenced data
d_birth <- diff(birth)
acf2(d_birth, max.lag=60)

# Plot P/ACF to lag 60 of seasonal differenced data
dd_birth <- diff(d_birth, lag = 12)
acf2(dd_birth, max.lag = 60)

# Fit SARIMA(0,1,1)x(0,1,1)_12. What happens?
sarima(birth, p=0,d=1,q=1, P=0,
       D=1, Q=1, S=12)

# Add AR term and conclude
sarima(birth, p=1,d=1,q=1, P=0,
       D=1, Q=1, S=12)

#
# Well done! The residual analysis from the first fit indicated that the 
# residuals were not white noise. Hence, it was necessary to include 
# an additional nonseasonal AR term to account for the extra correlation. 


# Forecasting ARIMA processes
# once the model is chosen, forecasting is easy because the model describes
# how the dynamic of the time series behave over time
# simply continue the model dynamics into the future
# in the astsa package, use sarima.for for forecasting
# Forecasting Air passenges
# sarima.for()

# what you've learned
# how to identify an ARMA model from data looking at ACF and PACF
# how to use integrated ARMA (ARIMA) models for nonstationary time series
# how to cope with seasonality

# astsa package
# 

# 