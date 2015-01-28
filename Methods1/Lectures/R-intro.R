

################################################################
#
#
#                      INTRO TO R
#
# The R website:
#
#   http://cran.r-project.org
#
#   (Google "R" -> one of the first entries)
#
# Downloading R:
#
#   ->  Sidebar "Download, Packages": CRAN 
#   ->  any site in the US
#   ->  Windows
#   ->  base
#   ->  "Download R-2.... for Windows (32 bit build)"
#   ->  installation dialog in setup wizzard
#
#   The setup program should self-install and create an icon on your desktop.
#   Clicking the icon should open up an R interpreter window ("R Gui").
#
#   The base is really just the base.  There are many contributed
#   library packages whose binaries can be downloaded from
#
#   ->  Packages
#
#   You will not have to download them explicitly, though;
#   there are R functions that allow you to get them while running R.
#   In the R Gui you can also go through the "Packages" item in the toolbar.
#    
################
#
# OPERATION OF R:
#
# * For non-Emacs users:
#
# 0) go to the class web page and download this file.
#    Open an editor (Word, Wordpad,...) on this file (change .R to .txt)
#       AND open up an R GUI window by clicking on the R icon.
#    Reduce the size of both windows so both are accessible.
#
# 1) Copy R code from this file into the R interpreter window.
#    Use shortcuts: In the editor highlight lines, hit <Ctrl>-C,
#                   then move to the R window and hit <Ctrl>-V.
#    Examples:
       1+2
       1:10
       2^(1:20)
       runif(10)
       rnorm(10)
       1:10 + rnorm(10)
#
# 2) Experiment with R code
#      by editing THIS file in the editor window, or
#      by editing the command line in the R window (if it's one-liners).
#    
# Commands for line editing in the R interpreter window:
#  Note: "^p" means you hold down the modifier key <Ctrl> and hit "p",
#        just like the modifier key <Shift> used for capitalization
#  ^p get back the previous command line for editing and executing
#     repeating ^p goes further back in the command history
#  ^b step back one character in the command line
#  ^f step forward one character in the command line
#  ^a move to the beginning of the line
#  ^e move to the end of the line
#  ^d or <Delete> to delete the character under the cursor 
#  ^h or <Backspace> to delete the previous character 
#  ^k kill the rest of the line starting from the cursor
#  otherwise: you are in insert mode
#  (These editing commands are borrowed from the Emacs editor.)
#    
# 
# * For Emacs users: 
#
#  download the ESS macros ("Emacs Speaks Statistics") from r-project.org:
#  ->  R GUIs  ->  Emacs (ESS)  ->  Downloads
#  Download the latest zip or tar.gz file.
#  Unpack and install; ESS should work right away.  Skip to "Operation:" and try.
#  If it doesn't work right away,
#  you may have to put these lines in your .emacs file:
## (setq inferior-R-program-name "c:/Program Files/R/R-2.7.1pat/bin/Rterm.exe")
#                                 ^^^^ path to your R executable ^^^^
## (load-file "c:/EMACS/ESS/ess-5.3.0/lisp/ess-site.el")
#                ^^^path to the file "ess-site.el"^^^
#
#  Operation:
#  - Split the Emacs window into two windows:
#      ^x 2
#  - Edit THIS file in the upper window.
#      ^x ^f filepath <Enter>
#  - Start R in the lower window:
#      ^x o           (move the cursor to the lower window)
#      <Alt>-x R      (start R inside Emacs)
#  - If you like to shrink one of the windows, put this line in your .emacs:
#      (global-set-key "\M-o" (lambda () (interactive) (shrink-window 1)))
#    Then <Alt>-o will shrink the present window and expand
#    the other window by one line.
#  - There are macros to copy and execute lines, functions, and regions
#    from the upper buffer into the lower buffer:
#      ^c ^j          (execute current line and leave the cursor in place)
#      ^c ^n          (execute current line and move to next line of R code)
#      ^c ^f          (execute function, assuming the cursor is
#                      inside its body)
#      ^c ^r          (execute region)
#  - A small nuisance is that the lower (R) window does not move
#    the bottom line to the center after executing an expression.
#    This can be fixed by putting the following in your .emacs:
#      (global-set-key "\M-s" "\C-xo\M->\C-l\C-xo") 
#    Then <Alt>-s will move the bottom line to the center.
#
#
##################
#
#
# * R is an INTERPRETED LANGUAGE:
#     Users type expressions and see results immediately.
#     Example:
        for(i in 1:10) { if(i%%2==0) print(i) }
#     As opposed to:
#     - ... languages (C, Fortran)
#     - ... software (such as SAS' JMP)
#    
#
# * R is HIGH-LEVEL:
#     It operates on complex data structures such as 
#     vectors, matrices, arrays, lists, dataframes,
#     as opposed to C and Fortran that operate on individual numbers only.
#     (This requires some getting used to for C programmers.)
#    
#
# * PRIMARY BEHAVIOR: Whatever is typed, print the results.
      2
      print(2)   # same
      "a"
      print("a") # same
#   (Q: Why is there '[1]' preceding the results?  A: ...)
#   Vector of length greater than 1:
      1:3
      print(1:3) # same
#
#
# * SYNTAX:
#   - Largely scientific/math notation; base 10.
#   - A wealth of functions.
#   - Comments run from a "#" to the end of the line; no multiline comments.
#   - Spaces are irrelevant, except inside strings:
        2+3; 2  +    3; "ab"; "a   b"
#   - Statements can run over multiple lines:
        2 + 3 +     # \
        4           # / One statement
#     But if a statement is syntactically complete at
#     the end of the line, it won't continue:
        2 + 3       # \
        + 4         # / Two statements
#   - Statements can be separated by ";".
        2; 3^3; sqrt(9)
#    
#---
#
# * BASIC DATA TYPES:
#
#
#   - NUMERIC: double precision by default (How many bytes?)
#     Integers are represented as doubles, although the print function
#     shows them as integer:
        -2.000
        1E5
        2E-3
#     The usual unary and binary operations and analytic functions:
#       +, -, *, /, %%, %/%, ^, log, sqrt, sin, acos...
        2+3            # Add.
        5.3*1E10       # Multiply.
        10%%3          # Modulo.
        exp(1)         # Exponentiation.
        log(2.718282)  # Log of the number 'e'; 'log' is e-based.
        log10(10)      # 10-based log
        pi             # That's the number 'greek pi', 3.14159
        sin(pi/2)      # Angles are to be given in arcs, not degrees.
        sin(pi)        # Dito.
        acos(0)        # This is the inverse of cos, arccos, hence pi/2.
        pi/2           # This is the only hardwired constant: 3.14159...
#
#
#   - STRINGS: can be single or double quoted, but the print function
#     uses double quotes.
        'a'; "a"; 'abc'; "abc"
