#### Question 1

#The American Community Survey distributes downloadable data about United 
 #States communities. Download the 2006 microdata survey about housing 
 #for the state of Idaho using download.file() from here: 
    #https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
 #and load the data into R. The code book, describing the variable names is here: 
    #https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf  
 #How many properties are worth $1,000,000 or more?

getwd()
setwd("/Users/cemalperozen/Documents/Repos/datasciencecoursera/GettingCleaningData")
dir()

if(!file.exists("Data")) {
    dir.create("Data")
}

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl, destfile= "Data/housing.csv")

list.files("./Quiz1")

dateDownloaded <- date()

housingData <- read.table("Quiz1/Quiz1.csv", sep = ",", header = TRUE, quote = "")
head(housingData)
names(housingData)
str(housingData)

housingData$VAL
length(housingData[which(housingData$VAL=="24"), ]$VAL)
#### 2
Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate? 
Tidy data has one variable per column.  
Numeric values in tidy data can not represent categories.  
Tidy data has no missing values.  
Each tidy data table contains information about only one type of observation.  
#### 3
Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx  
Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:  dat 
What is the value of:  sum(dat$Zip*dat$Ext,na.rm=T) 
(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)
#### 4
Read the XML data on Baltimore restaurants from here: 
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml  
How many restaurants have zipcode 21231? 
17 
127 
28 
100 
#### 5
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
using the fread() command load the data into an R object  DT 
Which of the following is the fastest way to calculate the average value of the variable pwgtp15 
broken down by sex using the data.table package? 
sapply(split(DT$pwgtp15,DT$SEX),mean) 
mean(DT$pwgtp15,by=DT$SEX) 
tapply(DT$pwgtp15,DT$SEX,mean) 
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] 
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) 
DT[,mean(pwgtp15),by=SEX] 
########

#setwd("~/Courses/Coursera-Getting and Cleaning Data")
setwd("C:\\Users\\ozenca\\Documents\\Courses\\Coursera-Getting and Cleaning Data")

if(!file.exists("Quiz1")) {
    dir.create("Quiz1")
}

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl, destfile= "Quiz1/Quiz1.csv")

list.files("./Quiz1")

dateDownloaded <- date()

housingData <- read.table("Quiz1/Quiz1.csv", sep = ",", header = TRUE, quote = "")
head(housingData)
names(housingData)
str(housingData)

housingData$VAL
length(housingData[which(housingData$VAL=="24"), ]$VAL)

summary(housingData$FES)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx?accessType=DOWNLOAD"
download.file(fileurl, destfile= "Quiz1/NatGas.xlsx")

library(xlsx)
colIndex <- 7:15
rowIndex <- 18:23
NGAPData <- read.xlsx("./Quiz1/NatGasAP.xlsx", sheetIndex = 1, colIndex=colIndex, rowIndex=rowIndex)
head(NGAPData)
sum(NGAPData$Zip*NGAPData$Ext,na.rm=T) 

library(XML)
library(RCurl)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data <- getURL(fileurl, ssl.verifypeer = FALSE)
doc <- xmlParse(data)
rootNode<-xmlRoot(doc)
xmlName(rootNode)
xmlSApply(rootNode,xmlValue)
a<-xpathSApply(rootNode,"//zipcode",xmlValue)
a<-a[which(a=="21231")]
length(a)

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl, destfile= "Quiz1/IdahoHousing.csv")
library(data.table)
DT <- fread("Quiz1/IdahoHousing.csv")
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


