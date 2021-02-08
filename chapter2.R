######################
######################
######################
## ARIMA modeling
######################
######################
######################

# chapter 2: AR and MA models
# ACF and PACF

# ACF: tails off for AR(p), cuts off lag q for MA(q), ARMA(p, q), tails off
# PACF: cuts off lag p for AR(p), tails off for MA(q), ARMA(p, q), tails off
# start with p=1, q=1
# Estimation for time series is similar to using least squares for regression
# 

x <- arima.sim(list(order = c(2,0,0)),
               ar = c(1.5, -0.75),
               n=200) + 50

x_fit <- sarima(x, p=2, d=0, q=0)
x_fit_table

# 
# Generate 100 observations from the AR(1) model
x <- arima.sim(model = list(order = c(1, 0, 0), ar = .9), n = 100) 

# Plot the generated data 
plot(x)

# Plot the sample P/ACF pair
acf2(x)

# Fit an AR(1) to the data and examine the t-table
x_fit <- sarima(x, p=1, d=0, q=0)

# astsa is preloaded

# Plot x
plot(x)

# Plot the sample P/ACF of x
acf2(x)

# Fit an AR(2) to the data and examine the t-table
x_fit <- sarima(x, p=2, d=0, q=0)


# 

# Plot x
plot(x)

# Plot the sample P/ACF of x
acf2(x)

# Fit an AR(2) to the data and examine the t-table
x_fit <- sarima(x, p=2, d=0, q=0)


# AR and MA together
# ARMA
# Xt = \phi * X_t-1 + W_t + \theta W_t-1
# autoregression with correlated errors
# can't just tell the values of p and q from ACF and PACF directly from 
# the ACF and PACF plot
# start small (e.g., p=1, q=1)

# Exactly! Remember that an MA(q) model has an ACF that cuts off 
# at lag q and a PACF that tails off. In this case, the ACF cuts 
# off at lag 1 and the PACF tails off, suggesting an MA(1) model. 



# Model choice: AIC and BIC
# average(observed - predicted)^2 + k(p+q)
# for AIC: k=2
# for BIC: k = log(n)
# goal: find the model with the smallest AIC or BIC
# AIC and BIC penalizes model differently
# sarima can offer information about AIC and BIC

# residual analysis: want to make sure
# the residual is white noise
# standardized residuals
# sample ACF or residuals
# normal Q-Q plot
# Q-statistic p-value (blue line)

# Bad residuals
# Pattern in the residuals
# ACF has large values

# QQ plot suggests normality
# Q-statistic - all points below line

# 
# Fit an MA(1) to dl_varve.   
sarima(dl_varve, p=0, d=0, q=1)

# Fit an MA(2) to dl_varve. Improvement?
sarima(dl_varve, p=0, d=0, q=2)

# Fit an ARMA(1,1) to dl_varve. Improvement?
sarima(dl_varve, p=1, d=0, q=1)

# sarima run includes a residual analysis
# 


# Calculate approximate oil returns
oil_returns <- diff(log(oil))

# Plot oil_returns. Notice the outliers.
plot(oil_returns)

# Plot the P/ACF pair for oil_returns
acf2(oil_returns)

# Assuming both P/ACF are tailing, fit a model to oil_returns
sarima(oil_returns, p=1, d=0, q=1)


# 