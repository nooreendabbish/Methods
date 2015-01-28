
# --------------------------------------------------------------------------
# Homework 1
# Assigned Thu, 08/30/2012
# Due Thu, 09/06/2012, 5 PM
# --------------------------------------------------------------------------

# YOUR NAME: ....

# Read R_intro.R and answer the following questions

# RULES:
#
# 1) You can discuss the homework with each other in general terms,                       
#    but you must write your own solutions and not copy from anyone.     
#    You must not consult previous years' solutions that might be similar.
#    You are under honor code wrt these two stipulations!
#
# 2) Your R code is not permitted to use loops or the 'apply' function.
#
# 3) Work your way through the R intro at least to 'ARRAYS'.
#
# 4) Edit your answers into this file following each "ANSWER:".
#
# 5) Send your solutions to
#                        jichun@temple.edu
#    The solutions file must have extension '.R', NOT '.doc'.
#    Put '[STAT8003:HW1]' in the subject line of your email.
#
#
# 6) Essential criteria for grading of code, in this order of importance:
#    - Generalizability of the solution: Generalizability refers to how
#      difficult it would be to modify the code to work for larger or
#      slightly different problems.
#    - Full use of R's expressive power, or "Thinking in the Language":
#      If among two solutions one looks more like C or Perl code than R code,
#      it will be the less preferable one.
#    - Conciseness: Among two solutions, usually the shorter is preferable.



# PROBLEM 0:
# Set yourself up with R on your computer.
# Follow the instructions in  R_intro2.R from blackboard.



# PROBLEM 1:
# What happens in this expression?
    1:10 - 0:1
# ANSWER:
# 1 1 3 3 5 5 7 7 9 9
# Remark: Since the two vectors are not of the same length the
# smaller one will be cyclically repeated, so from 1 2 3..10 wou will be
# substracting 0 or 1 cyclically.

# PROBLEM 2:
# Create a vector consisting of the numbers 1 to N, where 1 appears
# once, 2 appears twice, 3 appears 3 times,...
# Show results for N=5
# ANSWER:
N <- 5
rep(1:N,1:N)


# PROBLEM 3:
# Evaluate the expressions:  
    -3:5;  (-3):5;  -(3:5)
# What does this tell you about operator precedence of '-' and ':'?
# The negative sign ("-") has a priority.

# By comparison, evaluate this:
    1-3:5; 1-(-3):5;  1-(3:5)
# Comment?  If you had been the creator of R, would you have designed
# operator precedence this way?  ANSWER: Here, the ":" sign has a
# priority compared with a minus ("-") sign The same operator "-" has
# different priorities in R, depending on the context. 



# PROBLEM 4 (5'):
# Create a vector of integers between 1 and N
# that are neither divisible by 3 nor by 5.
# Show results for N=100
# ANSWER:
N <- 100
x <- 1:N
x1 <- x[(x%%3!=0)&(x%%5!=0)]
x1


# PROBLEM 5 (10'):
# Create a vector of length N that contains one plus
# the cumulative sums of reciprocals of cumulative products
# of the integers 1,2,...,N.  Show results for N=10.
# What does the vector converge to?
# (Find functions for cumulative products and sums.)
# ANSWER:
N <- 10
x <- 1 + cumsum(1/cumprod(1:N))
x
# Taylor expansion of e^x at x_0=0
# The limit is e
# since 1 + 1/1 + 1/(1*2) + 1/(1*2*3) + ... = e



# PROBLEM 6 (10'):
# Create a vector of the vowels and a vector of the consonants
# from the standard dataset 'letters' or 'LETTERS'.
# Then create code that generates a random 3-letter word
# built form a random vowel, a random consonant, and
# another a random vowel.
# ANSWER:
vow <- c("a","e","i","o","u")
vow.idx <- match(vowels,letters)
con <- letters[-vow.idx]
con

w1 <- sample(vow,1)
w2 <- sample(con,1)
w3 <- sample(vow,1)
word <- paste(w1,w2,w3,sep="")
word

# PROBLEM 7 (5'):
# Create a vector containing all possible pairs
# of consonants and vowels (in this order).
# ANSWER:
# Remark: we would like to create a vector like
# "ab","ac", ..., "az", "eb", ..., "ez", ..., "ub", ...,"uz"
# We can therefore find the pattern of repitition

letterseq <- c(outer(vow,con,FUN="paste",sep=""))
letterseq
 
# PROBLEM 8 (5'):
# Create the following matrix elegantly:
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
 [1,]    0    1    0    1    0    1    0    1    0     1
 [2,]    1    0    1    0    1    0    1    0    1     0
 [3,]    0    1    0    1    0    1    0    1    0     1
 [4,]    1    0    1    0    1    0    1    0    1     0
 [5,]    0    1    0    1    0    1    0    1    0     1
 [6,]    1    0    1    0    1    0    1    0    1     0
 [7,]    0    1    0    1    0    1    0    1    0     1
 [8,]    1    0    1    0    1    0    1    0    1     0
 [9,]    0    1    0    1    0    1    0    1    0     1
[10,]    1    0    1    0    1    0    1    0    1     0
# ANSWER:
N <- 10
col1 <- rep(0:1,N/2)    # create the first column
col2 <- rep(1:0,N/2)    # create the second column
col12 <- c(col1,col2)   # make a long sequence of first two columns
colall <- rep(col12,N/2)
mat <- matrix(colall,nrow=N,ncol=N)
mat

