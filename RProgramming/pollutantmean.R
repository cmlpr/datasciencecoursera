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