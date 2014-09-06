####### INSTALLING PACKAGES #######

# CRAN is the repository for R packages
# To see a list of available package in CRAN
available.packages()

# Just see the first five available packages
pckgs <- available.packages()
head(rownames(pckgs), 5)
# Installating a package
install.packages("slidify")
install.packages(c("x", "y", "z"))
# Dependent packages will also be installed

source("http://www.url.com/fileName.R")
fileName() # fileName is the file we have for the man group
fileName(c("x", "y")) # Install new packages

install.packages("ggplot2")

# Load packages
library(ggplot2)

# To see the functions exported by the package
search()

# To see the objects in the workspace
ls()

####### SETTING WORKING DIRECTORY #######

# To see current working directory
getwd()

# To read a file, that file should be in the working directory
read.csv("mydata.csv")

# Shows the content of the current directory
dir()

# Change working directory
setwd("/Users/cemalperozen/Documents/Repos/datasciencecoursera/RProgramming")
getwd()

# Write a function in a text editor and save it to your current working dir
dir() # See if the R file in the working directory
# To call that function, use
source("xxx.R")
ls() #To see the functions in the workspace

####### HELP #######

?c      #to get help about c() function
?`:`    #to get help for operators use back tick

####### DATA TYPES IN R #######

# 5 basic classes of objects
# character
# numeric #real numbers, decimal number
# integer
# complex
# logical

# Vector: A basic object which contains objetcs of the same class
# List is an exception which can contain objects of the different classes
# Created with vector(), 2 basic arguments, 1st class, 2nd length

# Numbers
# usually R treats numbers as numeric objects - double precision real numbers
# To specify an integer add "L" as suffix
# 1 vs 1L
# Inf : Infinity
# NaN : Undefined value

# Attributes of R objects:
# names, dimnames
# dimensions
# class
# length
# other user defined attributes/metadata
# attributes() is used to access the attributes of an object

x <- 1   # assignment procedure
x        # auto-printing
print(x) # explicit printing
attributes(x)
x <- "hello"
attributes(x)
x <- c(1,2,3)
attributes(x)
x <- cbind(a = 1:3, pi = pi)
attributes(x)

# strip an object's attributes:
attributes(x) <- NULL
x # now just a vector of length 6

# Column operator
x <- 1:20 #column operator was used to create an integer sequence
x

# Creating vectors of objects
# c is used for creating vectors. C is similar to concatenate
x <- c(1,2)            #numeric vector of length 2
x <- c(TRUE, FALSE)    #logical vector
x <- c(T, F)           #logical
x <- c("a", "b", "c")  #character vector
x <- 9:29              #integer vector
x <- c(1+0i, 2+4i)     #complex vector

# Creating a vector with 2 arguments 
x <- vector("numeric", length = 10) 
x

# Mixing objects
# Coercion occurs based on least common denominator
x <- c(1.7, "a")       #character vector because there is no numeric representation of string "a"
x <- c(TRUE, 2)        #numeric vector, True can be represented as number 1
x <- c("a", TRUE)      #character

# Explicit Coercion
# Use as.*
x <- 0:6
class(x)              #will pring integer
as.numeric(x)         #converts to numeric
class(as.numeric(x))  #class is numeric
as.logical(x)         #converts to logical, 0 is False, everything is True
as.character(x)

# Non-sensical coercion, you get NAs if you try to do that
x <- c("a", "b", "c")
as.numeric(x)
as.logical(x)

# Matrices 
# Vectors with dimension attribute
m <- matrix(nrow = 2, ncol = 3) #matrix will initialize with NAs
m
dim(m) #prints the dimensions
attributes(m) 
class(m)
# Matrix construction
# Method 1
# Constructed columwise, first column gets filled first and moves to next column
m <- matrix(1:6, nrow = 2, ncol = 3)
m
# Method 2
# you can create the vector first and then add dimension attribute later
m <- 1:10
dim(m) <- c(2,5) # rows and then columns
m
# Method 3
# Binding to vectors
x <- 1:3
y <- 10:12
cbind(x,y)
rbind(x,y)

# Lists
# Special type of vector that can obtain elements of different classes. 
x <- list(1, 2, c("a","b","c"), TRUE, 1+4i)
x             # prints the list
x[[1]]        # prints the first element of the list
x[[3]]        # prints the 3rd element of the list, which is a vector of strings
x[[3]][2]     # prints the 2nd element of the 3rd element of the list

