
setwd("~/Box\ Documents/8004.s14/Lectures/Lec2_0207")

# Example: Flicker frequency and eye color

flicker <- read.table("~/Box\ Documents/8004.s14/data/flicker.txt",sep="\t",header = TRUE)

attach(flicker)

fit <- lm(Flicker ~ as.factor(Colour), data = flicker)
summary(fit)
anova(fit)
detach(flicker)


# Example: Mental hospital admissions during full moons.

fm <- read.table("~/Box\ Documents/8004.s14/data/fullmoon.txt", header = TRUE)
adm <- fm$Admission

Month.char <-  c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                   "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
month <- factor(fm$Month,levels = Month.char, ordered = TRUE)

Moon.char <- c("Before","During","After")
moon <- factor(fm$Moon, levels = Moon.char, ordered = TRUE)

library(ggplot2)
library(stats)

tapply(adm,moon,mean)
tapply(adm,month,mean)

qplot(month,adm, colour = moon)

fm2 <- data.frame(moon,month,adm)
names(fm2) <- c("Moon","Month","Admission")
ggplot(fm2, aes(Month, Admission, color = Moon, group = Moon)) + 
  geom_point() + geom_line()

fit <- lm(Admission ~ Moon + Month, data = fm)
summary(fit)
anova(fit)

aov(formula = Admission ~ Month + Moon, data = fm, na.action =
      na.exclude)



# Example: Age and Memory

memory <- read.table("~/Box\ Documents/8004.s14/data/memory.txt", header = TRUE)
N <- dim(memory)[1]
a <- 2
b <- 5
n <- N/(a*b)

library(ggplot2)
library(stats)

memory$Process <- factor(memory$Process, 
                         levels = c("Counting","Rhyming","Adjective",
                                    "Imagery","Intentional"),
                         ordered = TRUE)
memory$Age <- factor(memory$Age, levels = c("Younger", "Older"), ordered = TRUE)

attach(memory)
tapply(Words,Age,mean)
tapply(Words,Process,mean)

ggplot(memory, aes(Process, Words, color = Age, group = Age)) + 
  geom_point() + geom_line()

fit <- lm(Words ~ Age + Process, data = fm)
summary(fit)
anova(fit)

aov(formula = Words ~ Age + Process, data = fm, na.action =
      na.exclude)


