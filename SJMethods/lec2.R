n <- 100000

## Uniform distribution
x <- runif(n, 0, 1 )
hist(x)
plot( density(x, from=0, to=1), xlab="x", ylab="density", main="uniform" )
dev.off()

## Normal distribution
x.norm <- rnorm(n, 0, 1)
x.axis <- c(1:1000)/100-5
plot( x.axis, dnorm(x.axis, 0, 1), 'l', col='red', xlab="x", ylab="pdf", main="Normal", ylim=c(0,1.5), cex.lab=1.5, cex=2 )
points(x.axis, dnorm(x.axis, 1,1), 'l', col='green')
points(x.axis, dnorm(x.axis, 1, 2),'l', col='blue' )
points(x.axis, dnorm(x.axis, 1, 1/3), 'l',col='black')
legend(x=-4,y=1.2, c('mu=0,sigma=1','mu=1,sigma=1','mu=1,sigma=2','mu=1,sigma=1/3'), lty=c(1,1,1,1), col=c('red','green','blue', 'black'), cex=2 )
dev.off()

## There are four functions for each given distriubtion, pnorm, qnorm, dnorm, rnorm
## rnorm: generate random numbers;
## pnorm: calculate cdf function;
## qnorm: calculate the quantile;
## dnorm: calculate the density
pnorm( 1, lower.tail= TRUE)
qnorm( 0.05, lower.tail=FALSE)


## Exponential distribution
x.axis <- c(1:1000)/100
plot( x.axis, dexp(x.axis, 1), 'l', col='red', xlab="x", ylab="pdf", main="Exponential", ylim=c(0,1.5), cex.lab=1.5, cex=2 )
points(x.axis, dexp(x.axis, 0.5), 'l', col='green')
points(x.axis, dexp(x.axis, 2),'l', col='blue' )
legend(x=4,y=1, c('lambda=1','lambda=0.5','lambda=2'), lty=c(1,1,1), col=c('red','green','blue'),cex=2 )


dev.off()


## Gamma
par(mfrow=c(2,1))
x.gamma <- rgamma(n, shape=2, rate=2)
x.axis <- c(1:1000)/100
plot( density(x.gamma, from=0), 'l', col='red', xlab="x", ylab="density", main="Gamma", ylim=c(0,1), cex.lab=1.5, cex=2)
points( x.axis, dgamma( x.axis, shape=2, rate=2), 'l', col='green')
legend(x=2.5,y=0.5, c('Density estimation','True density'), lty=c(1,1), col=c('red','green'),cex=2 )
###### CDF of gamma distribution

plot(x.axis, pgamma( x.axis, shape=2, rate=2), 'l', col='red', xlab="x", ylab="cdf", main="Gamma", cex.lab=1.5, cex=2)
dev.off()

## Inverse gamma
library(MCMCpack)
x.invgamma <- rinvgamma(n, shape=4, scale=1/2)
x.axis <- c(1:1000)/100
plot( density(x.invgamma, from=0), 'l', col='red', xlab="x", ylab="density", main="InvGamma", cex.lab=1.5, cex=2)
points( x.axis, dinvgamma( x.axis, shape=4, scale=1/2), 'l', col='green')
legend(x=2,y=4, c('Density estimation','True density'), lty=c(1,1), col=c('red','green'),cex=2 )
dev.off()


## Covariance
x <- c(1:100)/10-5
y1 <- 2*x
y2 <- -2*x
y3 <- 2*x+ rnorm(100, 0, 1)
y4 <- -2*x + rnorm(100, 0, 3)
y5 <- sin(x) + rnorm(100, 0,1 )
y6 <- x^2 + rnorm( 100, 0 ,1)

par(mfrow=c(2,3))
plot(x, y1, main="rho=1", cex=2)
plot(x, y2, main="rho=-1", cex=2)
plot(x, y3, main="rho>0", cex=2)
plot(x, y4, main="rho<0", cex=2)
plot(x, y5, main="rho=0", cex=2)
plot(x, y6, main="rho=0", cex=2)
