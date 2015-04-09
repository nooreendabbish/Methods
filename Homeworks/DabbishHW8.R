
library(MASS); library(xtable);library(nlme)
  lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
   x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
   print(x, floating=FALSE, tabular.environment="pmatrix", 
     hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
   }

library(faraway)
data(ratdrink)

help(ratdrink)
library(lattice)

ratdrink$thecolor = "black"
ratdrink$thecolor[ratdrink$treat == "thyroxine"] = "red"
ratdrink$thecolor[ratdrink$treat == "thiouracil"] = "blue"
attach(ratdrink)
pdf("ratweights.pdf",width=7,height=5)
plot(weeks, wt, col = thecolor, main="Rat growth weights affected by additives")
legend("topleft", c("Control", "Thyroxine", "Thiouracil"), col=c("black","red","blue"), pch=1)
dev.off()

#####Fit model######
library(lme4)
rat.lme <- lmer(wt ~ weeks+ treat+ weeks*treat+ (1|subject))
summary(rat.lme)

var(ratdrink[treat=="control",]$wt)
myvars <- numeric(10);
for(i in 1:10){
    thisi <- toString(i);
    myvars[i] <- var(ratdrink[subject==thisi,]$wt)
}
mean(myvars)

typeof(weeks)


#######################
sige <- 280/60
sigu <- ((644/12) - sige)/5
siga <- ((1966/2) - 5*sigu - sige)/25

sqrt(280/qchisq(.025,60))

sqrt(280/qchisq(.975,60))

MSB <- 644/12
MSA <- 1966/2
MSE <- 280/60

vhatu <- (sigu)^2/((((MSB/5)^2)/12)+((MSE/5)^2)/60)
vhatu

vhata <- (siga)^2/((((MSB/25)^2)/12)+(((MSA/25)^2)/2))
vhata

sqrt((sigu*vhatu)/qchisq(.975,vhatu))
sqrt((sigu*vhatu)/qchisq(.025,vhatu))

sqrt((siga*vhata)/qchisq(.975,vhata))
sqrt((siga*vhata)/qchisq(.025,vhata))

35 - qt(.975,2)*sqrt(MSA/(3*5*5))
35 + qt(.975,2)*sqrt(MSA/(3*5*5))
