library(nlme)
library(lme4)


pigment <- read.table("pigment.dat", 
      col.names=c("Batch","Sample","Test","Y"))
pigment$Batch <- as.factor(pigment$Batch)
pigment$Sample <- as.factor(pigment$Sample)





pmt.lme <- lme(Y ~ 1, 
    random=~1|Batch/Sample, data=pigment,
    method=c("REML"))

pmt.lme2<-lmer(Y~1+(1|Batch)+(1|Batch:Sample),data=pigment)

confint(pmt.lme2)

pmt.lme3<-lmer(Y~1+(1|Batch),data=pigment)
anova(pmt.lme3,pmt.lme2)

require(lattice)
ranef(pmt.lme2)
str(rr1 <- ranef(pmt.lme2, condVar = TRUE))
dotplot(rr1)



 plot(fitted(pmt.lme2), residuals(pmt.lme2),
       xlab="Estimated Means",
       ylab="Residuals",
       main="Residual Plot")
  abline(h=0, lty=2, lwd=3)

  png('fig3.png')
  qqnorm(residuals(pmt.lme2))

  qqline(residuals(pmt.lme2))
  dev.off()