#     (In C and Python strings are character vectors.
#      In R strings are basic types; there is no single character type.
#      Characters are just strings of length 1.
#      There is no indexed access to individual characters and
#      substrings in R; one uses the "substring" function instead:
        substring("abcxyz",4,6)
#     Other basic string manipulations:
        paste("my","word")
        nchar("Supercalifragilistikexpialidocious")
#     There are two hardwired character vectors that contain the lower and
#     upper case letters:
        letters
        LETTERS
#
#
#   - LOGICAL values: have two names each, but the print function
#     always uses the longer.
        TRUE; FALSE; T; F
#     They are implemented as the values 1 and 0 for T and F, respectively.
#     They are the result of the usual comparisons: <, >, <=, >=, ==, !=
        1<2; 1>2; "ab" <= "abcd"
        "ab" > "ac"; "ab" != "AB"
        "ab" != 2; 0==F; 1==T
#
#
#   - MISSING values NA, Inf, -Inf:
        NA; NaN; Inf; -Inf; 1/0; Inf==1/0; 0/0
#     Watch out: the following does not give T!!!
        NA==1
#     If you want to test for NA, you must use the function is.na():
        is.na(NA)
#
#
#   - FUNCTIONS: 

# * R is a FUNCTIONAL LANGUAGE:
#   Functions return values that in turn can be arguments to functions.
#   Expressions evaluate inside out, e.g., log(2*2.5))^3:
        2.5; 2*2.5; log(2*2.5); log(2*2.5)^3
#
#
# * STATEMENTS/EXPRESSIONS:
#     There are two types of expressions: assignments and side effects.
#     1) Assignments allocate data structures and
#        make variables point to them.  
           x <- 1:3   # Allocate a vector 1,2,3 and make 'x' point to it.
#     2) Side effects are essentially display operations 
#        such as printing, plotting, showing help; unlike assignments,
#        they don't change the computational state of the R system.
           x
           print(x)
           plot(x)
           help("+")    # Show the help page of addition.
           help(sqrt)   # Show the help page of the square root function.
           help("sqrt") # Dito.
#     3) Composite Statements:
           {print(1); plot(1:10)}
#        Will be needed in loops and functions.
#
#
#   - Assignments to variables come in four equivalent syntactic forms:
#       x <- ...
#       x = ...
#       ... -> x
#       assign("x",...)
#     Examples:
        x <- sqrt(2 * 3)    # Root of product of 2 and 3
        x = sqrt(2 * 3)     # Both can be used: '=' and '<-'
        sqrt(2 * 3) -> x    # This can be used, too, if you must...
        y <- c(1,3,10,1,1,1111,0,1,1)  # combine 1,3,10... into a vector 'y'
        z <- 1:3           # Assign the vector containing 1,2,3 to a 'z'.
        assign("x", sqrt(2*4));  print(x)
#     Note that variables jump into existence upon assignment.
#     Unlike C and Fortran, there is no need to declare variables.
#     The variables are not 'typed', that is, any variable can
#     point to data of any type, such as numbers, logicals, vectors,...
#
#---
#
# * HELP: help(function) or help("function") shows function documentation.
        help(sqrt)
#         (Emacs users: call help.start() before using help.)
#     In the output of this function, check out the section
#     with header "See Also:".  It will tell you that you
#     can find related functions by calling
        help("Arithmetic")
        help("log")
        help("sin")
        help("Special")
#          
        help(c)
        help("c")   # Same as help(c)  
        help("*")   # help(*) does not work
#
# * APROPOS: apropos("char") lists all functions whose name contains
#     the string "char".
        apropos("char")
#     This is often useful for finding related functions.  
#     Apropos combined with the section "See Also:" in the output
#     of help() is a powerful tool for searching functions.
#     There are about 1,700 built-in functions, and more if you
#     download special-purpose packages from the R website.
#
# * Printing a function: allows you to see the arguments in a simple way
        runif   # same as: print(runif)
        rnorm   # (functions are "first class citizens", like numbers, vectors,...)
#
#---
#
# * MANAGEMENT OF DATA AND FUNCTIONS: 
#     - Listing R objects, both data and functions: either of
          ls();  objects()
#       This lists all data structures and functions that YOU defined.
#     - Removing data and functions:
          x <- 1:10
          rm(x)
          x
#     - Looking for partly remembered data and functions:
#       In case you remember only part of a name, you can look it up
#       with a partial pattern:
          xx <- 10
          ls(pattern="x")
#       This will list any dataset and function whose name contains "x"
#       such as 'last.warning'.
#     - List all functions that come with the base package of R:
          ls("package:base")   # Over 1,100 functions...
#     - About packages: 
#     . Packages are namespaces for data AND functions.
#       (You can't have a dataset 'x' and a function 'x' at the same time.)
#     . You can list the packages in your environment:
          search()
#     . When you use a name, R goes through the search list
#       shown by 'search()', package by package, stopping when
#       it finds the name.  This implies that the same name can appear
#       in multiple packages, but only the one in the first package
#       will be found.
          ls <- 2:5   # mask 'ls' in "package:base" with user data
          ls
          rm(ls)      # remove user data, unmasking the function 'ls()' 
          ls
#
#---
#
# * QUITTING:
        q()
#     R asks whether you want to save the workspace; 
#     usually you say "yes".  Splus simply quits.
#
#---
#
# * SEMANTICS:
#     Every assignment creates a copy of the assigned object.
#     Assignment is by value, not by reference (unlike Python and C).
        a <- c(1,3,5) # 
        a 
        b <- a        # 'b' gets its own copy.
        b             # We couldn't tell from this, though.
        a[1] <- 2     # Assign the value 2 to the first element of 'a'.
        # This yields a test of whether 'a' and 'b' point to the same object.
        # If they did, then 'b' would also have 2 in the first position.
        a             # We know this.
        b             # Uhu!  'b' was not changed by 'a[1] <- 2'.
        # Therefore, 'b' has its own copy.
#
#--- 2008/09/04 

# * SYNTAX: see
      help(Syntax)

#
# * VECTORS:
#     A vector is a sequence of items of the SAME basic data type.
        c(1,3,4.5)   # Collect three values in a vector.
        c("a","ab")  # Collect two strings in a vector.
        c(T,F,T)     # Collect three logical values in a vector.
        c(2.1,T)     # Not an error.  Coercion of T to 1.
        c(2,"a",T)   # Not an error.  Coercion of 1 and T to strings.
#     If the items are not of the same type, they are coerced:
#       string <-- numeric <-- logical
#     (If the items are of variable types and should not be coerced,
#      use lists instead of vectors.  See below.)
#
#---
#
# * INDEXING AND SUBSELECTING VECTORS:
#
#   R/S, among all languages, has probably the most powerful set of
#   tools for getting at elements of vectors:
#     * selection/mapping with positive integer indeces
#     * delection with negative integer indeces
#     * selection with logical indeces
#     * selection by name when vector entries are named ("associative array")

