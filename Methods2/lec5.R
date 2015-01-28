
#setwd("~/Box\ Documents/8004.s14/Lectures/Lec5/")
# Example: Olympic Records for High Jump, Discus and Long Jump

olympic <- read.table("~/Box\ Documents/8004.s14/Data/olympic.txt", header = TRUE)
# olympic = read.table("U:/8004.s14/Data/olympic.txt")
plot(LongJump ~ Year, data = olympic)

lj.sum <-summary(olympic$LongJump)
IQR <- lj.sum[5] - lj.sum[2]
names(IQR) <- "IQR"
lower <- lj.sum[2] - 1.5*IQR
upper <- lj.sum[5] + 1.5*IQR
idx <- which( (olympic$LongJump < lower)|(olympic$LongJump > upper)) 
idx

fit <- lm(LongJump ~ Year, data = olympic)
summary(fit)

par(mar = c(6.5,4.5,2,3.5))
FitDiag <- ls.diag(fit)
FitDiag
ExStResid <- FitDiag$stud.res
InStResid <- FitDiag$std.res
plot(FitDiag$hat, ExStResid, xlab="Fitted Value", 
     ylab = "Externally Studentized Residual")
abline(h = 2, col = 2, lty=2)
abline(h = -2, col = 2, lty=2)

idx <- which(abs(ExStResid)>2)

olympic1 <- olympic[-c(1,16),]
fit1 <- lm(LongJump ~ Year, data = olympic1)
summary(fit1)


# Example: Selling Price of Antique Grandfather Clocks
auction = read.table("~/Box\ Documents/8004.s14/Data/auction.txt",header = TRUE)
# auction <- read.table("U:/8004.s14/Data/auction.txt",header = TRUE)

pdf("auction.pdf", width = 8, height = 6)
pairs(~ Age + Bidders + Price, data = auction)
dev.off()

fit1 <- lm(Price~Age + Bidders, data = auction)
summary(fit1)

dg1 <- ls.diag(fit1)
par(mar = c(5.5,5.5,1.5,2))
plot(dg1$std.res ~ dg1$hat, xlab ="Fitted value", 
     ylab = "Internally studentized residuals")
abline(h = 0, col = 2, lty = 2)

# only include one variable "Age" in the model

fit2 <- lm(Price ~ Age, data = auction)
summary(fit2)

dg2 <- ls.diag(fit2)
par(mar = c(5.5,5.5,1.5,2))
plot(dg2$std.res ~ dg2$hat, xlab ="Fitted value", 
     ylab = "Internally studentized residuals")
abline(h = 0, col = 2, lty = 2)




# Example: Cheddar Cheese Taste
cheese <- read.table("~/Box\ Documents/8004.s14/Data/cheese.txt",header=TRUE)
# cheese = read.table("U:/8004.s14/Data/cheese.txt",header = TRUE)
pairs(~ taste + Acetic + H2S + Lactic, data = cheese)
fit2 <- lm(taste ~ H2S + Lactic, data = cheese)

# Normal Q-Q plot
dg <- ls.diag(fit2)

# Q-Q plot of r_i 
qqnorm(dg$std.res, cex=1.5)
abline(a=0,b=1,col=2,lty=2, lwd=2)

# Q-Q plot of \hat{e}_i
qqnorm(fit2$residual, cex=1.5)
qqline(fit2$residual,col=2,lty=2, lwd=2)


# R^2 and adjusted R^2

fit1 <- lm(taste ~ Acetic + H2S + Lactic, data = cheese)
summary(fit1)

fit2 <- lm(taste ~ H2S + Lactic, data = cheese)
summary(fit2)

# Forward selection

# add the first variable
summary(lm(taste ~ Acetic, data = cheese))
summary(lm(taste ~ H2S, data = cheese))
summary(lm(taste ~ Lactic, data = cheese))
fit0 <- lm(taste ~ 1, data = cheese)
add1(fit0, data = cheese, scope = ~ Acetic + H2S + Lactic, test = "F")

# add the second variable
fit1 <- lm(taste ~ H2S, data = cheese)
add1(fit1, data = cheese, scope = ~ Acetic + H2S + Lactic, test = "F")

# add the third variable
fit2 <- lm(taste ~ H2S + Lactic, data = cheese)
add1(fit2, data = cheese, scope = ~ Acetic + H2S + Lactic, test = "F")


# R function to do forward selection automatically
step(lm(taste ~1, data = cheese), 
     scope=list(lower=~1,upper=~ H2S + Lactic + Acetic), 
     direction="forward")

# R function to do backward selection automatically
step(lm(taste ~ Acetic + H2S + Lactic, data = cheese), 
     direction="backward")

# R function to do stepwise selection automatically
step(lm(taste ~ 1, data = cheese), 
     scope=list(lower=~1,upper=~ H2S + Lactic + Acetic), 
     direction="both")