# Factors
# Used for categorical data
# Can be oredered and unordered
# Each element of the vector is labelled for easy access/calc
# Factors are treated specially by modeling functions like lm(), glm()

# Use factor() to create factors
# Need a character vector to define levels/labels
x <- factor(c("yes", "yes", "no", "yes", "no"))
x           # will print the vector and indicate the levels which are yes and no
table(x)    # will display the frequency of each label: 2 no, 3 yes in x
unclass(x)  # strips out the class for the vector
# levels argument
# the first level is the baseline level
# the order is important in linear modeling
# if you don't use the levels argument, then R will use the order in the alphabet so "no" will be the first level
x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
x

# Missing Values
is.na()      # to test objects if they are NA
is.nan()     # is used to test for NaN
# NA values also have a class, integer, character NAs can be present
# NaN value is also NA but the opposite is not true

x <- c(1, 2, NA, 10, 3) #because this is a numeric vector, NA will be numeric type
is.na(x)     # True will show the location of the NA value
is.nan(x)    # True will show the location of NaN
x <- c(1, NaN, NA, 10, 3)
is.nan(x)

# Data Frame
# To show Tabular data
# Special type of list where each element of the list has to have the same length
# Each element of the list is a column and the length of each element of the list is the number of rows
# Unlike matrices, data frames can store different classes of objects in each column
# Special attribute: row.names, each row has a name, used to annotate data
# Can be created by using: data.frame(), read.table(), read.csv()
# Can be converted to a matrix by calling data.matrix()

x <- data.frame(foo = 1:4, bar = c(T,T,F,T))
x
nrow(x)  # to get the number of rows
ncol(x)  # to get the number of columns

# Names
# R objects can also have names. This makes the code readable

x <- 1:3
names(x)  # no names yet
names(x) <- c("first", "second", "third")
x
names(x) # to get the names

x <- list(a = 1, b =2, c = 3) # lists also have names
x

m <- matrix(1:4, nrow =2, ncol = 2) #matrices have dim names
dimnames(m) <- list(c("a", "b"), c("d", "e")) #first names for the rows, then names for columns
m

####### SUBSETTING #######

# []     # always returns an object of the same class as the original
# [[]]   # ectract elements of a list or a data frame, the class of the extracted object will not necessarily be a list or data frame
# $      # used to extract elements of a list or data frame by name

x <- c("a", "b", "c", "d", "a", "b")  #character vector
x[1]           # first element, character vector with 1 element
x[3]      
x[2:3]         #sequence of elements
x[x>"b"]       # can use logical indices
y <- x > "b"   # assign T, F to another vector. Y is a logical vector
y              # print y
x[y]           # get subset of x using y

#subsetting matrices
# use (i,j)
x <- matrix(1:6, 2, 3)
x
x[1,2] # extract element in the first row and second column
x[2,1] # extract element that is located at the intersection of second row and 1st column
x[1,]  # get all the elements in the first row
x[,2]  # get all the elements in the second column

# The result of a matrix subset operation is a vector. 
# drop = False will preserve the type and result in a matrix
# by default drop is assigned True
x[1, 2, drop = FALSE] # will subset the first row and second column element in a matrix form

x[1,]
x[1, , drop = FALSE]


# Subseting a list

x <- list(foo = 1:4, bar = 0.6) # 2 element list
x            #print the list
x[1]         #get the first element in the list form using single bracket(preserve the class)
x[[1]]       #get the first element in a simple sequence form 
x$bar        #you can use the name of the element
x[["bar"]]   #double bracket to get the simple sequence
x["bar"]     #single bracket to get the first element as a list

x <- list(foo = 1:4, bar = 0.6, baz = "hello") # 2 element list
x
x[c(1,3)] #if you'd like to get more than 1 element of the list, you can only use single bracket
          #result will be another list


[[]] operator is useful
name <- "foo"
x[[name]] # you can use variables to subset a list by using [[]]
x$name    # you cannot use variables to subset a list by using $ operator
x$foor    # if you want to use $ operator, you need to use the actual name of the elemnt