#   - Numeric indexes: ONE-based (unlike C, but like Fortran)
        a <- c(1,3,5)
        a[1]; a[2]; a[3]
#     (This is unlike Python and C which use ZERO-based indexing.)
#   - Vector indexes:
        a[c(1,3)]
#     or, equivalently, except for the allocation of another vector 'b':
        b <- c(1,3);  a[b]
#   - Vector expansion: amounts to mapping the indexes, using 'a' as a map.
        a[c(1,2,1,2,1,1,1,3,3,3)]
#   - Exclusions with negative numeric indexes:
        a[-1]
        d <- a[-1]
        a[c(-1,-3)]
        b <- c(-1,-3);  a[b]  # dito
        a[c(-1,-2,-3)]   # Nothing left.
        a <- a[-1]       # Actually remove the first element of 'a'.
#   - Logical selection: 
        a <- c(1,3,5)
        a[c(T,F,T)]
        b <- c(T,F,T);  a[b]  # dito
        a>2; a[a>2]      # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        b <- (a>2);  a[b]  # dito
#     Caution: If the index vector is not of equal length,
#     it will be cyclically repeated:
        a[F]             # c(F,F,F)   'F' is repeated 3 times
        a[T]             # c(T,T,T)
        a[c(T,F)]        # c(T,F,T)   
        a[c(T,T,F,F,F)]  # If too long, the index vector is truncated.
        (1:12)[c(T,T,F)] # Leave out every third item.
        # (The above scheme can be used to create arbitrary repeat patterns.)
#   - Vectors can be indexed repeatedly:
        a[c(1,3)][2]     # Select item two of a[c(1,3)], i.e. item 3 of 'a'.
#         (Looks like a matrix element in C, but isn't!!)
        (a[c(1,3)])[2]   # This is what the previous expression really means.  
#         Think of a[c(1,2)] as the result of some selection function.
        a[c(1,3)][c(1,2,1,2)]
#   - Vector indexing and subsetting can be used for assignment:
        a[1:2] <- c(10,20);  a    # Print 'a' to see the effect of the assignment.
        a[c(1,3)] <- c(100,200);  a
        a[-2] <- c(1000,2000);  a
        a[c(F,T,T)] <- c(10000,20000);  a
        a[2:3] <- 0;  a    # "0" is repeated to fill both vector elements.
        b <- 1:10
        b[3:6] <- c(10,20); b # "c(10,20)" is cyclically repeated.
#     If the length does not divide, there is a warning message,
#     but cyclical fill-in is done anyway.
#
#---
#
# * SOME FUNCTIONS THAT CREATE VECTORS
#
#   - Manual entry of a vector:
        x <- c(-1,2,5)
#    
#   - Equispaced sequences of numbers:
        3:10
        10:3
        seq(3, 10)
        seq(3, 10, by=1/3)   # Third argument is names "by"
        seq(3, 10, len=8)
        seq(letters)         # List of indexes into 'letters'
#
#   - Repetitions:
        rep(3, 10)
        rep(1:3, 5)
#     Here is something more complex that "rep" can also do:
        rep(c(1,2,3,4), c(2,3,2,4))
        rep(1:3, rep(2,3))
#    
#   - Logical values:
        rep(T,5)
        ((1:10) > 5)
        (1:10)[(1:10) > 5]
#    
#   - Random numbers:
        x <- runif(5);  x # Five uniform random numbers in [0,1]; see below.
        y <- rnorm(5);  y # Five standard normal random numbers; see below.
#
#   - Random permutations and samples:
        x <- sample(10);  x  # Random permutation of the numbers 1,2,...,10.
        sample               # can also do sampling with replacement...
        sample(letters, 10, replace=T)

#   - Read a vector from file: The file 'sp.dat' is a very long time series;
#       download it from the class website.
        x <- scan("sp.dat", n=1000)  # First n values
        x <- scan("sp.dat")     # Reads 734656 numbers; may take a few sec.
#     'x' contains 8 bytes for each element, hence this many MB:
        8*length(x)/2^20     # (2^20 equals one MegaByte)
        object.size(x)       # size in bytes; why is it not exactly 8*length(x)?
#     You may not want to keep this 'x' around because of its length:
        rm(x)
#     Btw, if you run out of memory, try this:
        options(memory=1E10, object.size=1E10)   
#    
#---
#
# * AUTOMATIC VECTOR EXTENSION:
#
#     Array-bound errors for vectors do NOT exist for positive indexes!!!   
#     Vectors are shown as NA if indexed out of bounds, and
#     automatically extended if assigned out of bounds.
        x <- runif(5)  # x has length 5.
        x[6]           # NA, not an error message.
        x[10] <- 9.99  # Not an error!  Element 10 now exists.
        x              # So do elements 6,7,8,9, filled in with NA.
        length(x)        # Assignment can extend the length.
#     However, negative indexes (used for exclusion) can be out of bounds:
        x[-11]           # Out of bounds.
        x[-9]            # Ok, due to fill-in after assigning element 10.
#     Automatic vector extension makes vectors very different from
#     matrices and arrays, for which automatic extension does not exist.
#
#---
#
# * NAMED VECTOR ELEMENTS:
#
#   - Vector elements can be named:
        x <- c(first=1,second=3,third=5,fourth=7);   x
#   - Equivalently, naming elements can be performed in a separate step
#     by assigning the "names()" attribute:
        x <- c(1,3,5,7)
        names(x) <- c("first","second","third","fourth") 
        x
        names(x)
#   - Element names can be used for indexing/subsetting:
        x["second"]
        x[c("second","fourth")]
        nm <- c("second","third","second","third");  x[nm]
#   - Named assignment/extension is possible:
        x[c("fifth","fourth")] <- c(10,11);  x
#     Note: "fourth" existed and is re-assigned;
#           "fifth" did not exist and is an extension of "x".
#   - If names are not unique, the first matching name is selected:
        c(a=1,b=2,a=3)["a"]
#   - Example of automatic use: 'table()'
        x <- sample(letters,size=1000,replace=T)
        table(x)
#
#  
#---
#
# * VECTORS WITH NAMED ELEMENTS AS ASSOCIATIVE ARRAYS:
#
#     R's vectors with named elements are really a limited form
#     of 'associative arrays'.  Associative arrays are best explained
#     in terms of an example:
#       Assume you want to look up, say, salaries of persons given by name.
#       Assume that salaries and names are stored in parallel vectors:
          slry <- c(35000, 100000, 12000)
          nm   <- c("John", "Bill", "Jim")
#       Turn "slry" into an associative array by giving its elements names:
          names(slry) <- nm
#       Salaries are now "associated" with names for lookup by name,
#       the names are the "keys", the salaries the "values".
#       For example, Bill's salary is: 
          slry["Bill"]          # "Bill" is the key, slry["Bill"] the value.
