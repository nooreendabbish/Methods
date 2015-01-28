# ------------------------------------------------------------------------
# STAT 8003 Statistical Methods I
# 10/11/2012
# ------------------------------------------------------------------------

# -----------------------------------------------------------------------
# Compute 95% CI for Binomial Data
# -----------------------------------------------------------------------

date()
                                  
# -----------------------------------------------------------------------
# Simulation 1: relatively large sample size
# -----------------------------------------------------------------------
set.seed(143804)
n = 30
repit = 100

# initialize the vector to store CIs
ci1 = matrix(0,nrow=repit,ncol=2)
ci2 = matrix(0,nrow=repit,ncol=2)
p = 0.4

for (ii in 1:repit){
  #cat("ii = ", ii, "\n")
  y = rbinom(n,size=1,p=0.4)
  # y is Bernoulli observation

  mean.y = mean(y)
  a = qnorm(1-0.025)

  ci1[ii,1] = mean.y - a*sqrt(mean.y/n)
  ci1[ii,2] = mean.y + a*sqrt(mean.y/n)

  ci2[ii,1] = (sin(asin(sqrt(mean.y))-a/2/sqrt(n)))^2
  ci2[ii,2] = (sin(asin(sqrt(mean.y))+a/2/sqrt(n)))^2
}

plot(1:repit,ci1[,1],ylim=c(0,1),xlab="Repitition",
     ylab="Confidence Interval",type="l",lwd=2)
lines(1:repit,ci1[,2],lwd=2)
lines(1:repit,ci2[,1],col=2,lty=2,lwd=2)
lines(1:repit,ci2[,2],col=2,lty=2,lwd=2)
abline(h=0.4,lty=2,col="gray50")

ct1 = sum((ci1[,1]<p)&(ci1[,2]>p))
ct2 = sum((ci2[,1]<p)&(ci2[,2]>p))

hw1 = mean((ci1[,2]-ci1[,1])/2)
hw2 = mean((ci2[,2]-ci2[,1])/2)

cat("coverage 1 = ", ct1/repit,"\n")
cat("coverage 2 = ", ct2/repit,"\n")

cat("half-width 1 = ", hw1,"\n")
cat("half-width 2 = ", hw2,"\n")

# Result:

# Coverage:
# CI1: 95%, CI2: 91%

# Average half-width:
# CI1: 0.22, CI2: 0.17



# -----------------------------------------------------------------------
# Simulation 2: relatively small sample size
# -----------------------------------------------------------------------
set.seed(151203)
n = 8
repit = 100

# initialize the vector to store CIs
ci1 = matrix(0,nrow=repit,ncol=2)
ci2 = matrix(0,nrow=repit,ncol=2)
p = 0.4

for (ii in 1:repit){
  #cat("ii = ", ii, "\n")
  y = rbinom(n,size=1,p=0.4)
  # y is Bernoulli observation

  mean.y = mean(y)
  a = qnorm(1-0.025)

  ci1[ii,1] = mean.y - a*sqrt(mean.y/n)
  ci1[ii,2] = mean.y + a*sqrt(mean.y/n)

  ci2[ii,1] = (sin(asin(sqrt(mean.y))-a/2/sqrt(n)))^2
  ci2[ii,2] = (sin(asin(sqrt(mean.y))+a/2/sqrt(n)))^2
}

plot(1:repit,ci1[,1],ylim=c(0,1),xlab="Repitition",
     ylab="Confidence Interval",type="l",lwd=2)
lines(1:repit,ci1[,2],lwd=2)
lines(1:repit,ci2[,1],col=2,lty=2,lwd=2)
lines(1:repit,ci2[,2],col=2,lty=2,lwd=2)
abline(h=0.4,lty=2,col="gray50")

ct1 = sum((ci1[,1]<p)&(ci1[,2]>p))
ct2 = sum((ci2[,1]<p)&(ci2[,2]>p))

hw1 = mean((ci1[,2]-ci1[,1])/2)
hw2 = mean((ci2[,2]-ci2[,1])/2)

cat("coverage 1 = ", ct1/repit,"\n")
cat("coverage 2 = ", ct2/repit,"\n")

cat("half-width 1 = ", hw1,"\n")
cat("half-width 2 = ", hw2,"\n")

# Result:

# Coverage:
# CI1: 90%, CI2: 93%

# Average half-width:
# CI1: 0.43, CI2: 0.29