x <- list(a = list(10,12,14), b = c(3.14, 2.81))
x             
x[[c(1,3)]]   #to get 14
x[[1]][[3]]   #similar result
x[[c(2,2)]]

# Partial Matching
#useful when you are working using command window
x <- list(aardvark = 1:5)
x$a         #partial match
x[["a"]]    #doesn't work this way
x[["a", exact = FALSE]]  #use exact argument to hget partial match

# Removing NA Values
x <- c(1, 2, NA, 4, NA, 5)
#create a logical vector which tells wehre the missing values are
bad <- is.na(x) #logical vector with T and F values
x[!bad]         #use ! operator to get the non missing values

#complete cases
y <- c("a", "b", NA, "d", NA, "f") 
good <- complete.cases(x,y) #to find the intersection of good data in 2 vectors
good
x[good] 
y[good]

airquality[1:6,] #there are six columns in this data frame
good <- complete.cases(airquality) #which rows are complete
airquality[good,][1:6,]            #print the first 6 complete rows


####### READING/WRITING DATA #######

#reading
read.table, read.csv  #reading tabular data
readLines             #reading lines of text data
source                #reading in R code files (inverse is dump)
dget                  #reading in R code files (inverse is dput)
load                  #reading in saved workspace
unserialize           #reading single R objects in binary form

#writing
write.table
writeLines
dump
dput
save
serialize

#most commly used is the read.table
#read.table arguments
 #file              #file name
 #header            #logical indicating if the file has a header line, default is FALSE
 #sep               #a string indicating how the columns are separated, default separator is space
 #colClasses        #a character vector for the class of each column in the dataset
 #nrows             #the number of rows in the dataset
 #comment.char      #a char string indicating the comment character, default is "#"
 #skip              #the number of lines to skip from the beginning
 #stringsAsFactors  #should character character variables be coded as factors? (default is TRUE)

#read.csv           #default separator is ",", header is always TRUE

# To speed up data reading
# Make a rough calc of the memory required to store dataset
  #1.5MM rows, 120 columns, numeric data
  # 8bytes per numeric object
  # 1.5E6*120*8bytes/(2^20bytes/MB) = 1.34 GB
  # Rule of thumb is reading the data will take 2 times the memory calculation
# define the type of variable in each column
  # use colClasses argument
  # quick way of efficiently assigning column classes
  initial <- read.table("xxx.txt", nrows = 100)
  classes <- sapply(initial, class)
  tabAll <- read.table("xxx.txt", colClasses = classes)
# idenfiy the number of rows and use nrows
  #if the data is large, you can read it in chunks
  #Unix tool "wc" helps to read number of lines in a file
# Set comment.char = "" if there are no commentted lines in your file

#dump, dput
  #useful becuase the resulting text format is editable, and in the case of corruption
  #potentially recoverable
  #preserve the metadata
  #works better with subversion and git
  #longer-lived 
  #requires more space, needs compression

#dput, dget
#can be used for one object only
y <- data.frame(a = 1, b = "a")
dput(y)               #writes the object to the console
dput(y, file = "y.R") #writes the object to a file in your current working dir
new.y = dget("y.R")   #gets and constructs the object 
new.y

#dump, source
#can handle multiple objects
x <- "foo"
y <- data.frame(a = 1, b = "a")
dump(c('x','y'), file = 'data.R')
rm(x,y)  #remove objects from workspace 
source("data.R") #source them back from the file
y
x

#Reading data from outside

file    #opens a connection to a file
gzfile  #opens a connection to a file compressed with gzip
bzfile  #opens a connection to a file compressed with bzip2
url     #opens a connection to a webpage

#file
str(file)
  #description - name of the file
  #open 
     # r : read only
     # w : initialize and write
     # a : append to a file
     # rb, wb, ab : read, write, append in binary mode for Windows

con <- file("foo.txt", "r")
data <- read.csv(con)
close(con)

#is the same as

data <- read.csv("foo.txt")

#connection is useful when you want to read file partially

con <- gzfile("words.gz")
x <- readLines(con, 10)
x
writeLines # takes a char vector and wirtes each element one line at a time to a text file

#readlines to read elements from a webpage
con <- url("http://www.jhsph.edu","r")
x <-readLines(con)
head(x)
close(con)

