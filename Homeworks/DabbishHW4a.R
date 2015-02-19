
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


#Variables from Problem 4 of HW3:
data(Boston)
Y_B = as.matrix(Boston$medv)
X_B = as.matrix(Boston[,c('crim','nox','rm','age','dis')])
X_B = cbind(rep(1,dim(Boston)[1]),X_B)
bhat_B <- ginv(t(X_B)%*%X_B) %*% t(X_B) %*% Y_B
Yhat_B <- X_B %*% bhat_B
err_B <- Y_B - Yhat_B
sigsqhat_B <- t(err_B) %*% err_B / (dim(X_B)[1] - qr(X_B)$rank)

#Find V^(-1/2)
Vh1 <-solve(V1^(1/2))

#Transform model to OLS
U <- Vh1 %*% Y
W <- Vh1 %*% X

Uhat <- W %*% ginv(t(W) %*% W) %*% t(W) %*% U

SSE <- t(U-Uhat) %*% (U-Uhat)

qr(W)$rank

lowerchi <- qchisq(.05, df=(length(U) - qr(W)$rank))
upperchi <- qchisq(.95, df=(length(U) - qr(W)$rank))

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

lowerchi <- qchisq(.05, df=(length(U) - qr(W)$rank))
upperchi <- qchisq(.95, df=(length(U) - qr(W)$rank))

Yhat <- X %*% ginv(t(X) %*% X) %*% t(X) %*% Y

SSE <- t(Y-Yhat) %*% (Y-Yhat)

lowerchi <- qchisq(.05, df=(length(Y) - qr(X)$rank))
upperchi <- qchisq(.95, df=(length(Y) -qr(X)$rank))

#Find the t distribution quantile
t_1b <- qt(.05, (length(Y) - qr(W)$rank - 1) )

a_1b = matrix(c(1,0,1,0,0))
s_1b <- sqrt(SSE/(length(Y) - qr(W)$rank - 1))
Bhat_1b <- ginv(t(W) %*% W) %*% t(W) %*% U
quad_1b <- sqrt(t(a_1b) %*% ginv(t(W)%*%W) %*% a_1b)
upper1b <- t(a_1b) %*% Bhat_1b - t_1b * s_1b * quad_1b
lower1b <- t(a_1b) %*% Bhat_1b + t_1b * s_1b * quad_1b

a_1c = matrix(c(0,1,-1,0,0))

quad_1c <- sqrt(t(a_1c) %*% ginv(t(W)%*%W) %*% a_1c)
upper1c <- t(a_1c) %*% Bhat_1b - t_1b * s_1b * quad_1c
lower1c <- t(a_1c) %*% Bhat_1b + t_1b * s_1b * quad_1c

SSH <- t(t(a_1c) %*% Bhat_1b) %*% ginv(t(a_1c)%*%ginv(t(W)%*%W)%*%a_1c)%*%t(a_1c)%*%Bhat_1b

p_1d <- pf(SSH/SSE, 1, 1, lower.tail=FALSE)

#Find SSR in the full model.
SSR_Bf <- t(bhat_B) %*% t(X_B) %*% Y_B - (length(Y_B)*(mean(Y_B))^2)

#create reduced model design matric and X1_B and estimator bhat1_B
X1_B <- X_B[,-c(3,5)]
bhat1_B <- ginv(t(X1_B)%*%X1_B) %*% t(X1_B) %*% Y_B
SSR_Br <- t(bhat1_B) %*% t(X1_B) %*% Y_B - (length(Y_B)*(mean(Y_B))^2)

SSE_B <- t(Y_B)%*%Y_B - t(bhat_B)%*%t(X_B)%*%Y_B

F_2f <- ((SSR_Bf - SSR_Br)/2)/(SSE_B/(length(Y_B) - qr(X_B)$rank))

pf_2f <- pf(F_2f, 2, (length(Y_B)-(qr(X_B)$rank)), lower.tail=F)
pf_2f