#
#       Another way to create the same: names arguments to c()
          slry <- c(John=35000, Bill=100000, Jim=12000)
          slry
#
#     NOTE: If one wants to use numbers as keys, they have to be
#     converted to strings first.  The conversion happens automatically
#     through coercion, as in
        names(slry) <- c(10,20,30);  slry
        names(slry) 
#     Thus the keys are now the strings "10", "20", "30":
        slry["20"]    
#     Caution: In lookups, numbers are NOT coerced to strings,
#              because numbers act as indexes into the vector
        x <- seq(10,40,by=10)
        names(x) <- c(2,1,4,3) # Coerced to strings: "2","1",...
        x[2]    # Second element of 'x'.
        x["2"]  # Same as x[1], which has the name "2".
#       
#
#---
#
# * RANKING, SORTING, REVERSING, PERMUTING:
        x <- c(5:1,5:10);  x
        rank(x)
        sort(x)
        rev(x)
        sample(x)        # random permutation of 'x'; can also
        sample(x, size=100, replace=T) # random sample of size 100 w. replt.
        sample(x, size=100)            # why does this not work?
#     Here is one of the more important functions: 
        order(x)         # !!!!!!!!!!!!!!!
        help(order)

        sort(x)
        x[order(x)]   # Same!
#     Sorts also character data lexicographically:
        x <- sample(letters);  x   # permute letters
        sort(sample(letters))

#     This is how you perform parallel sorting:
        x <- runif(10)
        y <- -x - 100   # 'y' is just another vector of the same length as 'x'.
        x; y            # Unordered parallel vectors
        ord <- order(x)
        x[ord]; y[ord]  # Sorts both "x" and "y" in ascending order of "x".
#
#
#---
#
# * SIMPLE STATISTICS:
        length(x)
        sum(x)
        mean(x)
        var(x)
        sd(x)
        min(x)
        max(x)
        range(x)
        median(x)
#    
#---
#
# * CUMULATIVE OPERATIONS:
        x <- 1:10
        cumsum(x)
        cumprod(x)
        x <- 1:10 * c(1,-1)
        cummax(x)
        cummin(x)
#    
#---
#
# * SIMPLE NUMERIC FUNCTIONS/TRANSFORMATIONS:
#     Most functions that accept one number and return another number
#     will naturally "vectorize" in R, namely, apply element by element.
        x <- runif(20, min=-10, max=+10)
        round(x)
        trunc(x)
        ceiling(x)
        abs(x)    
        sqrt(x)    # Comment?
        log(x^2)
        exp(1)
        exp(x/100)
        cos(pi)    # "pi" is predefined; the number e=exp(1) is not.
        acos(0.5)  # What is 'acos()'?
#
#
################ 
#
# * MATRICES:
#     Matrices in R are vectors with additional "meta-information"
#     to structure them in a rectangular form.  
#     The elements of the vector fill the matrix column by column.
#     ==> COLUMN MAJOR ORDER, as in Fortran, but unlike in C.
#     Reformatting as a matrix is achieved by giving the vector
#     a dimension attribute consisting of the numbers of rows and cols.
#
#   - Reformatting vectors as matrices by filling successive cols or rows:
        matrix(1:12, ncol=4)           # Column major (default)
        matrix(1:12, nrow=3)           # Same; ncol is inferred
        matrix(1:12, ncol=4, byrow=T)  # Row major, forced with "byrow".
        matrix(1:12, nrow=3, byrow=T)  # Same
        matrix(0:1, nrow=2, ncol=4)    # What happened?
        matrix(0, nrow=2, ncol=4)      #     "
        matrix(letters, ncol=2)        # Elements are now of type 'character'.
        matrix(paste("Letter",letters), ncol=2)
#     When reading data in text files, 'byrow=T' is needed 
#     for row-by-row input (download 'laser.dat' from the course page first):
        m <- matrix(scan("fakelaser.dat", skip=1), ncol=4, byrow=T)
#                                     ^^^^^^ Skip first line.
        m
#     Later we will see a more convenient function for reading
#     tabular data ('read.table()').

#   - Whether something is a matrix can be checked with 'is.matrix()':
        is.matrix(matrix(1:12,3));   is.matrix(1:12)
        x <- 2;     is.matrix(x)
        x <- 1:10;  is.matrix(x)
        x <- matrix(0, nrow=3, ncol=5);  is.matrix(x)
        is.matrix(matrix(0, nrow=3, ncol=5))  # tautology
#
#   - The dimension attribute: it is the sole difference between
#     a vector and a matrix.  It can be queried:
        dim(m)                # Vector of length 2 with the two dimensions.
        dim(m)[1];  dim(m)[2] # Each dimension separately.
        nrow(m);  ncol(m)     # Same.
#     Vectors can be turned into matrices by assigning the
#     dimension attribute:
        m <- 1:12           # Just a vector.
        dim(m) <- c(3,4)    # Now a matrix.
        m
        is.matrix(m)        # TRUE
        dim(m) <- NULL      # Stripping to a vector.
        m
        is.matrix(m)        # FALSE

#   - The dimension name attributes: row- and col-names
        colnames(m) <- letters[1:4]
        rownames(m) <- LETTERS[1:3]
        m
        colnames(m)
        rownames(m)

#   - Indexing/subselecting rows and columns:        (differs from C!)
        m <- matrix(1:12, ncol=4)
        m[1,4]                    # Element in row 1, column 4.
        m[1:3,]                   # First 3 rows.
        m[,3:4]                   # Last 2 columns.
        m[1:3,3:4]                # Submatrix of size 3x2 (unlike Python!)
        m[c(1,2,1,2),]            # Repeat rows 1 and 2.
        m[,c(1,2,1,2)]            # Repeat columns 1 and 2.
        m[c(1,2,1,2),c(1,2,1,2)]  # Repeat left-upper 2x2 matrix 4 times.
        m[-1,]                    # Select all but the first row.
        m[,-c(2,4)]               # Select all but columns 2 and 4.
        m["A",]                   # Only works if col/rownames have been assigned.
        m[c("A","C"),]
        m[c("A","C"),"a"]

#    - ATTENTION: Selection of individual rows and cols generates vectors
#                who do no longer know that they were rows or columns.
#                R has no concept of col-vectors and row-vectors:
                   m[,1]
                   is.matrix(m[,1])
                   is.matrix(m[1,])
#                Vector is vector, period (unlike Matlab).
#                You can force the issue by turning vectors into
#                Nx1 or 1xN matrices:
        x <- 1:10
        dim(x) <- c(10,1);  x
        dim(x) <- c(1,10);  x
#
#   - Index/subsetting can be used for assignment:
        m[1,2]     <- 0
        m[1,]      <- 11:14
        m[,1]      <- 0
        m[1,c(F,F,T,T)]   <- c(7,10)
