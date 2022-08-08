
# Uploading data ----------------------------------------------------------

library(MASS)
df <- Boston

# Linear Regression -------------------------------------------------------

linearfm <- lm(medv~lstat, df)
nomial <- lm(data=df, medv~I(lstat^100))
summary(linearfm)

# Residuals:
# Min      1Q  Median      3Q     Max 
# -15.168  -3.990  -1.318   2.034  24.500 

# Coefficients:
#  Estimate Std. Error t value            Pr(>|t|)    
# (Intercept) 34.55384    0.56263   61.41 <0.0000000000000002 ***
#  lstat       -0.95005    0.03873  -24.53 <0.0000000000000002 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Residual standard error: 6.216 on 504 degrees of freedom
# Multiple R-squared:  0.5441,	Adjusted R-squared:  0.5432 
# F-statistic: 601.6 on 1 and 504 DF,  p-value: < 0.00000000000000022

# Plot --------------------------------------------------------------------

#Using Base R
plot(df$lstat, df$medv, pch = 16, cex = 1.3, col = "red", 
     main = "lstat vs medv", xlab = "lstat", ylab = "medv")

abline(linearfm)

#Using ggplot
ggplot(data=df, mapping=aes(x=lstat, y=medv), ) + 
  geom_point()+
  geom_smooth(method="lm", formula=y~poly(x,2), se=FALSE)


summary(nomial)
confint(linearfm, level=0.95)
predict(linearfm$lstat, linearfm$medv)



  