
library(MASS); library(xtable);library(nlme)
  lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
   x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
   print(x, floating=FALSE, tabular.environment="pmatrix", 
     hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
   }

library(faraway)
data(eggprod)

pdf(file="eggprod1.pdf")
library(faraway)
data(eggprod)
attach(eggprod)

#First take a look at the data.
summary(eggprod)
eggprod

par(mfrow=c(2,2))
plot(block,eggs,data=eggprod,main="Boxplot of Egg Production By Block")
plot(treat,eggs,data=eggprod,main="Boxplot of Egg Production By Treatment")
interaction.plot(block,treat,eggs, data=eggprod,main="Interaction Plot of Egg Production \nwith Block as X Factor, \nTreatment as Trace Factor")
interaction.plot(treat,block,eggs, data=eggprod,main="Interaction Plot of Egg Production \nwith Treament as X Factor, \nBlock as Trace Factor")

#Fit the model.
library(nlme)
options(contrasts=c("contr.treatment","contr.poly"))


eggs.lme <- lme(eggs ~ 0+treat, 
            random = ~1|block, data=eggprod, method=c("ML"))


library(lme4)
#eggs.lmer <- lmer(eggs ~ treat+(1|block), data=eggprod)

summary(eggs.lme)

dev.off()

lvector(model.matrix(lme(eggs ~ 1 + treat, 
              random = ~1|block, 
              data=eggprod)), dig=0)

eggs.lme2 <- lme(eggs ~ 1 + treat, 
            random = ~1|block, data=eggprod, method=c("ML"))
eggs.lme3 <- lme(eggs ~ 1, random = ~1|block, data=eggprod, method=c("ML"))
LL2 <- logLik(eggs.lme2)
LL3 <- logLik(eggs.lme3)
W2 <- as.numeric(-2*(LL3-LL2))
test <- qchisq(.95, 2)

> library(faraway)
> data(lawn)

pdf(file="lawnplots.pdf")

attach(lawn)
lawn
summary(lawn)
dim(lawn)

 par(mfrow=c(2,2))
plot(machine,time,data=lawn,main="Boxplot of Time By Machine")
plot(speed,time,data=lawn,main="Boxplot of Time By Speed")
plot(manufact,time,data=lawn,main="Boxplot of Time By Manufacturer")
dev.off()

pdf(file="lawnplots2.pdf")

par(mfrow=c(2,2))
interaction.plot(manufact,speed,time, data=lawn,main="Interaction Plot of Cut-off times \nwith Manufacturer as X Factor, \nSpeed as Trace Factor")
interaction.plot(speed,manufact,time, data=lawn,main="Interaction Plot of Cut-off times \nwith Speed as X Factor, \nManufacturer as Trace Factor")
dev.off()

lawn.lme <- lme(time ~ manufact + speed + manufact*speed, 
                random=~1|manufact/machine, data=lawn, method=c("REML"))

summary(lawn.lme)

lawn.lme <- lme(time ~ manufact + speed + manufact*speed, 
                random=~1|manufact/machine, data=lawn, method=c("ML"))

lawn.lme2 <- lme(time ~ speed, 
                 random=~1|manufact/machine, data=lawn, method=c("ML"))

anova(lawn.lme,lawn.lme2)

LL <- logLik(lawn.lme)
LL2 <- logLik(lawn.lme2)
W2 <- as.numeric(-2*(LL2-LL))
test2 <- qchisq(.95,2)

lawn.lm4 <- lm(time ~ speed, data=lawn)

lawn.lme2 <- lme(time ~ speed, 
                 random=~1|manufact/machine, data=lawn, method=c("ML"))  

anova(lawn.lme2,lawn.lm4)

LL <- logLik(lawn.lm4)
LL2 <- logLik(lawn.lme2)
W2 <- as.numeric(-2*(LL-LL2))
test2 <- qchisq(.95,5)

lawn.lme2 <- lme(time ~ speed, 
                 random=~1|manufact/machine, data=lawn, method=c("ML"))  
lawn.lme3 <- lme(time ~ speed, 
                 random=~1|machine, data=lawn, method=c("ML"))  


anova(lawn.lme2,lawn.lme3)

LL3 <- logLik(lawn.lme3)
LL2 <- logLik(lawn.lme2)
W2 <- as.numeric(-2*(LL3-LL2))
test2 <- qchisq(.95,1)