#
#   - Associative array feature for matrices:
        rownames(m) <- c("x","y","z")       # like 'names(vec)'
        colnames(m) <- c("a","b","c","d")
        m["x","d"]           # number
        m["x",]              # vector
        m[,"c"]              # vector
        m[c("x","z"),c("c","a")]   # submatrix (different from Python!)
        m[c("x","z","x","y"),c("c","a","a")] # col-row-rearrangement
#

# Roadmap:
# - wrap up matrices
# - arrays
# - lists
# - dataframes
# - loops and conditionals
# - character manipulation functions
# - fcts related to distributions
# - plotting functions
# - writing FUNCTIONS
# - querying object types


#   - Column and row binding:
#     Two functions that permit collecting cols and rows to form matrices.
        x <- runif(5)                    # Play data.
        cbind(1:5, x, x, rep(10,5))      # Column binding.
        rbind(1:5, x)                    # Row binding.
#     (Vectors are NOT thought of as columns or rows on their own;
#      they take on these roles inside the "cbind" and "rbind" functions.)
#     Both functions accept an arbitrary number of conforming arguments.
#     You can also bind whole matrices:
        cbind(rbind(1:3,11:13,21:23), cbind(1001:1003,2001:2003))
#     A more friendly way of writing the same is:
        m1 <- rbind(1:3,11:13,21:23)        # 3x3
        m2 <- cbind(1001:1003,2001:2003)    # 3x2
        cbind(m1, m2)                       # 3x5
#     Conforming for 'cbind()' means the arguments have equal number
#     of rows, for 'rbind()' it means equal number of columns.  
#     If vector arguments are not conforming, R extends them cyclically
#     or clips them but may give you a warning if the shorter arguments
#     are not of fractional length of the longest argument:
        cbind(1:3,0)        # second arg has size 1, = fraction of 3
        cbind(1:6,1:3)      # size 3 is a fraction of size 6
        cbind(1:3,1:2)      # size 2 is not a fraction of size 3 => warning
        cbind(1:3,matrix(11:14,2)) # clipping: the second arg dictates nrow
#     Don't rely on cyclic extension except for the simplest cases
#     such as repeating constants.

#   - Coercion of matrices to vectors:
#     A matrix can always be treated as a vector.
#     The following does not create an error message:
        m <- matrix(1:12, nrow=3)
        m[,1]
#     Recall the column-major convention for storing matrices in R.        
#
#   - Some useful functions for generating patterned matrices:
        diag(5)
        outer(1:3,1:4)
        outer(1:3,1:4, FUN=paste, sep="")
        help(outer)
        x <- outer(1:3,1:4)
        row(x)
        col(x)
        row(x)>col(x)
        x[row(x)>col(x)]

#   

################
#
# * ARRAYS: the generalization of matrices to more than 2 indexes
#
          a <- array(1:24, dim=c(2,3,4))
          a
          a[1,2,1]
          a[,2:3,c(1,4)]
          a[,,c(T,F,T,F)]
          a[,,-3]
#       Main use: contingency tables
#         e.g., table frequencies of sex by education by income bracket ...
#       The associative array feature exists also when a dimnames are given
#         To understand this, we need to talk about lists first.
#
#
################  read/study up to here for HW 1 #####################
#
# * LISTS:
#
#   - Recall: Vectors and matrices can carry only one basic type
#             of data at a time, numeric OR logical OR character.
          matrix(c(T,F),nrow=4,ncol=4)
          matrix(paste(LETTERS,letters)[1:25],nrow=5)
#     Lists are data structures without this restriction.
#     Lists are sequences of anything.  They can contain:
#       basic data types, vectors, matrices, arrays, lists (recursion),...
#     In particular, they can contain arbitrarily nested lists of lists.
#     Examples:
        list(1,"1",T,F,1E100,NA,-Inf,NULL,1:5,letters[2:5],list(1,2,"a"))
        # Balanced binary tree:
        list(list(list(1,2),list(3,4)),list(list(5,6),list(7,8)))  
#
        mylist <- list(vec=1:3, mat=cbind(1:2,3:4), flags=c(T,T,F,T),
                       lst=list(1:3,1:4))
        mylist
#     Component names are optional.  They can be glued on by force:
        x <- list(1,"a",T,NULL);  names(x) <- LETTERS[1:4];  x

#   - Access to LIST ITEMS is by index with "[[..]]", or by "$name"
#     if names exist:
        mylist[[2]]
        mylist$mat
        mylist[["mat"]]
#     This is also how lists are printed:
        list(1,T)
        list(a=1,b=T)
#
#   - Access to SUBLISTS is as if the list were a vector:
        mylist[2:3]                           # Sublist of length 2.
        mylist[2]                             # Sublist of length 1.
        mylist[c(1,4,1,4,2,3,2,3)]            # Out-of-order and expansion.
        mylist[c("lst","mat","vec","mat")]    # Named access.
        mylist["vec"]                         # Sublist of length 1.
        mylist[["vec"]]                       # Vector!!!
        mylist[c(T,F,T,F)]                    # Logical selection
#         
#   - Sublists are lists and require list item access to get at
#     the components:
        mylist[2:3][[1]]
        mylist[2:3]$mat
        mylist[2][[1]]       # Again, "mylist[2]" is a list of length 1...
        mylist[2]$mat        # Dito.
#
#   - Primary use of lists in statistics: 
#     collecting the results of a complex statistical or numerical
#     analysis, such as a regression or an eigendecomposition:
        eigen(matrix(1,3,3))
#     is a list with two named items: $values and $vectors,
#     the first being a vector containing the eigenvalues,
#     the second being a matrix with the eigenvectors in the columns.
#
#   
#
################
#
# * DATAFRAMES:
#
#   - In statistics, data are usually rectangular tables, cases by variables.
#     Problem: Variables are not all of the same type.
#              Some may be quantitative, hence stored as numeric data,.
#              Other variables may be categorical and stored either
#              with numeric or character/string codes for categories.
#              => Matrices cannot accommodate variables of both types...
#     Solution: Data frames.  They are similar to matrices,
#               but columns may differ in basic data types.
#               (The entries have to be basic, not complex.)
#
#     Main use of dataframes: data tables with mixed-type variables
#
#     Dataframes are printed like matrices, but they are internally
#     implemented as lists.
#
#   - The function "data.frame()" can bundle conforming vectors,
#     matrices, other dataframes into a single dataframe:
        myframe <- data.frame(somenumbers=1:3,
                              somecharacters=c("a","b","c"),
                              somelogicals=c(T,F,T))

        myframe
#
#   - Auxiliary functions for dataframes:
        is.data.frame(myframe)          # Checking type.
        as.data.frame(cbind(1:4,11:14)) # Coercing a matrix to a dataframe.
