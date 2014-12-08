# Coursera
# Date Science Specialization - Exploratory Data Analysis
# Week 3 - Project 2 - Plot 4

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

names(SCC) # See the names in the SCC data frame
head(SCC) # Get an idea of the data
unique(SCC$EI.Sector) # EI Sector includes the source sector

# Now let's search the word "coal" (case insensitive) in the EI.Sector column 
# and get a subset of the SCC data frame with the result
# To do that we will use subset and grepl functions
# grepl function returns logical value which in turn will be used in subset function
coal <- subset(SCC, grepl("coal", EI.Sector, ignore.case=TRUE), select=c(SCC, EI.Sector))

# Now we have the necessary scc codes in coal data frame
# We can merge the NEI and caol data frames by using matching column names
# Merge function is useful for this
?merge
NEI4 <- merge(NEI, coal) # This implementation will only keep the matching rows
str(NEI4) # Let's look at the data

# We need to get the total emission for each year
# This process is very easy if one prefers to use Hadley Whickam's plyr package
# If you don't have the package, install and call it
install.packages("plyr")
library(plyr)

# The first argument is the data frame NEI
# The second argument is a vector of categories: I want only year
# The third argument is a function: I want sum of emission data
data <- ddply(NEI4, c("year"), function(x) sum(x[ , 4]))
data #look at the data

# Change the column names
colnames(data) <- c("Year", "TotalEmission")  

# It is time to plot it to a png file
library(ggplot2) # Call ggplot2 which is a requirement
png(file = "plot4.png", width = 480, height = 480, units = "px")
p <- ggplot(data, aes(Year, TotalEmission)) + geom_line()
p + labs(title = "Emissions from Coal Comb-Rltd Src Across US")
dev.off() #close the device
