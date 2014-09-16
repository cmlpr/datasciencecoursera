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