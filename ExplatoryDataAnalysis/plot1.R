# Coursera
# Date Science Specialization - Exploratory Data Analysis
# Week 3 - Project 2 - Plot 1

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

# Since we are asked to have years in x axis, we need to get the unique values
years <- unique(NEI$year) 

# I would like to use sapply to apply a function to get the sum of a column for 
# different list (i.e. years). However my data has only one list. 
# In this case split is handy. I can split the main data frame into 4 lists
NEI2 <- split(NEI, NEI$year) #split it
str(NEI2) # look at the structure

# Now I can get the emission sum for each years by using sapply
eSum <- sapply(NEI2, function(x) sum(x[,4])) 
eSum # This will show the result

# It is time to plot it to a png file
png(file = "plot1.png", width = 480, height = 480, units = "px")
plot(years, eSum, type = "l", xlab = "Years", ylab = "Total Emission", main = "Total Emission in Years")
dev.off() #close the device