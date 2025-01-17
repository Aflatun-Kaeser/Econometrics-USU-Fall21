# Prof. Pedram Jahangiry

# chapter 6: MRM, Further issues
 
library(wooldridge)
library(stargazer)
library(car)


###############################################################################

# Effects of data scaling on OLS statistics

help(wage2)
reg_orig     <- lm(wage~educ+age,wage2)
reg_scaled_y <- lm(I(wage/1000)~educ+age,wage2)
reg_scaled_x <- lm(wage~educ+I(age/10),wage2)
stargazer(reg_orig, reg_scaled_y, reg_scaled_x, type="text",  column.labels = c("Original", "Scaled Y", "Scaled X"))


#--------------------
# Using quadratic functional form


MRM <- lm(wage ~ exper + I(exper^2) , wage1)
stargazer(MRM, type = "text")


# effect plot 
# install.packages("effects")
library(effects)
plot(effect("exper", MRM))

#------------------------------------------------------------------------------


MRM <- lm(log(price)~log(nox)+log(dist)+rooms+I(rooms^2)+stratio,data=hprice2)
stargazer(MRM, type = "text")

# effect plot 
plot(effect("rooms", MRM))




 ###############################################################################
# Using interactions 
MRM <-lm(stndfnl~ atndrte+ priGPA + ACT 
         + I(priGPA^2) + I(ACT^2)
         + atndrte:priGPA
         , data=attend)

stargazer(MRM, type = "text")

# testing H0: (b1 + 2.59 b6) = 0
linearHypothesis(MRM, c("atndrte+ 2.59 * atndrte:priGPA"))


##############################################################################
# confidence Intervals for predictions


MRM <- lm(colgpa~sat+hsperc+hsize+I(hsize^2),gpa2)

# Define sets of regressor variables
xvalues <- data.frame(sat=c(1200, 1000), hsperc=c(30,50), hsize=c(5,10))

# Point estimates and 95% prediction intervals for these
predict(MRM, newdata =   xvalues, interval = "prediction", level = 0.95)



##############################################################################
reg     <- lm(log(wage)~educ + educ:exper,wage1)
stargazer(reg)
summary(reg)