#
#   - Many matrix manipulations carry over to dataframes,
#     with one exception:
        dim(myframe)
        nrow(myframe)
        ncol(myframe)
        rownames(myframe)
        colnames(myframe)
        myframe[,3]      # Col 3 coerced to vector.
        myframe[2,]      # << Sub-dataframe with row 3, NOT coerced to vector!
        myframe[,2:3]    # Sub-dataframe consisting of cols 2 and 3.
        myframe[2:3,]    # Sub-dataframe consisting of rows 2 and 3.
#     Why is 'myframe[2,]' not coerced to a vector?
#     Because the items might be of differing types!
#     Hence the row 'myframe[2,]' is still a dataframe...
#
#     (Of course matrix multiplication does not work:)
        myframe %*% matrix(rep(1,10), nrow=5)

#   - 'read.table()' reads a tabular ASCII/txt file into a dataframe,
#     possibly with row and column names:
        read.table("fakelaser.dat", header=F)
#     The file can be an URL:
        url <- "http://www-stat.wharton.upenn.edu/~buja/STAT-541/laser.dat"
        my.frame <- read.table(url, header=T)
#     This function has many other options for particular cases.
#     From the "help()" page:
#       read.table(file, header = FALSE, sep = "", quote = "\"'", dec = ".",
#                  row.names, col.names, as.is = FALSE, na.strings = "NA",
#                  colClasses = NA, nrows = -1,
#                  skip = 0, check.names = TRUE, fill = !blank.lines.skip,
#                  strip.white = FALSE, blank.lines.skip = TRUE,
#                  comment.char = "#")

#   - Since data frames are lists of columns, we can use "lapply()" (list-apply):
        lapply(myframe, class)
#     The following does not do the right thing:
        apply(myframe, 2, class)
#     Why?  "apply()" expects a matrix in its first argument;
#     if it isn't, it gets coerced into a matrix;
#     but matrices can't have factors in their columns, only vectors,
#     so the factor columns are coerced to character columns.

################################################################
#
# Flow control: loops, conditionals
#
    m <- 1:12   #play data
#
#   - if-conditional:
        if(length(m) > 15) { print("m is greater than 10") }
#     With "else" clause:
        if(length(m) > 15) {
          print("m > 10")
        } else { 
          print("m <= 10")
        } 
#     This sort of thing is most useful inside loops; see below.

#   - The vectorized "ifelse()" function:
#     Not a flow control construct, but often replaces a combination of
#     for-loop and if-else statements.
        ifelse(c(T,F,T), c(1,2,3), c(-1,-2,-3))
#     The function runs down the three arguments in parallel,
#     checks each element in the first argument,
#     if true,  picks the corresponding element in the second argument,
#     if false, picks the corresponding element in the third argument,
#     returns a vector/matrix/array of the size of the first argument.
#     If the second or third argument are not conforming,
#     they are cyclically repeated, as in this implementation of
#     10 Bernoulli trials:
        ifelse(runif(10) > 0.5, "H", "T")

#   - Note the difference between 'if' and 'ifelse()':
#     * 'if' is a syntactic element that dispatches execution
#       depending on the outcome of a single logical outcome.
#     * 'ifelse()' is a function that takes a logical vector
#       and selects from two other vectors depending on the logicals.

#   - for-loop: runs over the elements of a vector.
        for(i in c(10,100,1000)) { j <- 2*i; print(j); }
#     The variable 'i' is the looping variable.  It gets set to
#     each element of the vector in turn, and for each
#     the subsequent, usually composite ({...}) statement gets executed.
#     (Braces are optional if there is only one statement in the loop.)

#   - repeat-loop: needs a "break" for termination.
        repeat{ print("Trying..."); rnum <- runif(1);
                if(rnum > 0.9) { print(c("Found one:",rnum)); break } }

#   - while-loop:
        str <- "Not yet..."
        while(runif(1) < 0.99) {
          str <- paste(str,".",sep="")
          print(str)
        }
        print("Finally...")
#
#
#   - Looping over row or columns of matrices with 'apply()':
        m <- matrix(1:12, 3);  m
#     * Looping over rows::
        apply(m, 1, min)   # Return a vector with minima of the rows.
#                   ^^^ the "min()" function, applied to the 1st dimension.
#     * Looping over columns:
        apply(m, 2, mean)  # Return a vector with the means of the columns.
#                     ^^^^ the "mean()" function, applied to the 2nd dim.
#     * 'apply()' can also be used with functions that return vectors, 
#       such as 'range()' and 'sort()':
        apply(m, 2, range)
#     There are complications with "apply(m, 1, range)":
#     the result is 2xnrow(m), not nrow(m)x2, as one would expect.
#     This requires transposition, 't()', to get the expected matrix:
        t(apply(m, 1, range))
#
#
#   - Looping over elements of a list:
        lis <- list(numvec=1:10, charvec=letters,
                    logicvec=rep(c(T,F),3), mat=cbind(1:3,1))
        lis
        lapply(lis, length)           # returns a list with one number per entry: the length
        unlist(lapply(lis, length))   # same but 'flattened' to a vector
        sapply(lis, length)           # same but Simpler ('Simple apply')
        lapply(lis, dim)              # returns a list with the dim attribute for each entry
        lapply(lis, sort)             # returns a list of sorted vectors

################################################################
#
# * STRING MANIPULATION:
#
#   R has a number of functions that make the use of other scripting
#   languages such as awk, perl, python less and less necessary for
#   pattern matching problems.  There are functions for searching
#   and substituting text patterns expressed as so-called
#   "regular expressions".  Here is a collection:
#
#      paste(..., sep = " ", collapse = NULL)
#      substr(x, start, stop)
#      substring(text, first, last = 1000000)
#      substr(x, start, stop) <- value
#      substring(text, first, last = 1000000) <- value
#      strsplit(x, split, extended = TRUE)
#      nchar(x)     # string length
#      chartr(old, new, x)
#      tolower(x)
#      toupper(x)
#      match(x, table, nomatch = NA, incomparables = FALSE)
#      x %in% table
#      pmatch(x, table, nomatch = NA, duplicates.ok = FALSE)
#      charmatch(x, table, nomatch = NA)
#      grep(pattern, x, ignore.case=FALSE, extended=TRUE, value=FALSE)
#      sub(pattern, replacement, x,
#              ignore.case=FALSE, extended=TRUE)
#      gsub(pattern, replacement, x,
#              ignore.case=FALSE, extended=TRUE)
#      regexpr(pattern, text,  extended=TRUE)
#
#  String dimensions when plotting:
#      strwidth(s, units = "user", cex = NULL)
#      strheight(s, units = "user", cex = NULL)
#
#  Example: download the dataset 'dict.dat' from the course page, then...
     dict <- scan("DATA/dict.dat",w="",quote="")
     sel <- grep("source", dict)   # All words containing "source".
     dict[sel]
