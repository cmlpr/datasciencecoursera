# Programming Assignment 2: Lexical Scoping
# Introduction
# This second programming assignment will require you to write an R function is 
# able to cache potentially time-consuming computations. For example, taking 
# the mean of a numeric vector is typically a fast operation. However, for 
# a very long vector, it may take too long to compute the mean, especially 
# if it has to be computed repeatedly (e.g. in a loop). If the contents of 
# a vector are not changing, it may make sense to cache the value of the mean 
# so that when we need it again, it can be looked up in the cache rather than 
# recomputed. In this Programming Assignment will take advantage of the scoping 
# rules of the R language and how they can be manipulated to preserve state 
# inside of an R object.

getwd()
# set the working directpory to github repo
setwd("~/Documents/Repos/datasciencecoursera/RProgramming")
#check the content of the folder
dir()

# Example: Caching the Mean of a Vector

# In this example we introduce the <<- operator which can be used to assign 
# a value to an object in an environment that is different from the current 
# environment. Below are two functions that are used to create a special 
# object that stores a numeric vector and cache's its mean.

# The first function, makeVector creates a special "vector", which is 
# really a list containing a function to
# set the value of the vector
# get the value of the vector
# set the value of the mean
# get the value of the mean


makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

# The following function calculates the mean of the special "vector" created 
# with the above function. However, it first checks to see if the mean has 
# already been calculated. If so, it gets the mean from the cache and skips 
# the computation. Otherwise, it calculates the mean of the data and sets the 
# value of the mean in the cache via the setmean function.

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}

a <- makeVector(1:20)
a$get()
a$getmean()
system.time(cachemean(a))
a$get()
a$getmean()


# Caching the Inverse of a Matrix
# The overall goal of the below work is to make the process of getting the
# inverse of a function faster. It is fairly easy to get the inverse of a function
# in R. In a certain study we might be needing to update a matrix and calculate
# its inverse many times. The function we are generating here will look at the 
# environment and find the inverse if it is already calculated and in turn saves
# us some time.

# The first function, makeCacheMatrix creates a special "matrix", which is 
# really a list containing a function to
# set the value of the matrix
# get the value of the matrix
# set the value of the inverse
# get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL #inverse of the matrix
    set <- function(y) { # This part sets the function
        x <<- y
        inv <<- NULL
    }
    get <- function() x # to get the matrix
    setInv <- function(solve) inv <<- solve # To set the inverse of the matrix
    getInv <- function() inv # to get the calculated inverse
    list(set = set, get = get, setInv = setInv, getInv = getInv) # a special list containing all the sub-functions
}


# The following function calculates the inverse of the special "matrix" created 
# with the above function. However, it first checks to see if the inverse has 
# already been calculated. If so, it gets the inverse from the cache and skips 
# the computation. Otherwise, it calculates the inverse of the data and sets the 
# value of the inverse in the cache via the setInv function.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv <- x$getInv() # first get the inverse
    if(!is.null(inv)) { # if the inverse is not Null then return it
        message("getting cached inverse")
        return(inv)
    }
    data <- x$get() # if the inverse is Null then let's get the matrix 
    inv <- solve(data, ...) # and pass the matrix to calculation
    x$setInv(inv) # assign the calculated value to the inverse
    inv # auto - print the result
}

mat <- matrix(rnorm(1000000), 1000, 1000)
system.time(solve(mat))
mm <- makeCacheMatrix(mat)
mm$get()
mm$getInv()
system.time(cacheSolve(mm))
mm$get()
mm$getInv()
