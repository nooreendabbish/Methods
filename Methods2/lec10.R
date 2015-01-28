
setwd("~/Box\ Documents/8004.s14/Lectures/Lec10/")

# Example. Passengers on Titanic.

dat <- read.table("~/Box\ Documents/8004.s14/data/titanicpassenger.txt",header=TRUE,sep="\t")
na.ind <- is.na(dat)
ind <- which(apply(na.ind,1,sum)==0)
titanic <- dat[ind,]

summary(factor(titanic$Survived))
summary(titanic$PClass)
summary(titanic$Age)
hist(titanic$Age)
summary(titanic$Sex)

# Wald tests
fit <- glm(Survived ~ PClass + Age + Sex, data = titanic, family = binomial)
summary(fit)

# Likelihood ratio tests
library("lmtest")
fit0 <- glm(Survived ~ 1, data = titanic, family = binomial)
fit1 <- glm(Survived ~ Age + Sex, data = titanic, family = binomial)
lrtest(fit,fit0) # Test whether the effect of PClass = 0.
lrtest(fit,fit1) # Test whether the effect of all variables = 0.

# Score test
anova(fit,fit0,test="Rao") # Test whehter the effect of all variables = 0.


# Example: knee injuries

# Without interatction

success <- factor(rep(c(1,0,1,0),c(55,45,70,30)))
trt <- factor(rep(c(1,0,1,0,1,0,1,0),c(40,15,30,15,15,55,5,25)))
injury <- factor(rep(c(1,0),c(100,100)))
knee <- data.frame(success,trt,injury)

fit.noint <- glm(success ~ trt + injury, data = knee, family = binomial)
summary(fit.noint)
exp(fit.noint$coef[2]) # common odds ratio


fit.int <- glm(success ~ trt + injury + trt*injury, data = knee, family = binomial)
summary(fit.int)
exp(fit.int$coef[2]) # odds ratio in twist injury group
exp(fit.int$coef[2] + fit.int$coef[4]) # odds ratio in direct injury group



