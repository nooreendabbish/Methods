
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
par(mfrow=c(2,2))
plot(block,eggs,data=eggprod,main="Boxplot of Egg Production By Block")
plot(treat,eggs,data=eggprod,main="Boxplot of Egg Production By Treatment")
interaction.plot(block,treat,eggs, data=eggprod,main="Interaction Plot of Egg Production with Block as X factor, Treatment as Trace Factor")
interaction.plot(treat,block,eggs, data=eggprod,main="Interaction Plot of Egg Production with Treament as X factor, Block as Trace Factor")

#Fit the model.
options(contrasts=c("contr.treatment","contr.poly"))
library(nlme)

eggs.lme <- lme(eggs ~ 0+treat, random = ~1|block, data=eggprod, method=c("REML"))


library(lme4)
eggs.lme2 <- lmer(eggs ~ treat+(1|block), data=eggprod)

summary(eggs.lme)

dev.off()

> library(faraway)
> data(lawn)
