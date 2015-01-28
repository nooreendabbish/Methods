# ------------------------------------------------------------------------
# STAT 8003 Statistical Methods I
# Lecture 13
# ------------------------------------------------------------------------

# -----------------------------------------------------------------------
# US Crime Example
# -----------------------------------------------------------------------

uscrime = read.table("~/Box\ Documents/8003.f13/Data/uscrime.txt",header=TRUE)
uscrime = data.frame(scale(uscrime,center=TRUE,scale=TRUE))


pairs(Crime~., data=uscrime, cex=0.4, cex.labels=2)

fit.a = lm(Crime~.-1, data = uscrime)
summary(fit.a)

fit.p = lm(Crime~.-Time-1, data = uscrime)
summary(fit.p)

# -----------------------------------------------------------------------
# EM algorithm for two-component mixture Gaussian
# -----------------------------------------------------------------------

# Simulated data

set.seed(48512)
n = 10000
mu1 = 7
mu2 = 5
sig1 = sqrt(1.5)
sig2 = sqrt(0.8)
p = 0.2

delta = (runif(n)<p) 
y = (1-delta)*rnorm(n,mean=mu1,sd=sig1) +
    delta*rnorm(n,mean=mu2,sd=sig2)

## dat = data.frame(round(y,2))
## names(dat) = "y"
## write.table(dat,"~/Box\ Documents/8003.f13/Lectures/lec13_1121/mixture.csv",row.names=FALSE,quote=FALSE,sep=",")

# Calculating estimates by EM algorithm

# Initial value 1
mu1.n  = 8
mu2.n  = 4
sig1.n = sqrt(1)
sig2.n = sqrt(1)
p.n  = 0.3


conv.err  = 1
iter  = 0
while((conv.err>1e-8)&(iter<=100)){
  iter  = iter + 1
  cat("iteration = ",iter,"\n")
  mu1.p  = mu1.n
  mu2.p  = mu2.n
  sig1.p = sig1.n
  sig2.p = sig2.n
  p.p  = p.n
  
  gamma.p  = p.p*dnorm(y,mean=mu2.p,sd=sig2.p)/
    ((1-p.p)*dnorm(y,mean=mu1.p,sd=sig1.p) + p.p*dnorm(y,mean=mu2.p,sd=sig2.p))
  mu1.n  = sum(y*(1-gamma.p))/sum(1-gamma.p)
  mu2.n  = sum(y*gamma.p)/sum(gamma.p)
  sig1.n = sqrt(sum((y-mu1.p)^2*(1-gamma.p))/sum(1-gamma.p))
  sig2.n = sqrt(sum((y-mu2.p)^2*gamma.p)/sum(gamma.p))
  p.n  = mean(gamma.p)
  
  cat("mu1 = ", mu1.n,"\n")
  cat("mu2 = ", mu2.n,"\n")
  cat("sig1 = ", sig1.n, "\n")
  cat("sig2 = ", sig2.n, "\n")
  cat("p = ", p.n,"\n")
  theta.n = c(mu1.n, mu2.n, sig1.n, sig2.n, p.n)
  theta.p = c(mu1.p, mu2.p, sig1.p, sig2.p, p.p)
  conv.err  = sum((theta.n-theta.p)^2)
  cat("conv.err",conv.err,"\n")
  cat("\n")
}

mu1.n
mu2.n
sig1.n
sig2.n
p.n

## iteration =  61 
## mu1 =  6.989187 
## mu2 =  3.966503 
## sig1 =  0.9047006 
## sig2 =  0.8863127 
## p =  0.1928706 
## conv.err 7.796459e-09




# Initial value 2
# Initial value 1
mu1.n  = 6
mu2.n  = 6
sig1.n = sqrt(1.2)
sig2.n = sqrt(1.2)
p.n  = 0.1


conv.err  = 1
iter  = 0
while((conv.err>1e-8)&(iter<=100)){
  iter  = iter + 1
  cat("iteration = ",iter,"\n")
  mu1.p  = mu1.n
  mu2.p  = mu2.n
  sig1.p = sig1.n
  sig2.p = sig2.n
  p.p  = p.n
  
  gamma.p  = p.p*dnorm(y,mean=mu2.p,sd=sig2.p)/
    ((1-p.p)*dnorm(y,mean=mu1.p,sd=sig1.p) + p.p*dnorm(y,mean=mu2.p,sd=sig2.p))
  mu1.n  = sum(y*(1-gamma.p))/sum(1-gamma.p)
  mu2.n  = sum(y*gamma.p)/sum(gamma.p)
  sig1.n = sqrt(sum((y-mu1.p)^2*(1-gamma.p))/sum(1-gamma.p))
  sig2.n = sqrt(sum((y-mu2.p)^2*gamma.p)/sum(gamma.p))
  p.n  = mean(gamma.p)
  
  cat("mu1 = ", mu1.n,"\n")
  cat("mu2 = ", mu2.n,"\n")
  cat("sig1 = ", sig1.n, "\n")
  cat("sig2 = ", sig2.n, "\n")
  cat("p = ", p.n,"\n")
  theta.n = c(mu1.n, mu2.n, sig1.n, sig2.n, p.n)
  theta.p = c(mu1.p, mu2.p, sig1.p, sig2.p, p.p)
  conv.err  = sum((theta.n-theta.p)^2)
  cat("conv.err",conv.err,"\n")
  cat("\n")
}

mu1.n
mu2.n
sig1.n
sig2.n
p.n

## iteration =  3 
## mu1 =  6.4062 
## mu2 =  6.4062 
## sig1 =  1.494805 
## sig2 =  1.494805 
## p =  0.1 
## conv.err 1.232595e-30


# You will observe different values of the the estimators.  This is
# because in this problem, there is multiple local maximum.  We only
# observe incomplete data and the information is not enough to
# identify the unique global mle.  If we start from a good initial
# value, we can get reasonable estimator, otherwise, we obtain the
# estimator which is also mle but not close to the true value.

# In this particular example, it is reasonable to assume mu1 <= mu2 since
# mu1 = the expectation of the birth weight of the babies with illegal immigrants parents
# mu2 = the expectation of the birth weight of the normal babies.

# Usually, you can compute using multiple values and compare their
# Q(\hat{\theta}^{(j)},\hat{\theta}^{(j-1)}).

