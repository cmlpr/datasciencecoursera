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

####### INSTALLING PACKAGES #######
