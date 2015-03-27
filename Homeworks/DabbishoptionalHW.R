
library(MASS); library(xtable)
     lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
      x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
      print(x, floating=FALSE, tabular.environment="pmatrix", 
        hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
      }
  
X1 <- matrix(c(2,-1,1,-1,2,0,1,0,0,1,0,0,2,1,1,0), nrow=4, ncol=4, byrow=TRUE)
lvector(X1)

ct <- c(0,0,0,1)
ct %*% ginv(t(X1)%*%X1)%*%t(X1)
qr(ginv(t(X1)%*%X1))$rank
qr((t(X1)%*%X1)[2:4,2:4])$rank
A22inv <- solve((t(X1)%*%X1)[2:4,2:4])
G <- rbind(c(0,0,0,0), (cbind(c(0,0,0), A22inv)))
t(X1)%*%X1
G%*%t(X1)
c(0,0,0,1)%*%G%*%t(X1)

C2 <- matrix(c(1,1,-1,-1,1,-1,-1,1),nrow=2,ncol=4,byrow=TRUE)
d <- c(35,35)
betahat <- c(36.25,-8.75,2.5,-7.5)
C2%*%betahat


XtXinv <- matrix((1/32)*c(5,-1,1,-1,-1,5,-1,1,1,-1,5,-1,-1,1,-1,5),nrow=4,ncol=4,byrow=TRUE)
C2%*%XtXinv%*%t(C2)
solve(C2%*%XtXinv%*%t(C2))
((t(C2%*%betahat - d)%*%solve(C2%*%XtXinv%*%t(C2))%*%(C2%*%betahat - d))/2)/(75/3)

X2 <- matrix(c(rep(c(1,1,1,1),2),rep(c(1,1,-1,-1),2),1,-1,1,-1,rep(c(1,-1,-1,1),2)),nrow=7,ncol=4,byrow=TRUE)
Ch <- c(1,1,-1,-1)
Ch%*%ginv(t(X2)%*%X2)%*%t(X2)

X2 <- X2[-5,]
