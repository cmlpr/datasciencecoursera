#Programming Assignment 1: Air Pollution
#get current working directory
getwd()
# set the working directpory to github repo
setwd("~/GitHub/datasciencecoursera/RProgramming")
#check the content of the folder
dir()

# Downloaded file is located in Data folder, check the content
dir("Data/")
# If the file is not extracted, run this code to extract it
unzip("Data/rprog_data_specdata.zip", exdir = "Data")
# Now check if the extraction was successful
dir("Data/")
# Extracted file is in specdata
dir('Data/specdata')

install.packages("stringr", dependencies = TRUE)
require(stringr)

### Part 1

pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    x <- as.numeric()
    for (i in id) {
        fileID <- str_pad(as.character(i), width=3, side="left", pad="0")
        filePath <- paste("Data/", directory, "/", fileID, ".csv", sep = "")
        data <- read.csv(filePath)
        x <- c(x, data[complete.cases(data[,pollutant]),pollutant])
    }
    print(mean(x))
}

pollutantmean("specdata", "sulfate", 1:10)
## [1] 4.064
pollutantmean("specdata", "nitrate", 70:72)
## [1] 1.706
pollutantmean("specdata", "nitrate", 23)
## [1] 1.281

complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    x <- matrix(0, nrow = 0, ncol = 2)
    colnames(x) <- c("id", "nobs")
    for (i in id) {
        fileID <- str_pad(as.character(i), width=3, side="left", pad="0")
        filePath <- paste("Data/", directory, "/", fileID, ".csv", sep = "")
        data <- read.csv(filePath)
        x <- rbind(x, matrix(c(i, nrow(data[complete.cases(data),])), nrow = 1, ncol = 2))
    }
    print(as.data.frame(x))
}

complete("specdata", 1)
##   id nobs
## 1  1  117
complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96
complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463
complete("specdata", 3)
##   id nobs
## 1  3  243

corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    len <- length(list.files(paste("Data/", directory, sep = "")))
    x <- c()
    
    for (i in 1:len) {        
        fileID <- str_pad(as.character(i), width=3, side="left", pad="0")
        filePath <- paste("Data/", directory, "/", fileID, ".csv", sep = "")
        data <- read.csv(filePath)
        data
        data <- data[complete.cases(data),]
        nrow(data)
        if (nrow(data) >= threshold) {
            x <- c(x, cor(data$sulfate, data$nitrate))
        }
    }
    x
}

cr <- corr("specdata", 150)
head(cr)
## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630
cr <- corr("specdata", 400)
head(cr)
## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630
cr <- corr("specdata", 5000)
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## 
length(cr)
## [1] 0
cr <- corr("specdata")
summary(cr)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
length(cr)
## [1] 323


###############################################################################
## Submit 
source("rprog_scripts_submitscript1.R")
source("pollutant mean")
submit()
