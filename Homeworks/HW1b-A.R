
library(xtable)
lvector <- function(x, dig = 2, dsply=rep("f",ncol(x)+1)) {
 x <- xtable(x, align=rep("",ncol(x)+1),display=dsply,digits=dig) # We repeat empty string 6 times
 print(x, floating=FALSE, tabular.environment="pmatrix", 
   hline.after=NULL, include.rownames=FALSE, include.colnames=FALSE)
 }

lvector(as.matrix(lapply(1:5, function(x) paste("y_", x, sep="")), dsply=c("s","s")))
x <- as.matrix(lapply(1:5, function(x) paste("x_", x, sep="")))
x2 <- as.matrix(lapply(1:5, function(x) paste("x2_",x,sep="")))
X <- cbind(rep(1,5), x, x2)
lvector(X, dig=0)
lvector(as.matrix(lapply(1:5, function(x) paste("epsilon_", x, sep="")), dsply=c("s","s")))

V <- matrix(c(3, -1, 1, -1, 5, -1, 1, -1, 3), 3,3, byrow=TRUE)
lvector(as.matrix(eigen(V)$values), dig=0)
for (i in 1:3){
lvector(as.matrix(eigen(V)$vectors[,i]))
}

V_inv = solve(V)
C = as.matrix(eigen(V_inv)$vectors)
D_sqrt = diag(lapply(eigen(V_inv)$values, sqrt))
W = C%*%D_sqrt%*%t(C)
lvector(W, dig=4)

Prod = W%*%W
lvector(Prod)
lvector(solve(V))

A <- matrix(c(4, 4.001, 4.001, 4.002),2,2,byrow=T)
B <- matrix(c(4, 4.001, 4.001, 4.002001),2,2,byrow=T)

library(MASS)
project <- function (X) {X%*%(ginv(t(X)%*%X))%*%t(X)}

lvector(project(V))

lvector(project(V)%*%project(V))

lvector(t(project(V)))

lvector(project(3))

lvector(project(matrix(c(0,0,0,0),2,2)))

X <- matrix(c(rep(1,8), rep(1,4), rep(0,8), rep(1,4), 
              rep(c(1,1,0,0),2), rep(c(0,0,1,1),2),
              rep(c(1,1,rep(0,8)),3), 1,1),nrow=8,ncol=9, byrow=FALSE)
ct3 <- matrix(c(1,1,0,1,0,1,0,0,0),nrow=1)
ct5 <- matrix(c(0,0,0,0,0,-1,1,1,-1), nrow=1)
lvector(ct3%*%ginv(t(X)%*%X)%*%t(X))
lvector(ct5%*%ginv(t(X)%*%X)%*%t(X))
