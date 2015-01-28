
setwd("~/Box\ Documents/8004.s14/Lectures/Lec3/")

# Example: Mental hospital admissions during full moons.

#fm <- read.table("~/Box\ Documents/8004.s14/Data/fullmoon.txt", header = TRUE)
fm = read.table("U:/8004.s14/Data/fullmoon.txt",header=TRUE)
adm <- fm$Admission

Month.char <-  c( "Aug", "Sep", "Oct", "Nov", "Dec", 
                  "Jan", "Feb", "Mar", "Apr", "May", 
                  "Jun", "Jul")
month <- factor(fm$Month,levels = Month.char, ordered = TRUE)

Moon.char <- c("Before","During","After")
moon <- factor(fm$Moon, levels = Moon.char, ordered = TRUE)

library(ggplot2)
library(stats)

tapply(adm,moon,mean)
tapply(adm,month,mean)
mustar <- tapply(adm, list(moon,month),mean)
mustar
muh <- mean(mustar)
alphah <- apply(mustar,1,mean) - muh
betah <- apply(mustar,2,mean)-muh
muh
alphah
betah

par(mar=c(4.5,4.5,1.5,1.5))
plot(mustar[1,], type="b", col="blue", axes = FALSE,
     cex=1.2, lwd = 2, ylab = "Admission", xlab = "Month", 
     ylim = c(0,25))
lines(mustar[2,], type="b", col="red",cex=1.2, lwd = 2)
lines(mustar[3,], type="b", col="green",cex=1.2, lwd = 2)
axis(1,1:12, c( "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", 
               "Mar", "Apr", "May","Jun", "Jul") )
axis(2)
legend(x=9.5,y=7, c("Before","During","After"), 
       lwd = 2, col = c("blue","red","green"), bty = "n")

fit <- lm(Admission ~ Moon + Month, data = fm)
summary(fit)
anova(fit)

aov(formula = Admission ~ Month + Moon, data = fm, na.action =
      na.exclude)




# Example: Age and Memory

#memory <- read.table("~/Box\ Documents/8004.s14/Data/memory.txt", header = TRUE)
memory = read.table("U:/8004.s14/Data/memory.txt",header=TRUE)
N <- dim(memory)[1]
a <- 2
b <- 5
n <- N/(a*b)


memory$Process <- factor(memory$Process, 
                         levels = c("Counting","Rhyming","Adjective",
                                    "Imagery","Intentional"),
                         ordered = TRUE)
memory$Age <- factor(memory$Age, levels = c("Younger", "Older"), ordered = TRUE)

attach(memory)
tapply(Words,Age,mean)
tapply(Words,Process,mean)
mustar <-  tapply(Words,list(Age,Process),mean)
mustar
muh <- mean(mustar)
alphah <- apply(mustar,1,mean) - muh
betah <- apply(mustar,2,mean)-muh
gammah <- mustar- matrix(alphah, nrow = 2, ncol = 5) - 
          matrix(betah, nrow = 2, ncol = 5, byrow = TRUE) - muh
muh
alphah
betah
gammah



fit1 <- lm(Words ~ Age + Process, data = memory)
summary(fit1)
anova(fit1)

aov(formula = Words ~ Age + Process, data = memory, na.action =
      na.exclude)


par(mar=c(4.5,4.5,1.5,1.5))
plot(mustar[1,], type="b", col="blue", axes = FALSE,
     cex=1.2, lwd = 2, ylab = "Words", xlab = "Process")
lines(mustar[2,], type="b", col="red",cex=1.2, lwd = 2)
axis(1,1:5, c("Counting","Rhyming","Adjective","Imagery","Intentional"))
axis(2)
legend(c(1,18), c("Younger","Older"), 
       lwd = 2, col = c("blue","red"), bty = "n")


fit2 <- lm(Words ~ Age*Process, data=memory)
summary(fit2)

anova(fit2)

aov(formula = Words ~ Age*Process, data=fm)

# Example: Insect Sprays

data(InsectSprays)

par(mar=c(3.5,2.5,1.5,1.5))
boxplot(count~spray,data=InsectSprays)