####### SWIRL #######
#interactive way of learning R
#similar to datacamp
http://swirlstats.com
install.packages('swirl') #install the swirl package
library(swirl)            #load package
ls()                      #see the variables in the workspace
rm(list = ls())           #delete variables from workspace
swirl()                   #start swirl

####### SEQUENCE OF NUMBERS #######

1:20      #simplest way to create a sequence
pi:10     #real number sequence
15:1      #can go backward

#seq() function
seq(1, 20)                 #similar to 1:20
seq(1, 20, by = 0.5)       #increment
my_seq <- seq(0, 10, length = 30)    #number of elements
length(my_seq)                       #size of sequence
1:length(my_seq)                     #create another sequence 
seq(along = my_seq)                  #create a sequence along a vector
seq_along(my_seq)                    #create a sequence along a vector
seq_len(4)

#rep() function
rep(0,times = 40)                    #repeat 0 forthy times and request for mod
rep(c(1,2,3), times = 10)            #replicate the vector 10 times
rep(c(0,1,2), each = 10)             #replociate each element 10 times





####### CONTROL STRUCTURES #######

#allow you to control the flow of the R program
#mostly not used during an interactive session, but rather when writing a function

#if, else    # testing condition
#for         # execute a loop a fixed number of times
#while       # execute a loo while a condition is true
#repeat      # execute an infinite loop
#break       # break the execution of a loop
#next        # skip an interation of a loop
#return      # exit a function

## IF - ELSE

# structure
if (<condition>) {
  ## do sth
} else if (<condition>) {
  ## do sth different
} else {
  ## do sth different
}

# method 1
if (x > 3) {
  y <- 10
} else {
  y <- 0
}

# method 2
y <- if (x > 3) {
  10
} else {
  0
}

## FOR LOOP

# structure
for (i in 1:10) {
  print(i)
}

#equivalent looping 
x <- c("a", "b", "c","d")
# example 1
for(i in 1:4) {
  print(x[i])
}
# example 2
for(i in seq_along(x)) {
  print(x[i])
}
# example 3
for(letter in x) {
  print(letter)
}
# example 4
for(i in 1:4) print(x[i])

# Nesting Loops

x <- matrix(1:6, 2, 3)
x
for (i in seq_len(nrow(x))) {
  for (j in seq_len(ncol(x))) {
    print(x[i,j])
  }
}

## WHILE LOOP

# structure
count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}

# harder to predict when the loop will finish compared to for loop
z <- 5
while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1, 1, 0.5)
  
  if(coin == 1) { ##random walk
    z <- z + 1
  } else {
    z <- z - 1
  }
}

### REPEAT - infinite loop

# the only way to exit a repeat loop is to call break

x0 <- 1
x1 <- 1e-8 # tolerance

repeat {
  
  x1 <- computeEstimate() # imaginary function that computes an estimate
  
  if(abs(x1 - x0) < tol) {
    break
  } else {
    x0 <- x1
  }
  
}

## NEXT and RETURN

# next is used to skip an iteration of a loop

for (i in 1:100) {
  if (i <= 20) {
    next 
  }
  print(i)
}

# return signals that a function should exit and return a value





####### FUNCTIONS #######

f <- function(<argument>) {
  ## do somethings
}

# functions are first class objects
# functions can be passes as arguments to other functions
# functions can be nested

## Function arguments

# functions have named arguments which potentially have default values
# The "formal arguments" are the arguments included in the function definition
# The "formals" function returns a list of all the fornmal arguments of a function
# Not every function call in R makes use of all the formal arguments
# Function arguments can be missing or might have default values

## Argument matching

# arguments can be matched positionally or by names

#following calls are equivalent
mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)

# when an argument is matched by name, it is "taken out" of the argument list and the remaining
 # unnamed arguments are matched in the order that the are listed in the function

args(lm)

#following calls are equivalent

lm(data = mydata, y ~ x, model = FALSE, 1:100)
lm(y ~ x, mydata, 1:100, model = FALSE)

# Order of operations when given an argument is
# 1. Check for exact match for a named argument
# 2. Check for a partial match
# 3. Check for a positional match

# Defining a function

f <- function(a, b = 1, c = 2, d = NULL) {
 print(a)
 print(b)
 print(c)
 print(d)
}
f(1)
f(1,3)
f(2,333, 666, "a")

