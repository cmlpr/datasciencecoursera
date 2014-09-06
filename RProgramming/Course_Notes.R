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




















