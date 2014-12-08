# Coursera
# Date Science Specialization - Exploratory Data Analysis
# Week 3 - Project 2 - Plot 3

# first make sure that you are in the correct folder
# you need to be able to see R codes in the working directory
# Also there is a subfolder named "Data"
dir()
# See the content of the Data folder
dir("Data/")
# If the file is not extracted, run this code to extract it
unzip("Data/household_power_consumption.zip", exdir = "Data/")
# Now check if the extraction was successful
dir("Data/")

# Now that we have the RDS files in the Data folder, we can read them with
# RDS reader
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

head(NEI) # See the first 5 rows in the main file
str(NEI)  # Check the structure of the main file
names(NEI) # Check the names of the columns

# We need to get the total emission for each type and year
# This process is very easy if one prefers to use Hadley Whickam's plyr package
# If you don't have the package, install and call it
install.packages("plyr")
library(plyr)

# The first argument is the data frame NEI
# The second argument is a vector of categories: I want year and type
# The third argument is a function: I want sum of emission data only for Baltimore
    # Baltimore's fips number is 24510
data <- ddply(NEI, c("type", "year"), function(x) sum(x[which(x$fips == "24510"),4]))
data #look at the data

# Change the column names
colnames(data) <- c("Type", "Year", "TotalEmission")  

# It is time to plot it to a png file
library(ggplot2) # Call ggplot2 which is a requirement
png(file = "plot3.png", width = 480, height = 480, units = "px")
p <- ggplot(data, aes(Year, TotalEmission, colour = factor(Type))) + geom_line()
p + labs(title = "Total Emissions in Baltiomore for each Type")
p + facet_grid(Type ~ .)
dev.off() #close the device