# The "..." Argument

# The ... argument indicates a variable number of arguments that are usually passed on
 # the other functions

# ... is used when extending another function and you don't want to copy the entire argument list
 # of the orginal function

myplot <- function(x, y, type = "l", ...) {
  plot(x,y, type = type, ...)
}

# Generic functions use ...
mean

# The ... argument is also necessary when the number of arguments passed to the function 
 # cannot be know in advance

args(paste)
args(cat)

# arguments that appear after ... on the argument list must be named explicitly and cannot be
# partially matched

args(paste)
paste("a", "b", sep = ":")
paste("a", "b", s = ":")

### EXAMPLE FUNCTIONS

add2 <- function(x,y) {
  x + y
}
add2(1,3)

above10 <- function(x) {
  use <- x >10
  x[use]
}
above10(1:100)

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}
above(1:20)
above(1:20, 5)

columnmean <- function(y, removeNA = TRUE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc) {
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means
}
columnmean(airquality)


####### CODING STANDARDS #######

# 1. Use text editor
# 2. Indent your code
# 3. Limit the width of your code to ~80
# 4. Limit the length of your functions


####### SCOPING RULES #######

#How does R know which value to assign to which symbol? 

# there is a default function lm - linear modeling- in R
# if we create a new function called lm
lm<- function(x) { x * x }
lm
# how does R know what values to assign to the symbol lm?

#There are ENVIRONEMNTS - lists of symbols, objects and values

# 1. Search the global environemnt for a symbol 
# 2. Searc the namespaces of each of the packages on the search list

search()

# The global environment or the user's workspace is always the first element 
 # of the search list
# Base package is always the last element of the search list
# The order of packages on the search list matters
# User can configure which packages get loaded on startup
# When a user loads a package with library, the namespace of that package gets
  # put in position 2 of the search list (by default)
# R has separate namespaces for functions and non-functions, so its is possible
  # to have an object named c and a function named c

# Scoping Rules
# Scoping rules determine how a value is associated with a free variable in a function
# R uses lexical scoping or static scoping. A common alternative is dynamic scoping
# Related to the scoping rules is how  uses the search list to bind a value to a symbol
# Lexical scoping turns out to be particularly useful for simplifying stat computations

f <- function (x, y) {
    x ^ 2 + y / z
}

# where does free variable "z" comes from

# Lexical Scoping

# means that the values of free variables are searched for in the environment 
 # in which the function was defined

# What is an environment?
    # a collection of (symbol, value) pairs, i.e. x is a symbol and 3.14 might be its value
    # Every environment has a parent environment; it is possible for an environment to have multiple
        #children
    # the only environment without a parent is the empty environment
    # a function + an environment = a closure or function closure

# Searching for the value for a free variable:
    # If you are a function and if you have a free variable. What is the value of it?
    # If the value of a symbol is not found in the environment in which a function 
        # was defined, then the search is continued in the parent environment
    # The search continues down the sequence of parent environments until we hit
        # the top level environment; this usually is the global environment (workspace)
        # or the namespaces of a package
    # After a top-level environment, the search continues down the searcgh list until
        # we his the empty environment. If the value for a given symbol cannot be found
        # once the empty environment is arrived at, then an error is thrown

# Why is lexical scoping is important?
    # Typically, a function is defined in the global environment, so that the values
        #of free variables are just found in the user's workspace
    # This behaviour is logical for most people and is usually the right thing to do
    # However, in R you can have functions defined inside other functions
        # Languages like C don't let you do that
    # Now things get interesting - In this case the environment in which the function
        # is defined is the body of another function

make.power <- function(n) {
    pow <- function(x) {
        x ^ n
    }
    pow # make.power returns the pow function
}

cube <- make.power(3) # make.power returns the pow function, so cube is assigned to pow
square <- make.power(2)
cube(5)
square(6)

# What is in  function's environment?
ls(environment(cube))
get("n", environment(cube))

ls(environment(square))
get("n", environment(square))
get("pow", environment(cube))

# Lexical vs. Dynamic Scoping
y <- 10
f <- function(x) {
    y <- 2
    y ^ 2 + g(x)
}
g <- function(x) {
    x * y
}

f(3)

ls(environment(f))
get("y", environment(f))
ls(environment(g))
get("y", environment(g))

