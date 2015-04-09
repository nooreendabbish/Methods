library(nlme)
library(lme4)

penclln=read.table('penicillin.dat',header=F)
names(penclln)=c("Batch","Process","Yield")
penclln$Batch <- as.factor(penclln$Batch)
penclln$Process <- as.factor(penclln$Process)
penclln


# Construct a profile plot.  

attach(penclln)
plot(Yield,outer=~Batch*Process)

#png('fig1.png')


 means <- tapply(Yield,list(Process,Batch),mean)

 x.axis <- unique(Process)
 matplot(c(1,4), c(75,100), type="n", xaxt="n",
      xlab="Process",  ylab="Yield", 
      main= "Penicillin Production Results") 


 axis(1, at=(1:4)*1, labels=c("A", "B", "C", "D"))
 matlines(c(1:4),means,type='l',lty=1:5,lwd=3)         
 
 legend('topleft', legend=c('Batch 1','Batch 2',
     'Batch 3','Batch 4','Batch 5'), lty=1:5,lwd=3,col=1:5,bty='n') 

detach()
#dev.off()


#  Use the  lme( )  function to fit a model
#  with additive batch (random) and process 
#  (fixed) effects and create diagnostic plots.  

options(contrasts=c("contr.treatment",
    "contr.poly"))

penclln.lme <- lme(Yield ~ Process, 
    random= ~ 1|Batch, data=penclln,
    method=c("REML"))

#lme4 package version
penclln.lme2 <- lmer(Yield ~ Process+(1|Batch), data=penclln)


summary(penclln.lme)


summary(penclln.lme)
names(penclln.lme)

#  Contruct ANOVA table for fixed effects
anova(penclln.lme)

# estimated BLUP's for random effects
ranef(penclln.lme)

penclln.lme$coef

# Confidence intervals for fixed effects
# and estimated standard deviations
intervals(penclln.lme)

#confint(penclln.lme2)

# Create a listing of the original data 
# residuals and predicted values

data.frame(penclln$Process,penclln$Batch,
             penclln$Yield,
             Pred=penclln.lme$fitted,
             Resid=round(penclln.lme$resid,3))


# Create residual plots


  plot(penclln.lme$fitted, penclln.lme$resid,
       xlab="Estimated Means",
       ylab="Residuals",
       main="Residual Plot")
  abline(h=0, lty=2, lwd=3)

  png('fig2.png')
  qqnorm(penclln.lme$resid)

  qqline(penclln.lme$resid)
  dev.off()


require(lattice)

str(rr1 <- ranef(penclln.lme, condVar = TRUE))
dotplot(ranef(penclln.lme, condVar = TRUE)) 



