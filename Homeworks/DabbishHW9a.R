
library(MASS); library(xtable);library(nlme)
  lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
   x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
   print(x, floating=FALSE, tabular.environment="pmatrix", 
     hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
   }

library(faraway)
data(orings)

plot(damage/6 ~ temp, orings, xlim=c(25,85), ylim =c(0,1), xlab ="Temperature", ylab = "Prob of damage")

##fit a line to the data
lmod <- lm(damage/6 ~ temp, orings)
abline(lmod)

###logit is default link choice
logitmod <- glm(cbind(damage, 6-damage) ~temp, family=binomial, orings)
summary(logitmod)


plot(damage/6 ~ temp, orings, xlim=c(25,85), ylim =c(0,1), xlab ="Temperature", ylab = "Prob of damage")
x <- seq(25,85,1)
lines(x, ilogit(11.6630-0.2162*x)) #ilogit is inverse logit function

probitmod <- glm(cbind(damage, 6-damage) ~temp, family=binomial(link=probit), orings)
summary(probitmod)
lines(x, pnorm(5.59145-0.10580*x),lty=2)

logitmod <- glm(cbind(damage, 6-damage) ~temp, family=binomial, orings)
devtest <- pchisq(logitmod$null-logitmod$deviance,
                  logitmod$df.null-logitmod$df.residual,lower=FALSE)

probitmod <- glm(cbind(damage, 6-damage) ~temp, family=binomial(link=probit), orings)
probitdevtest <- pchisq(probitmod$null-probitmod$deviance,
                  probitmod$df.null-probitmod$df.residual,lower=FALSE)

clogmod <- glm(cbind(damage, 6-damage) ~temp, family=binomial(link=cloglog), orings)
clogdevtest <- pchisq(clogmod$null-clogmod$deviance,
                  clogmod$df.null-clogmod$df.residual,lower=FALSE)

cauchitmod <- glm(cbind(damage, 6-damage) ~temp, family=binomial(link=cauchit), orings)
cauchitdevtest <- pchisq(cauchitmod$null-cauchitmod$deviance,
                  cauchitmod$df.null-cauchitmod$df.residual,lower=FALSE)

logmod <- glm(cbind(damage, 6-damage) ~temp, family=binomial(link=log), orings)
logdevtest <- pchisq(logmod$null-logmod$deviance,
                  logmod$df.null-logmod$df.residual,lower=FALSE)

myorings <- orings
myorings[,3] <- ifelse(myorings[,2]>0,1,0)
colnames(myorings)[3] <- "Ind" 
binmod <- glm(Ind ~ temp, family=binomial(link=logit), data=myorings)
summary(binmod)

bindevtest <- pchisq(binmod$null-binmod$deviance,
                  binmod$df.null-binmod$df.residual,lower=FALSE)
