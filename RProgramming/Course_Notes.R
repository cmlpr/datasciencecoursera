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
dir()

# Write a function in a text editor and save it to your current working dir
# To call that function, use
source("xxx.R")

####### DATA TYPES IN R #######

# 5 basic classes of objects
# character
# numeric
# integer
# complex
# logical

# Vector: A basic object which contains objetcs of the same class
# List is an exception which can contain objects of the different classes
# Created with vector()

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
# attributes() is used to access 

x <- 1
x        # prints
print(x) # prints
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
x <- 1:20
x

# Creating vectors
x <- c(1,2)            #numeric
x <- c(TRUE, FALSE)    #logical
x <- c(T, F)           #logical
x <- c("a", "b", "c")  #character
x <- 9:29              #integer
x <- c(1+0i, 2+4i)     #complex

x <- vector("numeric", length = 10)
x

# Mixing objects
# Coercion occurs based on least common denominator
x <- c(1.7, "a")       #character
x <- c(TRUE, 2)        #numeric
x <- c("a", TRUE)      #character

