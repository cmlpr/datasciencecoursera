########## QUIZ 1 ##########

#### 1
# The American Community Survey distributes downloadable data about United States 
# communities. Download the 2006 microdata survey about housing for the state of Idaho 
# using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# and load the data into R. The code book, describing the variable names is here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf  
# How many properties are worth $1,000,000 or more?

setwd("C:\\Users\\cemalper\\Documents\\Coursera\\GetData")
getwd()

if(!file.exists("Data")) {
  dir.create("Data")
}

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl, destfile= "Data/Quiz1.csv")

list.files("./Data")

housingData <- read.table("Data/Quiz1.csv", sep = ",", header = TRUE, quote = "")
head(housingData)
names(housingData)
str(housingData)

housingData$VAL
length(housingData[which(housingData$VAL=="24"), ]$VAL)
# 53


#### 2
# Use the data you loaded from Question 1. Consider the variable FES in the 
# code book. Which of the "tidy data" principles does this variable violate? 

housingData$FES
summary(housingData$FES)

Tidy data has one variable per column.   


#### 3
# Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx  
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:  dat 
# What is the value of:  sum(dat$Zip*dat$Ext,na.rm=T) 
# (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx?accessType=DOWNLOAD"
download.file(fileurl, destfile= "Data/Quiz1_NatGas.xlsx", mode = "wb")

library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
NGAPData <- read.xlsx("./Data/Quiz1_NatGas.xlsx", sheetIndex = 1, colIndex=colIndex, rowIndex=rowIndex)
head(NGAPData)
sum(NGAPData$Zip*NGAPData$Ext,na.rm=T)
# 36534720


#### 4
# Read the XML data on Baltimore restaurants from here: 
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml  
# How many restaurants have zipcode 21231? 

library(XML)
library(RCurl)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data <- getURL(fileurl, ssl.verifypeer = FALSE)
doc <- xmlParse(data)
rootNode<-xmlRoot(doc)
xmlName(rootNode)
xmlSApply(rootNode,xmlValue)
a<-xpathSApply(rootNode,"//zipcode",xmlValue)
a
a<-a[which(a=="21231")]
length(a)
# 127


#### 5
# The American Community Survey distributes downloadable data about United States 
# communities. Download the 2006 microdata survey about housing for the state of Idaho 
# using download.file() from here: 
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# using the fread() command load the data into an R object  DT 
# Which of the following is the fastest way to calculate the average value of the variable pwgtp15 
# broken down by sex using the data.table package? 

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl, destfile= "Data/Quiz1_IdahoHousing.csv")
library(data.table)
DT <- fread("Data/Quiz1_IdahoHousing.csv")
#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
DT[,mean(pwgtp15),by=SEX]
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
tapply(DT$pwgtp15,DT$SEX,mean)
#mean(DT$pwgtp15,by=DT$SEX)
sapply(split(DT$pwgtp15,DT$SEX),mean)

system.time(DT[,mean(pwgtp15),by=SEX]) # this one is the fastest
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
