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