# or

N = 10
x = sign(rep(c(-1,1),5))
mat = (outer(x,-x)+1)/2
mat    

# PROBLEM 9 (10'):
# Create a 6x3 matrix named 'dat' with
# row names "Adam", "Anna", "Bill", "Berta", "Chris", "Cindy".
# and column names "Age", "Gender", "Height".
# Fill the columns with realistically looking random numbers
# so someone could actually believe they are real data.
# Use numeric codes 0 and 1 for gender.
# Assume the ages to be uniformly distributed between 18 and 24.
# Assume men's mean height is 68in and women's 4in less, 
# but both heights have the same sdev.
# Finally assume normal distributions for heights,
# except the numbers should be whole inches to look realistic.
# ANSWER:
set.seed(927382)
age <- round(runif(6,min=18,max=24))
gender <- sample(rep(0:1,3),6)
height <- vector("numeric",6)    # 1 is for male and 0 is for female
height[gender==1] <- round(rnorm(3,mean=68,sd=2))
height[gender==0] <- round(rnorm(3,mean=64,sd=2))
dat <- cbind(age,gender,height)
dat
row.names(dat) <- c("Adam","Anna","Berta","Bill","Chris","Cindy")
dimnames(dat)[[2]] <- c("Age","Gender","Height")
dat


# PROBLEM 10 (10'):
# Create an artificial data matrix with 100000 rows and
# columns "Gender", "Age", "Graduated".
# Assume P(female)=0.57 (code 1) and P(male)=0.43 (code 0).
# Assume Age is uniformly distributed over 18:30.
# Assume Graduated is a binary variable with codes 0/1 (not/yes).
# Assume further the probabilities of having graduated are
# a function of Age as follows:  0,.01,.1,.2,.7,.95,.99,.99,...
# for ages 18 and up.
# (Hint: To fill 'Graduated', create first a column 'prob' that for
# each individual contains the probability of having graduated
# dependent on 'Age'.  This is the tricky part.
# Then set 'Graduated' to  runif(100000)<prob.)
# Finally, using the function 'table()', form frequency tables of
# - Graduated,
# - Gender x Age,
# - Gender x Age x Graduated,  and
# - Age, but only for the Graduates.
# Check whether the output of the 'table' function is of type 'array'.
# ANSWER:
set.seed(3293)
N <- 100
Gender <- as.numeric(runif(N) >= 0.57)
Age <- ceiling(runif(N, min=17,max=30))
# Age <- sample(18:30,N,replace=TRUE)
Graduated <- vector("numeric",N)
prob <- 0.01*(Age==18) + 0.1*(Age==19) + 0.2*(Age==20) +
        0.7*(Age==21) + 0.95*(Age==22) + 0.99*(Age>=23)
Graduated <- runif(N) < prob
dat <- cbind("Gender","Age","Graduated")
table(Graduated)
table(Gender, Age)
table(Gender, Age, Graduated)
table(Age[Graduated])


# PROBLEM 11:
# What happens in the following expressions?
mat <- matrix(1:12,ncol=3);  vec <- 1:3
colSums(t(mat)*vec)
# What is another way of doing the same?
# ANSWER:
# matrix multiplication
mat%*%vec



# PROBLEM 12:
# Execute the following more simply without multiplications:
mat <- matrix(1:12,ncol=3);  vec <- rep(1,3)
mat %*% vec
# ANSWER:
rowSums(mat)


# PROBLEM 13:
# Describe in your own words what the parameters
#   pch, xlim, ylim, type, lwd, lty  for 'plot()' and
#   mfrow, mfcol, mgp, mar, oma      for 'par()' 
# mean and how they are useful.  
# Do not quote documentation verbatim.
# ANSWER:
  ...


# PROBLEM 14:
# Criticize the following plotting code.
    dev.new()
    par(mfrow=c(2,1))
    x <- rnorm(100)
    y <- rnorm(100)
    plot(x, y)
    x <- rnorm(100)
    y <- rnorm(100)
    plot(x, y)
# ANSWER:
# 1. No seed is set before taking random number.
# 2. Two plots are not very comparable (different ylim or xlim).


# Problem 15 (10'):
# What does the following simulation do?  What is its point?
# Argue in terms of E[X], E[Y], SD[X], SD[Y], C[X,Y].
# What is the probability that the plot shows all the data?
# (Don't show the plot.)
    dev.new()
    co <- cos(pi/4)
    N <- 500
    x <- rnorm(N)
    y <- co*x + sqrt(1-co^2)*rnorm(N)
    lims <- c(-4,4)
    plot(x, y, pch=16, xlim=lims, ylim=lims)
# ANSWER:
# To plot scatter plot for iid samples of (X,Y)
# (X,Y) has a joint normal distribution N(mu, Sigma),
# with mu = (0 0)^T and Sigma = Exchangeable(sqrt(2)/2)
library("mvtnorm")
sigma <- matrix(c(1,sqrt(2)/2,sqrt(2)/2,1),2,2)
pmvnorm(mean=rep(0,2),sigma,lower = rep(-4,2),upper=rep(4,2))



