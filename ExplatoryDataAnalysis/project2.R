# Project 2
# PM25 Emission Data
# Plotting

getwd()
setwd("/Users/cemalperozen/Documents/Repos/datasciencecoursera/ExplatoryDataAnalysis")
dir()
dir("Data/")
unzip("Data/NEI_data.zip", exdir = "Data/")
dir("Data/")

#PM2.5 Emissions Data (summarySCC_PM25.rds): 
#This file contains a data frame with all of the PM2.5 emissions data 
#for 1999, 2002, 2005, and 2008. For each year, the table contains number of 
#tons of PM2.5 emitted from a specific type of source for the entire year. 
#Here are the first few rows.

##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999

# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code 
    # classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded

# Source Classification Code Table (Source_Classification_Code.rds): 
# This table provides a mapping from the SCC digit strings in the Emissions table 
# to the actual name of the PM2.5 source. The sources are categorized in a few 
# different ways from more general to more specific and you may choose to explore 
# whatever categories you think are most useful. For example, source “10100101” 
# is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

# You can read each of the two files using the readRDS() function in R. 
# For example, reading in each file can be done with the following code:
    
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

head(NEI)
str(NEI)
head(SCC)
table(SCC)

#### Question 1

names(NEI)
years <- unique(NEI$year)

NEI2 <- split(NEI, NEI$year)
str(NEI2)
apply(NEI2, 4, sum)

eSum <- sapply(NEI2, function(x) sum(x[,4]))
plot(years, eSum, xlab = "Years", ylab = "Total Emission", main = "Total Emission in Years")




#### Question 2

head(NEI2[[1]][which(NEI2[[1]]$fips == "24510"), 1:4, drop = FALSE])
eSumBalt <- sapply(NEI2, function(x) sum(x[which(x$fips == "24510"),4]))
plot(years, eSumBalt, xlab = "Years", ylab = "Total Emission in Baltimore",  main = "Total Emission in Baltimore in Years")




#### Question 3

install.packages("plyr")
library(plyr)
library(ggplot2)
data <- ddply(NEI, c("type", "year"), function(x) sum(x[which(x$fips == "24510"),4]))
data
colnames(data) <- c("Type", "Year", "TotalEmission")  
qplot(Year, TotalEmission, data = data, facets = . ~ Type, main = "Total Emissions in Baltiomore with Time for Each Type")


#### Question 4

names(SCC)
head(SCC)
unique(SCC$EI.Sector)
unique(SCC$Short.Name)
sectors <- unique(grep("coal", SCC$EI.Sector, ignore.case=TRUE, value = TRUE))
sccsubset <- subset(SCC, grepl("coal", EI.Sector, ignore.case=TRUE), select=c(SCC, EI.Sector))
sccsubset
sccCode <- unique(as.character(SCC[which(SCC$EI.Sector %in% sectors), 1]))
sccCode

NEI4 <- merge(NEI, sccsubset)
str(NEI4)
levels(NEI4$EI.Sector)
unique(NEI4$SCC)
summary(NEI4)

data <- ddply(NEI4, c("year"), function(x) sum(x[ ,4]))
data
colnames(data) <- c("Year", "TotalEmission")  
qplot(Year, TotalEmission, data = data, main = "Total Emissions from Coal Cumbustion-Related Sources Across US")

data <- ddply(NEI4, c("year", "EI.Sector"), function(x) sum(x[ ,4]))
data
colnames(data) <- c("Year", "Sector", "TotalEmission")  
qplot(Year, TotalEmission, data = data, facets = . ~ Sector, main = "Total Emissions from Coal Cumbustion-Related Sources Across US by Sector")

#### Question 5

sccsubset <- subset(SCC, grepl("mobile", EI.Sector, ignore.case=TRUE), select=c(SCC, EI.Sector))
head(sccsubset,100)
tail(sccsubset,100)
NEI5 <- merge(NEI, sccsubset)
data <- ddply(NEI5, c("year"), function(x) sum(x[which(x$fips == "24510"),4]))
data
colnames(data) <- c("Year", "TotalEmission")  
qplot(Year, TotalEmission, data = data, main = "Total Emissions in Years from Motor Veh. in Baltimore")

data <- ddply(NEI5, c("year", "EI.Sector"), function(x) sum(x[which(x$fips == "24510"),4]))
data
colnames(data) <- c("Year", "Sector", "TotalEmission")  
qplot(Year, TotalEmission, data = data, facets = . ~ Sector, main = "Total Emissions from Motor Veh. in Baltimore by Sector")

#### Question 6
head(NEI5)
data <- ddply(NEI5, c("year", "fips"), function(x) sum(x[which(x$fips == "24510" || x$fips == "06037"),4]))
data <- data[which(data$V1 > 0),]
colnames(data) <- c("Year", "Fips", "TotalEmission")  
str(data)
data <- transform(data, Fips = factor(Fips))
levels(data$Fips) <- c("Baltimore", "Los Angles")
str(data)
p <- ggplot(data, aes(Year, TotalEmission, colour = factor(Fips))) + geom_point()
p + facet_grid(. ~ Fips)
