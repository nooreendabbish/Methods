
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
