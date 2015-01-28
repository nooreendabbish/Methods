
setwd("~/Box\ Documents/8004.s14/Lectures/Lec11/")


# Example 2: Eye flicker frequency vs. eye color

flicker <- read.table("~/Box\ Documents/8004.s14/Data/flicker.txt",header=TRUE)

tapply(flicker$Flicker,flicker$Colour,mean)

par(mar = c(4.5,4.5,1,1))
plot(Flicker~Colour, data = flicker, xlab="Eye color", ylab="Flicker frequency")

# Exmaple 1: Personnel management in a large enterprise

apex <- read.table("~/Box\ Documents/8004.s14/Data/apexdata.txt",header=TRUE)

tapply(apex$Evaluation,apex$Officer,mean)

par(mar = c(4.5,4.5,1,1))
plot(Evaluation ~ Officer, data = apex, xlab="Interviewer", ytab="Rating")

library("nlme")
fm1 <- lme(Evaluation ~ 1, data = apex, random = ~ 1|Officer)
summary(fm1)
anova(fm1)

aov(Evaluation ~ Error(Officer), data = apex)


# Example 3: Sodium in Beer
Sodium <- c(24.4,22.6,23.8,22.0,24.5,22.3,25.0,24.5,
    10.2,12.1,10.3,10.2,9.9,11.2,12.0,9.5,
    19.2,19.4,19.8,19.0,19.6,18.3,20.0,19.4,
    17.4,18.1,16.7,18.3,17.6,17.5,18.0,16.4,
    13.4,15.0,14.1,13.1,14.9,15.0,13.4,14.8,
    21.3,20.2,20.7,20.8,20.1,18.8,21.1,20.3)
Brand <- factor(paste("Brand",rep(1:6,rep(8,6)), sep=""))
Bottle <- rep(1:8,6)
beer <- data.frame(Sodium,Brand,Bottle)

par(mar = c(4.5,4.5,1,3.5))
boxplot(Sodium ~ Brand, data = beer, xlab = "Brand", ylab = "Sodium")

fm3 <- lme(Sodium ~ 1, data = beer, random = ~ 1|Brand)
summary(fm3)
anova(fm3)

