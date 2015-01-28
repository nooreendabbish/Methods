setwd("~/Box\ Documents/8003.f13/Lectures/lec12_1114/")

### Ret Loss Data

retloss = read.table("~/Box\ Documents/8003.f13/Data/retloss.txt",
    header=TRUE)

n = nrow(retloss)
p1 = 3
p = 4
X =  cbind(rep(1,n),retloss$Rain, retloss$Period, retloss$Temp)
Y =  matrix(retloss$RetLoss,n,1)


## Linear regression
beta = solve(t(X)%*%X)%*%t(X)%*%Y
beta
sig2 = sum((Y-X%*%beta)^2)/(n-p)
sig2
beta.cov = sig2*solve(t(X)%*%X)
beta.cov
beta.sd = sqrt(diag(beta.cov))
beta.sd

fit = lm(RetLoss ~ Rain + Period + Temp, data = retloss)
summary(fit)



## Test the effect of all three covariates
Px = X%*%solve(t(X)%*%X)%*%t(X)
J = matrix(1,n,n)
I = diag(1,n,n)
SSRm = t(Y)%*%(Px-J/n)%*%Y
SSRm
SSRm/p1
SSE = t(Y)%*%(I-Px)%*%Y
SSE
SSE/(n-p1-1)
SSTm = SSRm + SSE
SSTm
F = (SSRm/p1)/(SSE/(n-p1-1))
F
cutoff = qf(0.05,df1=p1, df2=n-p1-1)
cutoff
pval = 1-pf(F,df1=p1,df2=n-p1-1)
pval


## Test the effect of rain and temperature
K = matrix(c(0,1,0,0,0,1,0,-1),4,2)
s = 2
Kb.mid = t(K)%*%solve(t(X)%*%X)%*%K
F.num = t(t(K)%*%beta)%*%solve(Kb.mid)%*%(t(K)%*%beta)
F.den = s*sig2
F = F.num/F.den
F
cutoff = qf(0.05,df1=p1, df2=n-p1-1)
cutoff
pval = 1-pf(F,df1=p1,df2=n-p1-1)
pval



### Man Mass Data

mass = read.table("~/Box\ Documents/8003.f13/Data/mass.txt",header=TRUE)
pairs(Mass ~ Fore + Bicep + Chest + Neck + Shoulder + Waist +
      Height + Calf + Thigh + Head, data = mass, cex = 0.4, font.labels=2)

fit = lm(Mass ~ Fore + Bicep + Chest + Neck + Shoulder + Waist +
      Height + Calf + Thigh + Head, data = mass)
summary(fit)

n = nrow(mass)
mass1 = scale(mass,scale=TRUE)
Y = mass1[,1]
X = mass1[,-1]
eig = eigen(t(X)%*%X)
eig$values
V = eig$vectors
V
Z = X%*%V


par(mfrow=c(2,2),mar=c(5,5,0.5,0.5), cex.lab=1.5)
plot(Z[,1],Z[,2],xlab="first pc", ylab="second pc", xlim=c(-5,5),ylim=c(-5,5))
plot(Z[,1],Z[,3],xlab="first pc", ylab="third pc", xlim=c(-5,5),ylim=c(-5,5))
plot(Z[,2],Z[,3],xlab="second pc", ylab="third pc", xlim=c(-5,5),ylim=c(-5,5))
plot(Z[,1],Z[,10],xlab="first pc", ylab="last pc", xlim=c(-5,5),ylim=c(-5,5))

fit = lm(Y ~ Z-1) # fit with all variables
summary(fit)

fit3 = lm(Y ~ Z[,1:3]-1) # fit with the first three variables
summary(fit3)
# Note that the beta estimates are same as those in the full model. 
# They are same because PCs are orthogonal with each other.

fit2 = lm(Y ~ Z[,1:2]-1)
summary(fit2)
