#Programming Assignment 3: Hospital Quality: Instructions
#get current working directory
getwd()
# set the working directpory to github repo
setwd("~/Documents/Repos/datasciencecoursera/RProgramming")
#check the content of the folder
dir()

# Downloaded file is located in Data folder, check the content
dir("Data/")
# If the file is not extracted, run this code to extract it
unzip("Data/ProgAssignment3-data.zip", exdir = "Data")
# Now check if the extraction was successful
dir("Data/")

### Part 1
outcome <- read.csv("Data/outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
nrow(outcome)
dim(outcome)
names(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[,11])

### Part 2

best <- function(state, outcome) {
    ## Read outcome data
    ## Check that state and outcome are valid 
    ## Return hospital name in that state with lowest 30-day death rate
    
    data <- read.csv("Data/outcome-of-care-measures.csv", colClasses = "character")
    states <- unique(data$State)
    #outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    if (state %in% states) {
        if (outcome == "heart attack") {
            columnNo <- 11
        } else if (outcome == "heart failure") {
            columnNo <- 17
        } else if (outcome == "pneumonia") {
            columnNo <- 23
        } else {
            stop("invalid outcome")
        }
        data2 <- data[which(data$State == state), c(2,columnNo)]
        data2[,2] <- as.numeric(data2[, 2])
        data2 <- data2[complete.cases(data2),]
        #data2 <- data2[with(data2, order(2,1)),]
        data2 <- data2[order(data2[,2], data2[,1]),]
        data2[1,1]
    } else {
        stop("invalid state")
        #print(paste("Error in best(", state, ", ", outcome, ",) : invalid state", sep = ""))
    }
}

best("TX", "heart attack")
## [1] "CYPRESS FAIRBANKS MEDICAL CENTER"
best("TX", "heart failure")
## [1] "FORT DUNCAN MEDICAL CENTER"
best("MD", "heart attack")
## [1] "JOHNS HOPKINS HOSPITAL, THE"
best("MD", "pneumonia")
## [1] "GREATER BALTIMORE MEDICAL CENTER"
best("BB", "heart attack")
## Error in best("BB", "heart attack") : invalid state
best("NY", "hert attack")
## Error in best("NY", "hert attack") : invalid outcome

### Part 2

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid 
    ## Return hospital name in that state with lowest 30-day death rate
    
    data <- read.csv("Data/outcome-of-care-measures.csv", colClasses = "character")
    states <- unique(data$State)
    #outcomes <- c("heart attack", "heart failure", "pneumonia")
    
    if (state %in% states) {
        if (outcome == "heart attack") {
            columnNo <- 11
        } else if (outcome == "heart failure") {
            columnNo <- 17
        } else if (outcome == "pneumonia") {
            columnNo <- 23
        } else {
            stop("invalid outcome")
        }
        data2 <- data[which(data$State == state), c(2,columnNo)]
        data2[,2] <- as.numeric(data2[, 2])
        data2 <- data2[complete.cases(data2),]
        #data2 <- data2[with(data2, order(2,1)),]
        data2 <- data2[order(data2[,2], data2[,1]),]
        if (num == "best") {
            data2[1,1]
        } else if (num == "worst") {
            data2[nrow(data2), 1]
        } else if (num <= nrow(data2)) {
            data2[num, 1]
        } else {
            NA
        }
    } else {
        stop("invalid state")
        #print(paste("Error in best(", state, ", ", outcome, ",) : invalid state", sep = ""))
    }
}

rankhospital("TX", "heart failure", 4)
## [1] "DETAR HOSPITAL NAVARRO"
rankhospital("MD", "heart attack", "worst")
## [1] "HARFORD MEMORIAL HOSPITAL"
rankhospital("MN", "heart attack", 5000)
## [1] NA
rankhospital("WA", "heart attack", 7)

## Part 3

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    data <- read.csv("Data/outcome-of-care-measures.csv", colClasses = "character")
    states <- unique(data[,7, drop = F])
    rownames(states) <- states[,1]
    states <- states[order(states[,1]),, drop = FALSE]
    states$hospital <- NA
    colnames(states)[1] <- "state"
    states <- states[, order(names(states))]
    for (state in states$state) {
        if (outcome == "heart attack") {
            columnNo <- 11
        } else if (outcome == "heart failure") {
            columnNo <- 17
        } else if (outcome == "pneumonia") {
            columnNo <- 23
        } else {
            stop("invalid outcome")
        }
        data2 <- data[which(data$State == state), c(2,columnNo)]
        data2[,2] <- as.numeric(data2[, 2])
        data2 <- data2[complete.cases(data2),]
        #data2 <- data2[with(data2, order(2,1)),]
        data2 <- data2[order(data2[,2], data2[,1]),]
        if (num == "best") {
            states[which(states$state == state), 1] <- data2[1,1]
        } else if (num == "worst") {
            states[which(states$state == state), 1] <- data2[nrow(data2), 1]
        } else if (num <= nrow(data2)) {
            states[which(states$state == state), 1] <- data2[num, 1]
        } else {
            states[which(states$state == state), 1] <- NA
        }
    }
    states
}

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

###############################################################################
## Submit 
source("submitscript3.R")
source("best.R")
source("rankhospital.R")
source("rankall.R")
submit()



