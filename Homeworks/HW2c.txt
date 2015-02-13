
library(xtable)
  lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
   x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
   print(x, floating=FALSE, tabular.environment="pmatrix", 
     hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
   }

V <- diag(c(1,9,9,1,1,9))
Vhi <- solve(V^(1/2))
lvector(Vhi)

Y <- matrix(c(2, 1, 4, 6, 3, 5), nrow=6, ncol=1)
U <- Vhi %*% Y
lvector(U)

X <- matrix(c(rep(1,6),
              1,1,0,0,0,0,
              0,0,1,0,0,0,
              0,0,0,1,0,0,
              0,0,0,0,1,1),nrow = 6,byrow=FALSE)
W <- Vhi %*% X
lvector(W)

Uhat <- W %*% ginv(t(W) %*% W) %*% t(W) %*% U
lvector(Uhat)

Yhat <- (V^{1/2})%*%Uhat
lvector(Yhat)

CT <- matrix(c(1,1,0,0,0,1,0,1,0,0,1,0,0,1,0,1,0,0,0,1), nrow=4,ncol=5, byrow=T)
CTBetahat <- CT %*% ginv(t(W)%*%W) %*% t(W) %*% U
lvector(CTBetahat)

V <- diag(c(1,9,9,1,1,9))
V[1,2] <- 1
V[2,1] <- 1
V[4,3] <- -1
V[3,4] <- -1
V[6,5] <- -1
V[5,6] <- -1

Dh <- diag(sqrt(eigen(V)$values))
C <- eigen(V)$vectors 
Vh <- C %*% Dh %*% t(C)
Vhi <- solve(Vh)

Y <- matrix(c(2, 1, 4, 6, 3, 5), nrow=6, ncol=1)
Yp <- Vhi %*% Y

X <- matrix(c(rep(1,6),
              1,1,0,0,0,0,
              0,0,1,0,0,0,
              0,0,0,1,0,0,
              0,0,0,0,1,1),nrow = 6,byrow=FALSE)
Xp <- Vhi %*% X

library(MASS)
Yphat <- Xp %*% ginv(t(Xp) %*% Xp) %*% t(Xp) %*% Yp
Yhat <- (Vh)%*%Yphat
lvector(Yhat)

CT <- matrix(c(1,1,0,0,0,1,0,1,0,0,1,0,0,1,0,1,0,0,0,1), nrow=4,ncol=5, byrow=T)
CTBetahat <- CT %*% ginv(t(Xp)%*%Xp) %*% t(Xp) %*% Yp
lvector(CTBetahat)

V <- diag(c(1,9,9,1,1,9))
Y <- matrix(c(2, 1, 4, 6, 3, 5), nrow=6, ncol=1)
X <- matrix(c(rep(1,6),
              1,1,0,0,0,0,
              0,0,1,0,0,0,
              0,0,0,1,0,0,
              0,0,0,0,1,1),nrow = 6,byrow=FALSE)
lmod <- lm(Y ~ 0 + X[,2:5], weights=diag(solve(V)))
xtable(summary(lmod))

pdf(file="HW2_4a.pdf")
myscatter <- data.frame(cbind(Y,X[,c(2:6)]))
plot(myscatter)
dev.off()

qr(X)$rank

betahat <- ginv(t(X)%*%X) %*% t(X) %*% Y
lvector(betahat)

Yhat <- X %*% betahat
err <- Y- Yhat
lvector(Yhat)
lvector(err)

sigsqhat <- t(err) %*% err / (dim(X)[1] - qr(X)$rank)
sigsqhat

ml = lm(medv~crim+nox+rm+age+dis, data=Boston)
summary(ml)
xtable(summary(ml))

head(ml$residuals - err)

head(ml$fit - Yhat)
