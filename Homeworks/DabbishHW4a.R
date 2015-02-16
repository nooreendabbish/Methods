
library(MASS); library(xtable)
  lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
   x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
   print(x, floating=FALSE, tabular.environment="pmatrix", 
     hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
   }

#Variables from Problem 2 of HW3:
  V1 <- diag(c(1,9,9,1,1,9))
  Y <- matrix(c(2, 1, 4, 6, 3, 5), nrow=6, ncol=1)
  X <- matrix(c(rep(1,6),
                1,1,0,0,0,0,
                0,0,1,0,0,0,
                0,0,0,1,0,0,
                0,0,0,0,1,1),nrow = 6,byrow=FALSE)

  V2 <- diag(c(1,9,9,1,1,9))
  V2[1,2] <- 1
  V2[2,1] <- 1
  V2[4,3] <- -1
  V2[3,4] <- -1
  V2[6,5] <- -1
  V2[5,6] <- -1

#Find V^(-1/2)
Vh1 <-solve(V1^(1/2))

#Transform model to OLS
U <- Vh1 %*% Y
W <- Vh1 %*% X

Uhat <- W %*% ginv(t(W) %*% W) %*% t(W) %*% U

SSE <- t(U-Uhat) %*% (U-Uhat)

qr(W)$rank

lowerchi <- qchisq(.05, df=4)
upperchi <- qchisq(.95, df=4)

SSE/lowerchi
SSE/upperchi

#Find V^(-1/2) using spectral decompostion
Vh2 <-solve(eigen(V2)$vectors %*% diag(sqrt(eigen(V2)$values)) %*% t(eigen(V2)$vectors))

#Transform model to OLS
U <- Vh2 %*% Y
W <- Vh2 %*% X

Uhat <- W %*% ginv(t(W) %*% W) %*% t(W) %*% U

SSE <- t(U-Uhat) %*% (U-Uhat)

qr(W)$rank

lowerchi <- qchisq(.05, df=4)
upperchi <- qchisq(.95, df=4)
