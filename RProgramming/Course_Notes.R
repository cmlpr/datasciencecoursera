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