# Lexical scoping: the value of y in the function g is looked up in the environment
    # in which the function was defined. In this case the global environment: y = 10
# Dynamic scoping: the value of y is looked up in the envrionment from which the
    # the function was called
    # in R the calling environment is known as the parent frame
    # so the value of y would be 2


# Consequences of Lexical Scoping
    # In R, all objects must be stored in the memory
    # All function must carry a pointer to their respective defining envrionment
    # in S-PLUS, free-variables are always looked up in the workspace
        #so everthing can be stored on the disk

# Whay any of this information is useful?
    # Optimization routines in R like optim, nlm, and optimize require you to
        #pass a function whose argument is a vector of paramaters (a log likelihood)
    # Howeverm an object function might depend on a host of other things
        #besides its parameters (like data)
    # When writing software which does optimziation, it may be desirable to
        #allow the user to hold certain parameters fixed

# Maximizing a Normal Likelihood

make.NegLogLik <- function(data, fixed = c(FALSE, FALSE)) {
    params <- fixed
    function(p) {
        params[!fixed] <- p
        mu <-params[1]
        sigma <- params[2]
        a <- -0.5 * length(data) * log(2 * pi * sigma ^ 2)
        b <- -0.5 * sum((data-mu) ^ 2 ) / (sigma ^ 2)
        -(a + b) #optimization functions in R minimize functions, so you need to use negative log-likelihood
    }
}

set.seed(1)
normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
nLL
ls(environment(nLL))

optim(c(mu = 0, sigma = 1), nLL)$par
#Fixing sigma to 2
nLL <- make.NegLogLik(normals, c(FALSE,2))
optimize(nLL, c(-1, 3))$minimum
#Fixing mu to 1
nLL <- make.NegLogLik(normals, c(1,FALSE))
optimize(nLL, c(1e-6, 10))$minimum

nLL <- make.NegLogLike(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")

nLL <- make.NegLogLike(normals, c(FALSE, 2))
x <- seq(0.5, 1.5, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")





####### VECTORIZED OPERATIONS #######

x <- 1:4; y <- 6:9

x + y 
x > 2 
x >= 2
y == 8
x * y
x / y

x <- matrix(1:4, 2, 2); y <- matrix(rep(10,4), 2, 2)
x * y     # Element-wise multiplication
x / y     
x %*% y   # True matrix multiplication



####### DATES and TIMES #######

# Dates are represented by Date class
# Times are represented by the POSIXct or the POSIXlt class
# Dates are stored internally as the number of days since 1970-01-01
# Time are stored internally as the number of seconds since 1970-01-01

x <- as.Date("1970-01-01")
x
unclass(x)
unclass(as.Date("1970-01-02"))
unclass(as.Date("2014-09-06"))

# POSIXct is just very large integer under the hood; it use a useful class
    #when you want to store times in something like a data frame
# POSIXlt is a list underneath and it stores a bunch of other useful information
    #like the day of the week, day of the year, month, day of the month

# There are generic functios that work on dates and times
    weekdays # give the day of the week
    months   # give the month name
    quarters # give the quater number

x <- Sys.time()
x #already in POSIXct format
x$sec #not defined
p <- as.POSIXlt(x)
p
names(unclass(p))
p$sec
p$gmtoff

# STRPTIME function

datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)

x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
y
x - y
x <- as.POSIXlt(x)
x-y

# Keeps track of leap years, leap seconds, daylight savings, and time zones

x <- as.Date("2012-03-01"); y <- as.Date("2012-02-28")
x-y
x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT")
y-x




####### LOOP FUNCTIONS #######

lapply   # loops over a list and evaluates a function on each element
sapply   # same as lapply but try to simplify the result
apply    # apply function over the margins of an array
tapply   # apply a function over subsets of a vector
mapply   # multivariate version of lapply

split    # auxiliary function which is helpful in conjunction with lapply

###### lapply

#takes 3 arguments:1-a list, 2-a function, 3-other arguments via ...
lapply
# actually looping is done internally in C code
# always returns a list

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- 1:4
lapply(x, runif)
?runif # generates uniform random variables, the first argument is n: how many 
    #uniform random variables to generate

x <- 1:4
lapply(x, runif, min = 0, max = 10)

# lapply can use anonymous functions
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
# get the first column of matrices using an anonymous functions
lapply(x, function(elt) elt[,1])

###### sapply

# similar to lapply, but the output is simplified 
# if the result is a list where every element is length 1, then a vector is returned
# if the result is a list where every element is a vector of the same length, a matrix is returned
# if it cannot figure things out, a list is returned

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1))
x
lapply(x, mean)
sapply(x, mean)