#  Stay tuned for HW 3.
#
#
################################################################
#
# * DISTRIBUTIONS: PSEUDO-RANDOM NUMBERS, QUANTILES, CDFS, DENSITIES
#
#     The following continuous distributions come with the standard
#     version of R, each with
#     . a random number generator,
#     . a quantile function,
#     . a cdf function, and
#     . a density fct.

#   - Uniform:
#       runif(n, min = 0, max = 1) 
#       qunif(p, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE) 
#       punif(q, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE) 
#       dunif(x, min = 0, max = 1, log = FALSE) 
#
#   - Normal:
#       rnorm(n, mean = 0, sd = 1) 
#       qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE) 
#       pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE) 
#       dnorm(x, mean = 0, sd = 1, log = FALSE) 
#                  
#   - Student's t:
#       rt(n, df)         
#       qt(p, df, lower.tail = TRUE, log.p = FALSE)
#       pt(q, df, ncp, lower.tail = TRUE, log.p = FALSE)
#       dt(x, df, log = FALSE)
#
#   - F:
#       rf(n, df1, df2)
#       qf(p, df1, df2, lower.tail = TRUE, log.p = FALSE) 
#       pf(q, df1, df2, ncp = 0, lower.tail = TRUE, log.p = FALSE) 
#       df(x, df1, df2, log = FALSE) 
#                  
#   - Chi-square:
#       rchisq(n,df,ncp=0)
#       qchisq(p, df, ncp = 0, lower.tail = TRUE, log.p = FALSE) 
#       pchisq(q, df, ncp = 0, lower.tail = TRUE, log.p = FALSE) 
#       dchisq(x, df, ncp = 0, log = FALSE) 
#                  
#   - Exponential:
#       rexp(n, rate = 1)
#       qexp(p, rate = 1, lower.tail = TRUE, log.p = FALSE) 
#       pexp(q, rate = 1, lower.tail = TRUE, log.p = FALSE) 
#       dexp(x, rate = 1, log = FALSE) 
#                  
#   - Cauchy:
#       rcauchy(n, location = 0, scale = 1) 
#       qcauchy(p, location = 0, scale = 1, lower.tail = TRUE, log.p = FALSE)
#       pcauchy(q, location = 0, scale = 1, lower.tail = TRUE, log.p = FALSE)
#       dcauchy(x, location = 0, scale = 1, log = FALSE) 
#                  
#   - Beta:
#       rbeta(n,shape1,shape2)
#       qbeta(p, shape1, shape2, lower.tail = TRUE, log.p = FALSE) 
#       pbeta(q, shape1, shape2, ncp = 0, lower.tail = TRUE, log.p = FALSE) 
#       dbeta(x, shape1, shape2, ncp = 0, log = FALSE) 
#                  
#   - Gamma:
#       rgamma(n,shape,rate=1,scale=1/rate)
#       qgamma(p, shape, rate = 1, scale = 1/rate, lower.tail = TRUE, 
#       pgamma(q, shape, rate = 1, scale = 1/rate, lower.tail = TRUE, 
#       dgamma(x, shape, rate = 1, scale = 1/rate, log = FALSE) 
#
#  Some uses:
#     - Random number generators are used, for example, 
#       . in simulations, as when evaluating the efficiency
#           of statistical methods;
#       . in Bootstrap inference for frequentist statistics;
#       . in Bayesian computing to simulate posterior distributions.
#       Base of simulations: law of large numbers (rel. freq. approx. probs.)
#     - The quantile functions are used
#       . to find critical values in statistical tests;
#       . in q-q-plots to check empirical against theoretical distributions
#         (see below).
#     - The cdf functions are used for calculating p-values in 
#         statistical tests.
#     - The normal density is sometimes used as a "kernel" in 
#         smoothing methods.
#
#     - Simulating discrete distributions and sampling:
#       The function
          sample
#       serves many purposes.  It does sampling with and without replacement.
#
#     - Bernoulli trials and Binomials: e.g., 10 head/tails, biased coin flip,
          ifelse(runif(10)<.55, "H", "T")
          sample(c("H","T"), size=10, repl=T, prob=c(0.55,0.45))
          rbinom(n=10, size=1, p=.55)
        # (Sampling WITH replacement is also called i.i.d. sampling.)
#
#     - Multinomial: e.g., 10 draws from uniform distribution on 4 objects
          sample(1:4, size=10, repl=T, prob=rep(1/4,4))
          dmultinom; rmultinom
#
#     - Sampling WITH replacement:
          sample(1:10, 5)               # Samples w/o replacement (default).
          sample(10)                    # Random permutation of 1:10.
#     - The function can also be applied to non-numeric data:
          sample(letters)               # A permutation of letters.
          sample(letters, 10)           # 10 distinct random letters.
          sample(letters, 10, repl=T)   # 10 i.i.d. samples of letters.
          sample(letters, 100)          # Error!  Sampling w/o replacement.
          sample(letters, 100, repl=T)  # Fine!  Sampling with replacement.
#
#     'sample()' is used to implement modern resampling methods such as
#     the bootstrap and permutation tests (see below).
#
# . Important note on seeding random number generators:
#     The "seed" stores the state of the pseudo-random number generator.
        .Random.seed
        runif(1)
        .Random.seed                      # The seed has changed.
        Random.seed.store <- .Random.seed # Store the seed.
        runif(1)                          # (*) Remember this random number.
        runif(10)                         # Now push the generator 10 times.
        .Random.seed <- Random.seed.store # Force it back to recreate (*)
        runif(1)
#     Indeed, this is the same random number as in (*).
#     Storing the seed is important for simulations that must be
#     reproduceable, for example, when putting simulation results
#     in a publication.
#
################################################################
#
# * PLOTTING:
#
# - The par() function for querying and setting plotting parameters.
      help(par)
#
#   Some important parameters to set:
      par(mfrow=c(3,4),         # 3x4 layout of 12 plots, filling rows first (mfcol)
          mgp=c(2.0, 0.5, 0),   # distance of axis title ("x","y"),
                                #   numbers at the ticks, border line,
                                #   (in margin lines)
          mar=c(3,2.5,2.5,1.5), # margins: bottom-left-top-right (in lines)
          oma=rep(1,4),         # outer margin around the collection
                                #   of plots on the page (in lines)
          mex=0.8,              # expansion of margin line width,
                                #   relative to default
          cex=0.8)              # expansion of characters, relative to default
#
# - List of all possible plot characters:
    windows(width=10, height=3)
    plot(1:25, rep(1,25), pch=1:25, xlab="", ylab="", yaxt="n", cex=2)
#
#
################################################################
#
# WRITING FUNCTIONS:
#
# Syntax: simplest case
    fun1 <- function(x) { plot(x) }
    fun2 <- function(x) { 2*x }
# Semantics 1: fun1 creates a 'side effect', plotting the input argument;
#              fun2 returns a result, the doubled input argument.
    fun1(1:10)  # plots 1,2,...,10
    fun2(1:10)  # returns the vector containing 2,4,...,20

