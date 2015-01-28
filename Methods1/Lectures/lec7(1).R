# ------------------------------------------------------------------------
# STAT 8003 Statistical Methods I
# Lecture 7
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# Law School Example: Bootstrap
# ------------------------------------------------------------------------


library(bootstrap)
args(bootstrap)

# Law School Data

lsat <- c(576,635,558,578,666,580,555,661,651,605,653,575,545,572,594)
gpa <- c(3.39,3.30,2.81,3.03,3.44,3.07,3.00,3.43,3.36,3.13,3.12,2.74,2.76,2.88,2.96)
summary(lsat)
summary(gpa)

law.school <- data.frame(lsat,gpa)

#pdf("law_scatter.pdf",width=8,height=6)
plot(lsat,gpa,main="Law School Data", pch = 18, cex = 1.5)
#dev.off()

#pdf("law_histbox.pdf",width=8,height=6)
par(mfrow=c(2,2))
hist(lsat,main='lsat',col='gray')
hist(gpa,main='gpa',col='gray')
boxplot(lsat,main='lsat',col='gray')
boxplot(gpa,main='gpa',col='gray')
#dev.off()

set.seed(49123)

bootstrap(lsat,nboot=10,theta=mean)
lsat.mean.boot <- bootstrap(lsat,nboot=1000,theta=mean)
quantile(lsat.mean.boot$thetastar,c(.025,.975))
lsat.median.boot <- bootstrap(lsat,nboot=1000,theta=median)
quantile(lsat.median.boot$thetastar,c(.025,.975))

# now calculate the correlation

rho = cor(lsat,gpa)
xi = 0.5*log((1+rho)/(1-rho))
rho
xi

rhof = function(x,xdata){
  cor(xdata[x,1],xdata[x,2])
}

xif = function(x,xdata){
  rho = cor(xdata[x,1],xdata[x,2])
  return(0.5*log((1+rho)/(1-rho)))
}    

theta(1:15,law.school)
xif(1:15,law.school)

lsat.boot1 = bootstrap(1:15,nboot=1000,theta=rhof,xdata=law.school)
hist(lsat.boot1$thetastar)
ci1 = quantile(lsat.boot1$thetastar,c(.025,.975))
ci1

lsat.boot2 = bootstrap(1:15,nboot=1000,theta=xif,xdata=law.school)
xistar = lsat.boot2$thetastar
hist(xistar)
rhostar = (exp(2*xistar)-1)/(exp(2*xistar)+1)
hist(rhostar)
ci21 = quantile(lsat.boot2$thetastar,c(.025,.975))
ci2 = (exp(2*ci21)-1)/(exp(2*ci21)+1)
ci2


# final plot of boostrapped statistics
# pdf("law_bcor.eps",width=8,height=6)
par(mfrow=c(1,2))
hist(lsat.boot2$thetastar, col='gray',main='Bootstrap Correlations')
boxplot(lsat.boot2$thetastar, col='gray')
# dev.off()

par(mfrow=c(2,2))
hist(lsat.boot1$thetastar, probability=TRUE,xlab="rho",col='gray',
     main='Boostrap Correlations (Un-transformed)')
hist(xistar, probability=TRUE, xlab="xi",col='gray',
     main='Boostrap Correlations (Transformed)')
hist(rhostar, probability=TRUE, xlab = "rho",col='gray',
     main='Boostrap Correlations (Transformed)')
boxplot(rhostar,xlab ="rho",col='gray',
        main='Boostrap Correlations (Transformed)')
# Type                  95% CI
# Untransformed      (0.42,0.96)  
# Transformed        (0.45,0.96)




# ------------------------------------------------------------------------
# Teenage Suicide Example: Hypothesis Testing
# ------------------------------------------------------------------------

suicide <-  c(1867,1789,1944,2094,2097,1981,1887,2024,1928,2039,1978,1859)
days <- c(31,28,31,30,31,30,31,31,30,31,30,31)
month <- 1:12
names(month) <- c("Jan","Feb","Mar","Apr","May","Jun",
                  "Jul","Aug","Sep","Oct","Nov","Dec")
dat <- data.frame(month,days,suicide,suicide/days)
names(dat) <- c("month","days","suicide","rate per day")
dat

#pdf(file="~/Box\ Documents/8003.f13/Lectures/Lec07_1010/suicide.pdf",width=8,heigh=6)
par(mfrow = c(1,2),oma = c(.5,.5,.5,.5))
plot(1:12,suicide,type = "b",ylab = "Number of Teenage Suicide",
     xlab = "Month", xaxt = "n")
axis(1, at = 1:12, labels = names(month))
plot(1:12, suicide/days, type="b", ylab="Rate of Tennage suicides",
     xlab = "Month", xaxt="n")
axis(1, at=1:12, labels = names(month))
#dev.off()

eio <- days/365*sum(suicide)
two.log.lambda <- 2*sum(suicide*(log(suicide)-log(eio)))
cat("two.log.lambda is", two.log.lambda,"\n")

cutoff <- qchisq(.95,11)
cat("Cutoff is", cutoff, "\n")

p.val <- 1 - pchisq(two.log.lambda,11)
cat("pvalue is", p.val, "\n")
