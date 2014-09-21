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