library(faraway)
data(bliss)

m1=glm(cbind(dead,alive)~conc,family=binomial,data=bliss)
summary(m1)
1-pchisq(deviance(m1),df.residual(m1))

m3=glm(cbind(dead,alive)~conc,family=binomial(link=probit),data=bliss)

library(MASS)
data(epil)
head(epil)

m2=glm(y~lbase*trt+lage+V4,family=poisson,data=epil)
summary(m2)