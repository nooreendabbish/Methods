
library(MASS)
project <- function(A) {A%*%ginv(t(A)%*%A)%*%t(A)}

w1=c(73,102,118,104,81,107,100,87)
w2=c(98,74,56,111,95,88,82,77,86,92)
w3=c(94,79,96,98,102,102)

m1=rep(1,length(w1))
m2=rep(2,length(w2))
m3=rep(3,length(w3))

p1=rep(1,length(w1)+length(w2)+length(w3))

d1=cbind(c(w1,w2,w3),p1,c(m1,m2,m3))


w1=c(90,76,90,64,86,51,72,90,95,78)
w2=c(107,95,97,80,98,74)
w3=c(49,82,73,86,81,97,106)

m1=rep(1,length(w1))
m2=rep(2,length(w2))
m3=rep(3,length(w3))

p1=rep(2,length(w1)+length(w2)+length(w3))

d2=cbind(c(w1,w2,w3),p1,c(m1,m2,m3))

d=rbind(d1,d2)
d=as.data.frame(d)
names(d)=c('y','protein','meat')

d[,2]=as.factor(d[,2])
d[,3]=as.factor(d[,3])


options(contrasts=c("contr.sum","contr.sum"))
lm.out1 <- lm(y~protein*meat,data=d)
summary.aov(lm.out1,ssType=1)

lm.out2 <- lm(y~meat*protein,data=d)
summary.aov(lm.out2,ssType=1)

summary.aov(lm.out1,ssType=3)  # this does not work properly


Xeffects <- model.matrix(lm.out1)
# Type I
ssA <- t(d$y)%*%(project(Xeffects[,1:2])-project(Xeffects[,1]))%*%d$y # R(a|mu)
ssB <- t(d$y)%*%(project(Xeffects[,1:4])-project(Xeffects[,1:2]))%*%d$y # R(b|mu,a)
ssAB <- t(d$y)%*%(project(Xeffects)-project(Xeffects[,1:4]))%*%d$y # R(ab|mu,a,b)


# Type II
ssA <- t(d$y)%*%(project(Xeffects[,1:4])-project(Xeffects[,c(1,3,4)]))%*%d$y # R(a|mu,b)
ssB <- t(d$y)%*%(project(Xeffects[,1:4])-project(Xeffects[,c(1,2)]))%*%d$y # R(b|mu,a)
ssAB <- t(d$y)%*%(project(Xeffects)-project(Xeffects[,1:4]))%*%d$y



Xcells <- matrix(0,47,6)
Xcells[1:8,]<- matrix(rep(c(1,0,0,0,0,0),8),8,6,byrow=T)
Xcells[9:18,]<- matrix(rep(c(0,1,0,0,0,0),10),10,6,byrow=T)
Xcells[19:24,]<- matrix(rep(c(0,0,1,0,0,0),6),6,6,byrow=T)
Xcells[25:34,]<- matrix(rep(c(0,0,0,1,0,0),10),10,6,byrow=T)
Xcells[35:40,]<- matrix(rep(c(0,0,0,0,1,0),6),6,6,byrow=T)
Xcells[41:47,]<- matrix(rep(c(0,0,0,0,0,1),7),7,6,byrow=T)

# Type III
C <- matrix(c(1/3,1/3,1/3,-1/3,-1/3,-1/3),1,6,byrow=T) # For SSprotein

CXXC <- C%*%ginv(t(Xcells)%*%Xcells)%*%t(C)
Cb <- C%*%ginv(t(Xcells)%*%Xcells)%*%t(Xcells)%*%d$y
SSH0 <- t(Cb)%*%solve(CXXC)%*%Cb # Gives the value of SS
SSH0

C <- matrix(c(rep(c(1/3,-1/3,0),2),rep(c(1/3,0,-1/3),2)),2,6,byrow=T) # For SSmeat


CXXC <- C%*%ginv(t(Xcells)%*%Xcells)%*%t(C)
Cb <- C%*%ginv(t(Xcells)%*%Xcells)%*%t(Xcells)%*%d$y
SSH0 <- t(Cb)%*%solve(CXXC)%*%Cb # Gives the value of SS
SSH0

library(car)

Anova(lm.out1,type=2)
Anova(lm.out1,type=3)