###### apply

# evaluates the function over the margins of an array
# mostly used to a function to the rows or columns of a matrix
# it can be used with general arrays, taking the average of an array of matrices
# it is not really faster than for loops, but it is shorter

str(apply)
#x is an array
#margin is an integer vector indicating which margins should be retained
#fun is a function to be applies
#... is for other arguments

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) #dimension 2, means of all columns, collapse rows
apply(x, 1, mean) #dimension 1, means of all rows, collapse columns

rowSums = apply(x, 1, sum)
rowMeans = apply(x, 1, mean)
colSums = apply(x, 2, sum)
colMeans = apply(x, 2, mean)
rowSums(x)

# use ... argument of apply to define which quantiles to use
apply(x, 1, quantile, probs = c(0.25, 0.75))

# average matrix in an array
a <- array(rnorm(2 * 2 * 10), c(2,2,10)) #2 rows, 2 columns, 3rd dim is 10
a
apply(a, c(1,2), mean) # preserve 1st and 2nd dimensions
rowMeans(a, dim = 2)


###### tapply

# is used to apply a function over subset of a vector. 
str(tapply)
# X is a vector
# INDEX is a factor or list of factors
# FUN is a function to be applies
# ... other arguments
# simplify > should we simplify the results

x <- c(rnorm(10), runif(10), rnorm(10,1))
x
f <- gl(3, 10)
f # 3 levels, 10 reps
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)
tapply(x, f, range)


###### split

# takes a vector or other objects and splits into groups determined 
    #by a factor or list of factors
str(split)
# X is a vector or list or data frame
# f is a factor (or coerced to one) or a list of factors
# drop indicates whether empty factors levels should be dropped
# returns a list back

x <- c(rnorm(10), runif(10), rnorm(10,1))
x
f <- gl(3, 10)
f # 3 levels, 10 reps
split(x, f)
lapply(split(x, f), mean)

library(datasets)
head(airquality)
s <- split(airquality, airquality$Month)
s
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R")], na.rm = TRUE))

# Splitting on More than One Level
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1
f2
interaction(f1, f2)
?interaction

#interactions can create empty levels
str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop = TRUE))


###### mapply

# is a multivariate apply of sorts which applies a function in parallel over a set of arguments

str(mapply)
# FUN is a function to apply
# ... arguments to apply over
# MoreArgs is a list of arguments to FUN
# SIMPLIFY indicates whether the result should be simplified

list (rep(1,4), rep(2,3), rep(3,2), rep(4,1))
mapply(rep, 1:4, 4:1) # repeat takes 2 arguments

noise <- function(n, mean, sd) {
    rnorm(n, mean, sd)
}

noise(5, 1, 2)
noise(1:5, 1:5, 2) # doesn't really work
mapply(noise, 1:5, 1:5, 2) # keep the sd same
#manual equivalent
list(noise(1,1,2), noise(2,2,2), noise(3,3,2), noise(4,4,2), noise(5,5,2))






####### DEBUGGING #######

# message: a generic notification/diagnostic message produced by the message function
    #execution will continue
# warning: an indication that something is wrong but not necessarily fatal.
    #execution will continue, generated by warning function
    # you get a message when the execution ends
# error: an indication for a fatal problem
    #execution stops
    # generated by stop function
# condition: a egeneric concept for indicating that something unexpected can occcur
    # programmers can create their own conditions

log(-1)

printmessage <- function(x) {
    if (x > 0 ) 
        print("x is greater than zero")
    else
        print("x is smaller than or equal to zero")
    x
    invisible(x)
}
printmessage(100)
printmessage(-100)
? invisible # prevents autoprinting

printmessage(NA)

printmessage2 <- function(x) {
    if(is.na(x))
        print("x is a missing value")
    else if (x > 0 ) 
        print("x is greater than zero")
    else
        print("x is smaller than or equal to zero")
    x
    invisible(x)
}
x <- log(-1)
printmessage2(x)

