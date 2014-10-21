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









########## QUIZ 2 ##########


####################
# Question1
# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you 
# want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the 
# datasharing repo was created. What time was it created? This tutorial may be useful 
# (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run 
# the code in the base R package and not R studio. 
# 2012-06-21T17:28:38Z 
# 2014-03-05T16:11:46Z 
# 2013-11-07T13:25:07Z 
# 2014-01-04T21:06:44Z 
####################

setwd("C:\\Users\\ozenca\\Documents\\Courses\\Coursera-Getting and Cleaning Data\\Quiz2")
library(httr)

# 1. Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
# Insert your values below - if secret is omitted, it will look it up in
# the GITHUB_CONSUMER_SECRET environmental variable.
#
# Use http://localhost:1410 as the callback url
myapp = oauth_app("github", key="a1904acad3ad588004e4", secret="352231cd7c11f54e80e20a44243330111f86848a")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
names(req)
json1 = content(req)
library(jsonlite)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[5,]$created_at

####################
# Question2
# The sqldf package allows for execution of SQL commands on R data frames. We will 
# use the sqldf package to practice the queries we might send with the dbSendQuery 
# command in RMySQL. Download the American Community Survey data and load it into an 
# R object called  acs
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# Which of the following commands will select only the data for the probability 
# weights pwgtp1 with ages less than 50?
sqldf("select pwgtp1 from acs") 
sqldf("select * from acs") 
sqldf("select * from acs where AGEP < 50") 
sqldf("select pwgtp1 from acs where AGEP < 50") 
####################

setwd("C:\\Users\\ozenca\\Documents\\Courses\\Coursera-Getting and Cleaning Data")

if(!file.exists("./Data")) {
    dir.create("./Data")
}

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl, destfile= "./Data/acsurvey.csv")

list.files("./Data")

dateDownloaded <- date()

acs <- read.table("./Data/acsurvey.csv", sep = ",", header = TRUE, quote = "")
head(acs)
names(acs)
str(acs)

library(sqldf)

a<-sqldf("select pwgtp1 from acs where AGEP < 50") 
a

####################
# Question3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
# sqldf("select unique * from acs") 
# sqldf("select unique AGEP from acs") 
# sqldf("select distinct AGEP from acs") 
# sqldf("select distinct pwgtp1 from acs") 
####################

unique(acs$AGEP)

sqldf("select distinct AGEP from acs")

####################
# Question4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
#     http://biostat.jhsph.edu/~jleek/contact.html 
# (Hint: the nchar() function in R may be helpful)
# 45 92 7 2 
# 43 99 8 6 
# 45 31 2 25 
# 43 99 7 25 
# 45 0 2 2 
# 45 31 7 31 
# 45 31 7 25 
####################

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode
htmlCode[1]
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])


####################
# Question5
# Read this data set into R and report the sum of the numbers in the fourth column. 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
# (Hint this is a fixed width file format)
# 222243.1 
# 36.5 
# 32426.7 
# 35824.9 
# 101.83 
# 28893.3 
####################

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileurl, destfile= "./Data/sst.for")
list.files("./Data")

acs <- read.fortran("./Data/sst.for", c("A28","A4","A30"))
head(acs[1])
acs[[2]]
as.numeric(acs[[2]])
sum(as.numeric(acs[[2]]), na.rm = TRUE)






########## QUIZ 3 ##########

