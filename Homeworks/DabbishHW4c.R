
library(MASS); library(xtable)
     lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
      x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
      print(x, floating=FALSE, tabular.environment="pmatrix", 
        hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
      }
   
   #Variables from Problem 2 of HW3:
     Y1 <- matrix(c(2, 1, 4, 6, 3, 5), nrow=6, ncol=1)
     X1 <- matrix(c(rep(1,6),
                   1,1,0,0,0,0,
                   0,0,1,0,0,0,
                   0,0,0,1,0,0,
                   0,0,0,0,1,1),nrow = 6,byrow=FALSE)
   
   #Variables from Problem 4 of HW3:
   data(Boston)
   YB = as.matrix(Boston$medv)
   XB = as.matrix(Boston[,c('crim','nox','rm','age','dis')])
   XB = cbind(rep(1,dim(Boston)[1]),XB)
   bhatB <- ginv(t(XB)%*%XB) %*% t(XB) %*% YB
   YhatB <- XB %*% bhatB
   errB <- YB - YhatB
   sigsqhatB <- t(errB) %*% errB / (dim(XB)[1] - qr(XB)$rank)

   #Another dataset tested:
   X511 <- matrix(c(rep(1,9),rep(c(rep(0,7),1),3),1,1),7,5)
   Y511 <- c(2,1,4,6,3,5,4)

   #functions for calculating estimates:
   
   sigmacalc <- function(Y, X, alpha){
   Yh <- X %*% ginv(t(X) %*% X) %*% t(X) %*% Y
   SSE <- t(Y-Yh) %*% (Y-Yh)
   
   lowerchi <- qchisq(alpha/2, df=(length(Y) - qr(X)$rank))
   upperchi <- qchisq(1-alpha/2, df=(length(Y) - qr(X)$rank))
   
   return(c(sqrt(SSE/upperchi),sqrt(SSE/lowerchi)))
   }
   
         
   cbetacalc <- function(Y,X, alpha, ct){
   Yh <- X %*% ginv(t(X) %*% X) %*% t(X) %*% Y
   SSE <- t(Y-Yh) %*% (Y-Yh)
   MSE <- SSE/(length(Y) - qr(X)$rank)
   quad <- t(ct)%*%ginv(t(X)%*%X)%*%ct
   
   tstar <- qt(1-alpha/2, length(Y) - qr(X)$rank)
   pm <- tstar  * sqrt(quad) * sqrt (MSE)
   
   ctbhat <- t(ct)%*%ginv(t(X)%*%X)%*%t(X)%*%Y
   
   return(c(ctbhat-pm,ctbhat+pm))
   }
   
   #F-test function:
  
   Cbetahatd <- function (Y,X, ct, d = 0){
   
   CGCinv <- ginv(t(ct)%*%ginv(t(X)%*%(X))%*%ct)
   CBhat <- t(ct)%*%ginv(t(X)%*%X)%*%t(X)%*%Y
   Q <- t(CBhat - d)%*%CGCinv%*%(CBhat-d)
   MSH <- Q/qr(ct)$rank
  
   Yhat <- X %*% ginv(t(X)%*%X)%*%t(X)%*%Y
   SSE <- t(Y-Yhat)%*%(Y-Yhat)
   MSE <- SSE/(length(Y) - qr(X)$rank)
  
   F <- MSH/MSE
  
   return(1-pf(F, qr(ct)$rank, length(Y)-qr(X)$rank))
   
   }
  
   # Prediction limits

   predict <- function (Y, X, alpha, ct, n=1){
   Yh <- X %*% ginv(t(X) %*% X) %*% t(X) %*% Y
   SSE <- t(Y-Yh) %*% (Y-Yh)
   MSE <- SSE/(length(Y) - qr(X)$rank)
   quad <- t(ct)%*%ginv(t(X)%*%X)%*%ct
   gamma <- 1/n
   tstar <- qt(1-alpha/2, length(Y) - qr(X)$rank)
   pm <- tstar  * sqrt(gamma+quad) * sqrt (MSE)
   
   ctbhat <- t(ct)%*%ginv(t(X)%*%X)%*%t(X)%*%Y

   return(c(ctbhat-pm,ctbhat+pm))
}

  #1e
  predict(Y1, X1, .1, c(1,0,1,0,0), 10)

  #1f
  predict(Y1, X1, .1, (c(1,1,0,0,0) - c(1,0,1,0,0)), 2)

  #1g
  G <- t(matrix(c(0,1,-1,0,0,
                    0,1,0,-1,0,
                    0,1,0,0,-1),nrow=3,ncol=5, byrow=TRUE))
  Cbetahatd(Y1,X1,G,c(0,0,0))

  #1h
  H <- t(matrix(c(0, 1, -1, 0, 0, 0, 0, 1, -1, 0), nrow=2, ncol=5, byrow=T))

  Cbetahatd(Y1,X1,H,c(10,0))

  #2a
  sigmacalc(YB,XB, .1)

  #2b
  cbetacalc(YB,XB, .1, XB[1,])

  #2c
  cbetacalc(YB,XB, .1, (XB[1,]-XB[2,]))

  #2d
  Cbetahatd(YB,XB, (XB[1,]-XB[2,]))

  #2e
  predict(YB,XB, .1, c(0,0.005,0.45,7,45,6), 1)

  #2f
  Cbetahatd(YB,XB, c(0,0,1,0,1,0))

  #3

#Find SSR in the full model.
bhat_B <- ginv(t(XB)%*%XB)%*%t(XB)%*%YB
SSR_Bf <- t(bhat_B) %*% t(XB) %*% YB - (length(YB)*(mean(YB))^2)
 
#create reduced model design matric and X1_B and estimator bhat1_B
X1_B <- XB[,-c(3,5)]
bhat1_B <- ginv(t(X1_B)%*%X1_B) %*% t(X1_B) %*% YB
SSR_Br <- t(bhat1_B) %*% t(X1_B) %*% YB - (length(YB)*(mean(YB))^2)
 
YhatB <- XB%*%bhat_B
SSE_B <- t(YB -YhatB)%*%(YB-YhatB)
 
F_2f <- ((SSR_Bf - SSR_Br)/2)/(SSE_B/(length(YB) - qr(XB)$rank))
 
pf_2f <- pf(F_2f, 2, (length(YB)-(qr(XB)$rank)), lower.tail=FALSE)

fractions(ginv(t(C1g)%*%ginv(t(X1)%*%X1)%*%C1g))