## DEBUGGING TOOLS IN R

traceback    # prints out the function call stack after an error occurs
debug        # flags a function for debug mode which allows you to step through execution of a function one line at a time
browser      # suspects the execution of a function whenever it is called and puts the function in debug mode
trace        # allows you to insert debuggng code into a function a specific places
recover      # allows you to modify the error behaviour so that you can browse 

# traceback
mean(x)
traceback() # execute immediately after the error happens

lm(y ~x)
traceback()

# debug
debug(lm)
lm(y~x)
# write "n" and enter to go to the next line

#recover
options(error = recover)
read.csv("nosuchfile")
# you can see the level of occurance and go back and forth



####### STR FUNCTION #######

# compactly display the internal structure of an R object
# a diagnostic function and an alternative to "summary"
# useful in compatly displaying contents of nested lists
# roughlt one line per basic object

str(str)
str(lm)
str(ls)

x <- rnorm(100, 2, 4)
summary(x)
str(x)

f <- gl(40, 10) # 40 level factor , 10 repetition
str(f)
summary(f)

library(datasets)
head(airquality)
str(airquality)

m <- matrix(rnorm(100), 10, 10)
str(m)
m[, 1]

s <- split(airquality, airquality$Month)
str(s)




####### SIMULATION #######

# Functions for probablity distributions in R
# rnorm : generates random Normal variates with a given mean and sd
# dnorm : evaluates the Normal prob density (with a given mean/SD) at a point (or vector of points)
# pnorm : evaulate the cumulative distribution for a Normal distribution
# rpois : generate random Poisson variates with a given rate

# d - density
# r - random number generation
# p - cumulative distribution
# q - for quantile function

dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)

x <- rnorm(10)
x
x <- rnorm(10, 20, 2)
x
summary(x)

# setting the seed to ensure reproducibility
set.seed(1)
rnorm(5)
rnorm(5)
set.seed(1)
rnorm(5)

# Poisson data
rpois(10, 1) #10 Poisson random variables with rate 1
rpois(10, 2)
rpois(10, 20)
ppois(2,2) ## cumilative distribution
ppois(4,2) ## what is the porbability that the Poisson variable is less than
            ## or equal to 4 when the rate is 2
ppois(6,2)


### GENERATE RANDOM NUMBERS FROM A LINEAR MODEL

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)


# what if x is binary?

set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x, y)

# simulate from Poisson model
# suppose you have count values

set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 * 0.3 *x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)

# RANDOM SAMPLES

set.seed(1)
sample(1:10, 4)
sample(1:10, 4)
sample(letters, 5)
sample(1:10) #permutation
sample(1:10)
sample(1:10, replace = TRUE) # sample with replacement




####### PROFILING #######

# Using system.time()
# gives the time in seconds
# time until the error in case there is an error
# return an object of class "proc_time"


# user time: time charged to the CPU(s) for this expression
            # computer experiences
# elapsed time: "wall clock time"
            # you experience

# usually user time and elapsed time are similar
# if CPU spends a lot of time waiting, elapsed time may be greater
# if your machine has multiple cores/processes elapsed time may be smaller

# Multi-threaded BLAS libraries (vecLib/Accelerate, ATLAS, ACML, MKL)
# Parallel processing via the parallel package

## Elapsed time > user time
system.time(readLines("http://www.jhsph.edu"))
# waiting for the network is nor counted in CPU time

## Elapsed time < user time
hilbert <- function(n) {
    i <- 1:n
    1 / outer(i - 1, i, "+")
}
x <- hilbert(1000)
system.time(svd(x)) #singular value decomposition


#Rprof()

summaryRProf() #function summarizes the output from RProf()
#don't use the system.time() and Rprof() together

#Rprof() keeps track the function call stack at regularly sampled intervals
    # tabulates how much time is spend in each functin
#Default sampling interval is 0.02 seconds

lm(y ~x)
sample.interval = 10000

# summaryRprof() 
    # 2 methods
    # by.total > divides the time spend in each finction by the total run time
    # by.self >  does the same but first subtracts out time spent in functions
            # above in the call stack
    # sample.interval
    # sampling.time
    # C or Fortran code is not profiled
