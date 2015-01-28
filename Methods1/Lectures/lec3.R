setwd("~/Box\ Documents/8003.f13/Lectures/Lec03_0913/")

# Binomial Distribution
x = 0:3
fx = dbinom(x,size=3,p=1/2)
names(fx) = x
par(fin=c(6,6),mar=c(8,3,0.5,0.5))
barplot(fx,xlab="x",ylab="f(x)")

x = -2:5
Fx = pbinom(x,size=3,p=1/2)
names(Fx) = x
par(fin=c(6,6),mar=c(8,3,0.5,0.5))
plot(x,Fx,xlab="x",ylab="F(x)",type="s")

x = 0:10
fx = dbinom(x,size=10,p=0.1)
names(fx) = x
par(fin=c(6,6),mar=c(8,3,0.5,0.5))
pdf("binom.pdf",width=8,height=8) # Save .pdf file
barplot(fx,xlab="x",ylab="f(x)")
dev.off() # Close the plot console

# Geometric Distribution
x = 0:30
fx = dgeom(x,prob=0.2)
names(fx) = x
par(fin=c(6,6),mar=c(8,4,0.5,0.5))
plot(fx,xlab="x",ylab="f(x)",type="p")

# Negative Binomial Distribution
x = 0:50
fx = dnbinom(x,size = 5, prob=0.2)
names(fx) = x
par(fin=c(6,6),mar=c(8,4,0.5,0.5))
plot(fx,xlab="x",ylab="f(x)",type="p")