# Semantics 2: Functions are 'first class citizens', that is,
# they can be assigned, printed, passed as arguments,...
    fun2            # Print the function.
    print(fun2)     # Same.
    funx <- fun2;  funx(1:5)  # Application:   len <- length;  len(1:10)
# What is this?
    (function(x) { 2*x })(1:10)
# It's getting weird:
    funp <- function(f) print(f)
    funp(funp)  

# Assignment:
    x <- fun2(1:10);  x   # Fine.
    x <- fun1(1:10);  x   # Assigns NULL, but plots.  'fun1()' is for side effect.

# Syntax: The following are equivalent ways of writing fun2().
    fun2 <- function(x) { 2*x }   # The original.
    fun2 <- function(x) 2*x       # Single statement bodies don't need braces.
    fun2 <- function(x) { return(2*x) }   # Make the return explicit.
    fun2 <- function(x) { y <- 2*x;  y }  # Value of last statement is returned.
    fun2 <- function(x) { y <- 2*x;  return(y) }   # Dito

# Functions with more arguments and complex bodies:
    fun3 <- function(t, q) {
      par(mgp=c(1.8,.5,0), mar=c(3,3,2,1))
      plot(t, q, pch=16, cex=.5)
    }

    fun3(t=1:100, q=rnorm(100))

# Function calls with named arguments: independent of order of arguments
    fun3(q=rnorm(100), t=1:100)

# Functions with defaulted arguments: defaults can use preceding arguments
    fun4 <- function(y=rnorm(100), x=1:length(y), cex=.5, pch=16, w=5, h=5, new=T) {
      if(new)
      par(mgp=c(1.8,.5,0), mar=c(3,3,2,1))
      plot(x, y, pch=pch, cex=cex)  # 1st 'cex': argument name
                                    # 2nd 'cex': value to be passed to plot
    }                     
    fun4()   # All arguments defaulted.
    fun4(1:100, rnorm(100))  # 1st and 2nd argument passed by order.
    fun4(1:100, rnorm(100), new=F)  # Last argument is 7th by order, so needs name.
    fun4(1:100, rnorm(100), new=F, cex=.2)
    fun4(1:100, rnorm(100), new=F, cex=1, pch=3)
    fun4(x=1:100, y=rnorm(100), pch=2, w=10, h=2) # x= and y= not needed but more readable
    fun4(cex=.2)

# Functions returning complex data structures:
    fun5 <- function(x) {
      list(N=length(x),
           location=c(
             mean=mean(x),
             mean.tr.05=mean(x,trim=.05),
             mean.tr.10=mean(x,trim=.10),
             mean.tr.25=mean(x,trim=.25),
             median=median(x)
             ),
           dispersion=c(
             sdev=sd(x),
             mad=mad(x),
             IQR=IQR(x)
             )
           )
    }
    summaries <- fun5(rnorm(10000))
    summaries

# Semantics 3: All passing of arguments is by value, not reference/name.
#   In other words, all arguments get copied into the body of the function.
    fun5 <- function(x) { x[1] <- Inf; x }
    x <- 1:3;  fun5(x);  x
    # In the above line, fun5() is working on a copy of x, also called x.
    
# Semantics 4: Function bodies have access to outside variables.
    fun6 <- function() { x[1] <- Inf; x }
    x <- 1:3;  fun6()
    x  # 'x' was not changed.  The body of fun6() worked on a copy of x.
    # Rule: Do not use this feature of R semantics.
    #       Pass all data into a function as arguments.
    # (See Section 10.7 of Venables & Smith on "scoping rules" in R.)

# Functions called inside functions:
    fun7 <- function(x) { rbind(x, fun2(x)) }
    fun7(1:4)
# (This is an exception to the rule of not relying on the scoping rules of R.)

# Functions defined inside functions:
    fun8 <- function(x) { fun9 <- function(x) { 2*x };  fun9(x) }
    fun8(1:5)
    fun9(1:5) # Does not exist; defined only inside the body.

# Functions passed as arguments into other functions:
    x <- matrix(rnorm(1000),100,10)
    fun9 <- function(x) quantile(x, prob=c(.25,.50,.75))
    apply(x, 2, fun9)
# Equivalent:
    apply(x, 2, function(x) quantile(x, prob=c(.25,.50,.75)))

################################################################
#
# * QUERYING R OBJECTS:
#
# Asking for the primary data type:
    class(1:10)
    class(T)
    class(letters)
    class(swiss)     # Like 'letters', 'swiss' comes with R.
#   
# Queries about basic data types:
    is.numeric(1:10)
    is.character(letters)
    is.logical(F)
    is.na(NA)  # !!!!!!!!!!! use for removal of NAs:
        x <- rnorm(100);  x[rnorm(100)>1] <- NA;  is.na(x);  x[!is.na(x)]
    is.infinite(-Inf)
    is.null(NULL)
# 
# Queries about complex data types:
    is.vector(letters)
    is.array(array(1:12,c(2,3,2)))
    is.matrix(swiss)
    is.data.frame(swiss)
    is.list(swiss)
    is.function(mean)
#
# All the query functions that start with "is.":
    apropos("^is[.]")   # '.' is a special character in regular expressions.
#
# Querying components of lists and columns in data frames:
    names(swiss)
# Querying row and column names in matrices and data frames:
    colnames(swiss)   # Same as names() for data frames.
    rownames(swiss)
#
################################################################
#
# * MORE ON R: A MENTAL MODEL FOR R
#
#     black box with inner state described by
#       * Variables x, y, z, err, ..., pi, letters, LETTERS, ...
#       * Their values, that is, the data structures such as
#           values, vectors, matrices,...
#           to which the variables point.
#       * The black box has an engine, the intepreter,
#           that acts on the state of the box.
#       * The state of the black box is changed by executing
#           assignments, such as        x <- runif(100)
#       * On quitting q() you decide whether to save the newly
#           formed variables and their values.
#       * Learn about the state of the black box by executing:
#         . ls() to learn what variables are bound
#         . print(x) to learn what the value of the variable is
#       * There are two additional black boxes:
#         . par(), ... to learn about the values and data structures
#           of two sub-boxes:
#         - Plotting box:
#         . State: plotting parameters such as character size, margin width,...
#         . Reports the settings of the plotting parameters:
              par()
#         . State can be changed by executing, say,
              par(mfrow=c(2,2))
#         - Random number generator:
#         . State: the seed vector
              .Random.seed
#         . State changes when 1) a random number is generated, or
#                              2) .Random.seed is set by the user
#         - Printing and other parameters, e.g., line width, number of digits...
              options()
#
#
################################################################
#
# Changing the working directory:
# In the standard interface, one can change the working directory...
#    - temporarily: -> File -> Change Dir
#    - permanently: R-click on R icon -> Edit Properties -> Start in:
#
################################################################

