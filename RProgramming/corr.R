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