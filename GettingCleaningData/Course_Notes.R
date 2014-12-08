###############################################################################
############################ GETTING AND CLEANING DATA #########################
###############################################################################

##### GET/SET Working Directory #####
getwd()
setwd()
getwd()
###Relative
setwd("../") #goes one level up
getwd()
setwd("./Documents") ##goes to level that you indicate
getwd()
###Absolute
setwd("C:/Users/cemalper/Documents/Coursera/GetData/")
getwd()
###Windows machines
setwd("C:\\Users\\cemalper\\Documents\\Coursera\\GetData")
getwd()
###Check if a directory exits
file.exists("Coursera-Getting and Cleaning Data")
file.exists("Some Folder")
###Create a directory
dir.create("Some Folder") ## will create a folder if it doesn't exists
###Example
setwd("C:\\Users\\cemalper\\Documents\\Coursera\\GetData")
getwd()
if(!file.exists("Data")) {
    dir.create("Data")
}

##### Download a file from internet #####
download.file()
?download.file
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./Data/cameras.csv")
download.file(fileUrl, destfile="./Data/cameras.csv", method = "curl") # For MAC OSX
download.file(fileUrl, destfile="./Data/cameras.csv", method = "curl") ## for linux because the url is https
list.files("./Data")
dateDownloaded <- date()
dateDownloaded


##### Loading Flat Files #####
read.table() ## this is the main function for reading data into R
# Flexible and robust but requires more parameters
# Reads data into RAM - big data creates problems
read.table() # important parameters file, header, sep, row.names, nrows
# read.csv(), read.csv2()
cameraData <- read.table("./Data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)
str(cameraData)
summary(cameraData)

# read.csv has some predefined parameters
# such as: automaticly assigns sep = "," and header = TRUE
cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

# Quotes
# Most of the time if data has ' or ", read.table may not be able to read correctly
# paramater quote = "" will solve the problem. This means no quotes

# na.strings paramater will set the character used for missing data

# nrows paramater will determine the number of rows to be read by read.table
cameraData <- read.csv("./data/cameras.csv", nrows = 4)
head(cameraData)

# skip parameter will determine the number of lines to skip
cameraData <- read.csv("./data/cameras.csv", skip = 2, nrows = 4)
head(cameraData)


##### Reading Excel Files #####
if(!file.exists("Data")) {
  dir.create("Data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./Data/cameras.xlsx")
list.files("./Data")
dateDownloaded <- date()
dateDownloaded

# The package we will use is xlsx package
install.packages("xlsx")
library(xlsx)
list.files("./Data")
# We would like to get the first sheet and we should consider that the first row is the header row
cameraData <- read.xlsx("./Data/Baltimore_Fixed_Speed_Cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)

# you can read specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/Baltimore_Fixed_Speed_Cameras.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
head(cameraDataSubset)

# Generate an excel file
write.xlsx()
read.xlsx2() # faster but not stable when reading subsets

# This is more flexible and more robust package to read excel files
XLConnect Package
XLConnect vignette



##### Reading XML Files #####

# XML = Extensible markup language
# Frequently used to store structured data
# Particularly popular in internet applications
# Extracting XML is the basis for most web scraping
# Components:
#    Markup - labels that give the text structure 
#    Content = actual text of the document

# Tags corresponds to general labels
#    start tag  <section>
#    end tag    </section>
#    empty tags <line-break />
# Elements are specific examples of tags
#    <Greeting> Hello, world </Greeting>
# Attributes are components of the label
#    <img src="jeff.jpg" alt="instructor" />
#    <step number = "3"> Connect A to B. </step>

# To learn more about XML
# http://en.wikipedia.org/wiki/XML
# http://www.w3schools.com/xml/simple.xml
# 

install.packages("XML")
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
?xmlTreeParse #parse out the xml data
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
# After reading it is still a differnt object in R. Now we can use functions to access this object.
# Rood node wraps the whole document and the whole document is the breakfast menu
rootNode <- xmlRoot(doc) 
# Get the name of the Root node
xmlName(rootNode)
# Get the names in the root node - the result will be a list
names(rootNode)
# Directly access parts of the XML document
rootNode[[1]]
rootNode[[1]][[1]]
# Programatically extract certain parts of the document
xmlSApply(rootNode, xmlValue)

# XPath language
# /node Top level node
# //node Node at any level
# node[@attr-name] Node with an attribute name
# node[@attr-name='bob'] Node with attribute name 'bob'
# More information
# http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf

# Get items in the menu and prices
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

# HTML Parsing
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE) #useInternal will get all the nodes
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams

# More Information
# http://www.omegahat.org/RSXML/shortIntro.pdf
# http://www.omegahat.org/RSXML/Tour.pdf
# http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf




##### Reading JSON Files #####

# Javascript object Notation
# Light weight data storage
# common format for data from application programming interfaces (API)
# Similar structure to XML but different symbols
# Data stored as
  # Numbers (double)
  # Strings (double quoted)
  # Boolean (True or False)
  # Array (ordered, comma separated enclosed in square brackets [])
  # Objects (unordered, comma separated collection of key:value pairs in curly braces {})

# http://en.wikipedia.org/wiki/JSON

install.packages("jsonlite")
install.packages('httr')
library(jsonlite)
library(httr)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

# Turn data frames into json formatted data
myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

# Convert back to data-frame
iris2 <- fromJSON(myjson)
head(iris2)
head(iris)

# More information
# http://www.json.org/
# http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/
# http://cran.r-project.org/web/packages/jsonlite/vignettes/json-mapping.pdf




#####   Data.Table   #####

# Faster and more memory efficient

# Inherets from data.frame
# written in C
# much faster, subset, group, update

install.packages("data.table")
library(data.table)
DF <- data.frame(x=rnorm(9), y=rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)
DT <- data.table(x=rnorm(9), y=rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DT,3)

# Display the tables in the memory
tables() 

# Subset rows
DT[2,]
DT[DT$y=="a",]
# Subsets 2nd and 3rd rows
DT[c(2,3)]

# Subset columns
# This is where data.table is different than data.frame
DT[,c(2,3)] # will not generate the result that we want

# In R an expression is a collection of statements enclosed in curly brackets
{
  x = 1
  y = 2
}
k = {print(10); 5}
k

# Calculating values for variables with expressions
# we can pass a list of functions for calculation
str(DT)
summary(DT)
DT[,list(mean(x), sum(z))]
DT[,table(y)]

# Adding new columns
 
DT[,w := z^2]
DT

tables()

DT2 <- DT # This won't generate a new copy in the memory.
DT[,y:=2]
head(DT, n = 3)
head(DT2, n = 3)
# use copy function to generate a new copy of the table


# Multiple operations
# Use statements

DT[, m:={tmp <- (x+z); log2(tmp+5)}]
DT


# Plyr like operations

DT[, a:=x>0]
DT
DT[, b:=mean(x+w), by = a] # get the mean with grouping with column "a"
DT


# Special variables
# .N : An integer, length one, containing the number of times a particular group appears
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT
DT[, .N, by=x] # count the number of times a grouped by x variable


# keys
DT <- data.table(x=rep(c("a","b","c"), each = 100), y = rnorm(300))
DT
setkey(DT,x)
DT['a']


# Use keys to join data.tables
DT1 <- data.table(x=c("a","a","b", "dt1"), y = 1:4)
DT2 <- data.table(x=c("a","b","dt2"), z = 5:7)
setkey(DT1, x)
setkey(DT2, x)
merge(DT1, DT2)


# Fast reading
big_df <- data.frame(x=rnorm(1e6), y =rnorm(1e6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))

# More info:
# http://stackoverflow.com/questions/13618488/what-you-can-do-with-data-frame-that-you-cant-in-data-table
# https://github.com/raphg/Biostat-578/blob/master/Advanced_data_manipulation.Rpres






#####   Reading from MySQL   #####

# Resources: 
    # http://dev.mysql.com/doc/employee/en.sakila-structure.html
    # RMySQL vignette: http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
    # List of commands: http://www.pantz.org/software/mysql/mysqlcommands.html
    # Summary of commands: http:www.r-bloggers.com/mysq;-and-r/ 
# Installing: http://dev.mysql.com/doc/refman/5.7/en/installing.html

# MAC
install.packages("RMySQL")
# Windows
# official instructions (may be useful for MAC users too): http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL 
# potentially useful guide: http://www.ahschulz.de/2013/07/23/installing-rmysql-under-windows/

#connect and create handle
ucscDB <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu") 
# query databases - shows all the databases in the connection
result <- dbGetQuery(ucscDB, "show databases;") 
# disconnect from the server: wait for TRUE response
dbDisconnect(ucscDb);

#connect to specific database
hg19 <- dbConnect(MySQL(), user="genome", db = "hg19", host="genome-mysql.cse.ucsc.edu") 
#get tables, each table is like a data frame
allTables <- dbListTables(hg19) 
#number of tables
length(allTables) 
#first 5 tables
allTable[1:5] 

#specific table
#specific genome's table's fields > column names
dbListFields(hg19,"affyU133Plus2") 
#number of rows in the table affyU133Plus2
dbGetQuery(hg19, "select count(*) from affyU133Plus2") 

# Read the table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatch between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

#if you don't want to get all the results
affyMisSmall <- fetch(query, n = 10); 
#clear the query from the database - wait for the TRUE print
dbClearResult(query); 
dim(affyMisSmall)
# Close the connection
dbDisconnect(hg19);





#####   Reading from HDF5   #####

# Used for storing large datasets
# Supports storing a range of data types
# Heirarchical Data Format
# "groups" containing zero or more data sets and metadata
    # Have a "group header" with group name and list of attributes
    # Have a "group symbol table" with a list of objects in group
# "datasets" multidimensional array of data elements with metadata
    # Have a "header" with name, datatype, dataspace, and storage layout
    # Have a "data array" with the data
# http://www.hdfgroup.com
# http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf
# http://www.hdfgroup.com/HDF5

source("http://bioconductor.org/biocLite.R") #install
biocLite("rhdf5") #install

library(rhdf5)
setwd("C:/Users/ozenca/Documents/GitHub/datasciencecoursera/GettingCleaningData")
list.files("./Data")

created = h5createFile("./Data/example.h5")
created

# Create groups withing the file
created = h5createGroup("./Data/example.h5","foo")
created = h5createGroup("./Data/example.h5","baa")
# create a subgroup
created = h5createGroup("./Data/example.h5","foo/foobaa")

# list the groups
h5ls("./Data/example.h5")

A = matrix(1:10, nr=5, nc=2)
# Write data in the group
h5write(A, "./Data/example.h5", "foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
# adaa atributes
attr(B,"scale") <- "liter"
h5write(B, "./Data/example.h5", "foo/foobaa/N")
h5ls("./Data/example.h5")

# Write a data set
df <- data.frame(1L:5L,seq(0,1,length.out=5), c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "./Data/example.h5", "df")
h5ls("./Data/example.h5")

readA = h5read("./Data/example.h5","foo/A")
readA
readA = h5read("./Data/example.h5","foo/foobaa")
readA
readA = h5read("./Data/example.h5","df")
readA

# writing and reading chunks
h5write(c(12,13,14),"./Data/example.h5","foo/A",index=list(1:3,1))
h5read("./Data/example.h5", "foo/A")






#####   Reading from the Web   #####
#####   Webscraping            #####

# Webscrapping: Programatically extracting data from the HTML code of websites
# U can be a great way to get data 
# May websites have information you may want to programatically read
# In some cases this is against the terms of service for the website
# Attempting to read too many pages too quickly can get your IP address blocked
# http://en.wikipedia.org/wiki/Web_scraping

# http://www.r-bloggers.com/?s=Web+Scraping
# http://cran.r-project.org/web/packages/httr/httr.pdf

# Getting data off webpages - readLines()
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

# Parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

# GET from the httr packages
library(httr)
html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# Accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2
names(pg2)

# Using handles - you can keep authentications
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path="search")
pg1
pg2


#####   Reading from APIs   #####

# httr allows GET, POST, PUT, DELETE requests if you are authorized
# You can authenticate with a user name and password
# Most modern APIs use something like oauth
# httr works well with Facebook, Google, Twitter , Github, etc

#Twitter
#First create an application in dev.twitter.com/apps
#start the auth
myapp = oauth_app("twitter", 
                  key="uF2h52MH0wPb5Xnc7NY83d5Ob", 
                  secret="2SZDCjxS4Z6QDsU7rZVYqox6FCUs7LwLiectZrf0VO6YY2WOFI") 
# Sign
sig = sign_oauth1.0(myapp, 
                    token = "26301788-QbEJodeSWSjnUvZ441jkzOdeG1z6QrkQ9g4l67gCW", 
                    token_secret = "0CAieEaEWrHk76LotMPFehSqs2XFlleYqqSHGKMRWc0CL")
#api version 1.1, statuses from timeline
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig) 

# Convert to JSON object
library(httr)
library(jsonlite)

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))

json2
json2[1,1:4]
json2[4,1:4]



#####   Reading from Other Resources   #####

file - oepn a connection to a text file
url - open a connection to a url
gzfile - oepn a connection to .gz file
bzfile - open a connection to a .bz2 file
# for more information
?connections 
# Remember to close connections

# FOREIGN PACKAGE
# Minitab, S, SAS, SPSS, Stata, Systat
read.art(Weka)
read.dta(Stata)
read.mtp(Minitab)
read.octave(Octave)
read.spss(SPSS)
read.xport(SAS)
# http://cran.r-project.org/web/packages/foreign/foreign.pdf

# RPostresSQL
# RODBC
# RMongo

# Reading images
jpeg
readbitmap
png
EBImage #(Bioconductor)

# GIS
rdgal
rgeos
raster

# Music data
tuneR
seewave






#####   Subsetting and Sorting   #####

set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2"=sample(6:10),"var3"=sample(11:15))
X
X <- X[sample(1:5),];
X
X$var2[c(1,3)] = NA
X

# First column of the data frame
X[,1]
X[,"var1"]

# Subset both columns and rows
X[1:2, "var2"]

#Subset using logical statements
X[(X$var1 <=3 & X$var3 > 11),]
X[(X$var1 <=3 | X$var3 > 15),]

#Dealing with NA values
X[which(X$var2 >8),]

#Sorting
# increasing
sort(X$var1)
# decreasing
sort(X$var1, decreasing = TRUE)
# put NAs to the last rows
sort(X$var2, na.last = TRUE)

#Order data frame
X[order(X$var1),]
#use multiple columns
X[order(X$var1,X$var3),]


# Plyr package
library(plyr)
# increasing
arrange(X,var1)
# decreasing
arrange(X, desc(var1))

# Add rows and columns
X$var4 <- rnorm(5)
X
Y <- cbind(X, rnorm(5))
Y





#####   Summarizing Data   #####

getwd()
if(!file.exsts("./Data")){dir.create("./Data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./Data/restaurants.csv", method = "curl")
list.files("./Data")
restData <- read.csv("./Data/restaurants.csv")
restData

# Look at a bit of the data
head(restData, n = 3)
tail(restData, n = 4)

# MAke summary
# For catogory variables it will give the count
summary(restData)

# More in depth informations
str(restData)

# Quantiles of quantitative variables
quantile(restData$councilDistrict, na.rm= TRUE)
quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))

# MAke table
table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict, restData$zipCode)

#Check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
# all will check if all values satify a given condition
all(restData$zipCode > 0)

# Row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

# Values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))

restData[restData$zipCode %in% c("21212", "21213"), ]

# Cross tabs
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

# Flat Tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~., data = warpbreaks) # break it down with all the variables
xt
ftable(xt)

# Size of data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")







#####   Creating New Variables   #####

# Often the raw data won't have a value you are looking for
# You'll need to tranform the data to get the values you would like
# Usually you will add those values to the data frames you are working with
# Common variables to create
    # Missingness indicator
    # Cutting up quntitative variables
    # Applying transforms

# Creating Sequences
s1 <- seq(1,10, by=2)
s1
s2 <- seq(1,10, length = 3)
s2
x <- c(1,3,8,25,100)
seq(along = x)

# Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# Creating binary variables
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# Creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

# Easy cutting
install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

# Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# Levels of factor variables
yesno <-sample(c("yes", "no"), size = 10, replace = TRUE)
# the first level is the lowest value
yesnofac <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes") #change the reference
as.numeric(yesnofac)

# Cutting produces factor variables
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)
class(restData$zipGroups)

# Using the mutate function in plyr
# Create a new variable and add to data frame
library(plyr)
restData2 <- mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData2$zipGroups)

# Common tranforms
abs()
sqrt()
ceiling()
floor()
round()
signif()
cos()
sin()
log()
log2()
log10()
exp()






#####   RESHAPE   #####

# The goal is tidy data
# Each variable forms a column
# Each observation forms a row
# Each table/file stores data about one kind of observation 

# Start with reshaping
library(reshape2)
head(mtcars)

# Melt data frames
# 
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt,3)
tail(carMelt, 3)

# Casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

# Averaging Values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

# Another way - Split - Apply - Combine
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount = lapply(spIns, sum)
sprCount
unlist(sprCount)
sapply(spIns, sum)

# plyr package
ddply(InsectSprays, .(spray), summarize, sum=sum(count))

# Creating a new variable
spraySums <- ddply(InsectSprays, .(spray), summarize, sum=ave(count, FUN=sum))
dim(spraySums)
head(spraySums)

# Other functions
acast # for casting as multidimensional arrays
arrange # for faster reordering without using order() commands
mutate # adding new variables

# Resources 
# http://plyr.had.co.nz/09-user/
# http://www.slideshare.net/jeffreybreen/reshaping-data-in-r
# http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/




#####   Merging   #####

if(!file.exits("./Data")){dir.create("./Data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./Data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./Data/solutions.csv", method = "curl")

reviews = read.csv("./Data/reviews.csv")
solutions = read.csv("./Data/solutions.csv")
head(reviews,2)
head(solutions,2)

# solutions_id in reviews dataset is same as the id column in solutions data

# Merging data
names(reviews)
names(solutions)

# Important parameters: x,y, by.x, by.y, all
# By default it will try to match with all common columsn

# Merge by solution id in the 1st data and id in 2nd data. Also also include non matching rows
mergedData=merge(reviews, solutions, by.x="solution_id", by.y="id",all = TRUE)
mergedData
head(mergedData,20)

# Default - merge all common column names
intersect(names(solutions), names(reviews))
mergedData2 = merge(reviews, solutions, all = TRUE)
head(mergedData2)

# Using join in the plyr package
# faster but less full featured
df1 = data.frame(id=sample(1:10), x = rnorm(10))
df2 = data.frame(id=sample(1:10), y = rnorm(10))
arrange(join(df1, df2), id)

# Join all
df1 = data.frame(id=sample(1:10), x = rnorm(10))
df2 = data.frame(id=sample(1:10), y = rnorm(10))
df3 = data.frame(id=sample(1:10), z = rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)

# resources
# http://www.statsmethods.net/management/merging.html
# http://plyr.had.co.nz
# http://en.wikipedia.org/wiki/Join_(SQL)




#####   Editing Text Variables   #####

getwd()
setwd("~/Documents/Repos/datasciencecoursera/GettingCleaningData/")
getwd()
list.files()
if(!file.exsts("./Data")){dir.create("./Data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./Data/cameras2.csv", method = "curl")
list.files("./Data")
cameraData <- read.csv("./Data/cameras2.csv")
names(cameraData)
head(cameraData)

# change from capital to lower case
tolower(names(cameraData))
toupper(names(cameraData))

# Fixing character vectors - strsplit()
# Split on period, since period is a reserved character, use escape
splitNames <- strsplit(names(cameraData), "\\.")
splitNames

# Quick aside (review)- lists
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist[1]
mylist$letters
mylist[[1]]

# Fixing character vectors - sapply()
# Applies a function to each element in a vector of list
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

# Peer Review Data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutionss-apr29.csv"
download.file(fileUrl1, destfile = "./Data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./Data/solutionss.csv", method = "curl")
reviews <- read.csv("./Data//reviews.csv")
solutions <- read.csv("./Data//solutions.csv")
head(reviews,2)
head(solutions,2)

# Fixing character vectors - sub()
# substitute
names(reviews)
sub("_","", names(reviews),)

# Fixing char vectors - gsub()
# substitute not the first observation but all
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)

# Finding values - grep(), grepl()
# grep - finds the location of the occurances
grep("Alameda", cameraData$intersection)
# Instea of location, value = True will print the occurances
grep("Alameda", cameraData$intersection, value = TRUE)
# grepl - gives a logical vector
table(grepl("Alameda", cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]
cameraData2

# check if a value appears
grep("JeffStreet", cameraData$Intersection)
length(grep("JeffStreet", cameraData$Intersection))

# More useful string functions
library(stringr)
# Count characters
nchar("Jeffry Leek")
# Get a portion of the string
substr("Jeffry Leek", 1, 7)
# Paste 2 or more strings together
paste("Cem", "Alper")
# Paste without space between the strings
past0("Cem", "Alper")
# Remove white space before or after
str_trim("Jeff    ")

# Important points about text in data sets
# Names of variables should be
    # All lower case when possible
    # Descriptive (Diagnosis vs Dx)
    # Not dublicated
    # Not have underscore or dots or white space
# Variables with character values
    # Should usually be made into factor variables (depends on application)
    # Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female vs 0/1 or M/F)





#####   Regular Expressions   #####

# Regular expressions can be thought of as a combination of literals and metachars
# To draw an anology with natural language, think of literal text forming 
    # the words of this language, and the metachars defining its grammer
# Regular expressions have a rich set of metachars

# Literals - Exact match
# We need a way to express
    # Whitespace word boundries
    # sets of literals
    # the beginning and end of a line
    # alternatives ("war" or "piece") Metachars to the rescue

# Metachars
# Some metachars represents the start of a line -- Carrot
^i think
# End of line - $
morning$

# Character classes with []
# We can list a set of chars we will accept at a given point in the match
[B][b][U][u][S][s][H][h]
# will match - BUSH, bush, bUSh....
^[Ii] am 
# will match I am or i am

# you can match a range of letters [a-z] or [a-zA-Z] # order doesn't matter
^[0-9][a-zA-Z]
# will match a line which starts with a number and followed by a char from a to Z

# When used at the beginning of a char class, the ^ is also a metachar and
# indicates matching chars NOT in the indicated class
[^?.]$
# will match - end of line anything other than "?" or "."


# "." is used to refer to any char
9.11
# will match anything like 9-11, 9:11, 9a11....

# "|" is the "or" metachar. It is used to combine two expressions
flood|fire
# will match lines with flood, fire or both
# you can add many or statements
flood|earthquake|coldfire|hurricane

^[Gg]ood|[Bb]ad
# will match lines with Good or good at the beginning of the line 
# or Bad or bad at any point in the 
# use paranthesis to make the metachar apply on a bunch of expressions
^([Gg]ood|[Bb]ad)

# "?" indicates that the expression is optional
[Gg]eorge( [Ww]\.)? [Bb]ush
# will match George W. Bush, George Bush,...
# to match a literal ".", we used escape char, back slash

# "*" any number of repetition
# "+" means "at least one of the item"

(.*)
# will match lines that has (), (aasdas), (any number of chars in parantheses)

[0-9]+ (.*)[0-9]+
#match line wich has at least one number, any number of chars and another number

    
# { and } are referred to as interval quantifiers; they let us specify
    # the minimum and maximum number of matches of an expression

[Bb]ush( +[^ ]+ +){1,5} debate
# we are looking at lines which has Bush or bush in it and the word "debate"
# we want space followed by chars other than a space and followed by a space
# this means space word space could happen between 1 to 5 times

# m,n means at least m but not more than n matches
# m means exactly m matches
# m, means at least m matches

# In most implementations of regular expressions, the parantheses not only limit
# the scope of alternatives divided by a "|", but also can be used to "remember"
# text matched by the subexpression enclosed

# We refer to the matched text with \1, \2, etc

 +([a-zA-Z]+) +\1 +
    # will match " yo yo"


# "*" is greedy, it always matches the longest possible string that satisfies the
# the regular expression
^s(.*)s

# the greediness of * can be turned off with ?
^s(.*?)s$
    

    
    
#####   Working with Dates   #####

d1 = date()
d1
class(d1)

d2 = Sys.Date()
d2
class(d2)

# Formatting dates
# %d = day as number (0-31)
# %a = abbreviated weekday 
# %A = unabbreviated weekday
# %m = month (00-12)
# %b = abbreviated month
# %B = unabbreviated month
# %y = 2 digit year
# %Y = four digit year

format(d2, "%a %b %d")
d2

x <- c("1jan1960", "2jan1960", "3jul1960")
z <- as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1]-z[2])

# Converting to Julian
weekdays(d2)
months(d2)
julian(d2)

# LUBRIDATE
install.packages("lubridate")
library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")

# Dealing with Times
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland")
?Sys.timezone

x <- dmy(c("1jan2013", "2jan2013", "3mar2013", "30jul2013"))
wday(x[1])
wday(x[1], label=TRUE)



#####   Data resources   #####









#####   Swirl   #####

library(swirl)
swirl()
install_from_swirl("Getting and Cleaning Data")
swirl()

# Manipulating Data with dplyr #
path2scv <- ("/Library/Frameworks/R.framework/Versions/3.1/Resources/library/swirl/Courses/Getting_and_Cleaning_Data/Manipulating_Data_with_dplyr/2014-07-08.csv")
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)

dim(mydf)
head(mydf)
library(dplyr)
packageVersion("dplyr")
?tbl_df
cran <- tbl_df(mydf)
rm("mydf")
cran
?select
select(cran, ip_id, package, country)
select(cran, r_arch:country)
select(cran, country:r_arch)
cran
select(cran, -time)
select(cran, -(X:size))
filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US")
?Comparison
filter(cran, r_version <= "3.0.2", country == "IN")

filter(cran, country == "US" | country == "IN") 
filter(cran, size > 100500, r_os == "linux-gnu")
filter(cran, !is.na(r_version))

cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))
arrange(cran2, package, ip_id) 
arrange(cran2, country, desc(r_version), ip_id)

cran3 <- select(cran, ip_id, package, size)
cran3
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
mutate(cran3, correct_size = size + 1000)

summarize(cran, avg_bytes = mean(size))


# Grouping and Chaining with dplyr #
?group_by
by_package <- group_by(cran, package)
by_package
summarize(by_package, mean(size))
?n
?n_distinct
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
pack_sum
quantile(pack_sum$count, probs = 0.99)
top_counts <- filter(pack_sum, count > 679)
top_counts
head(top_counts, 20)
arrange(top_counts, desc(count))
quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
top_unique
arrange(top_unique, desc(unique))

# Changing
by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# Here's the new bit, but using the same approach we've
# been using this whole time.

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)



result2 <-
    arrange(
        filter(
            summarize(
                group_by(cran,
                         package
                ),
                count = n(),
                unique = n_distinct(ip_id),
                countries = n_distinct(country),
                avg_bytes = mean(size)
            ),
            countries > 60
        ),
        desc(countries),
        avg_bytes
    )

print(result2)

result3 <-
    cran %>%
    group_by(package) %>%
    summarize(count = n(),
              unique = n_distinct(ip_id),
              countries = n_distinct(country),
              avg_bytes = mean(size)
    ) %>%
    filter(countries > 60) %>%
    arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)

cran %>%
    select(ip_id, country, package, size) %>%
    mutate(size_mb = size / 2^20) %>%
    filter(size_mb <= 0.5) %>%
    arrange(desc(size_mb))


###########################
# Tidying Data with tidyr #
###########################

install.packages("tidyr")
library(tidyr)

students
?gather
gather(students, sex, count, -grade)

students2
res <- gather(students2, sex_class, count, -grade)
res

?separate
separate(data = res, col = sex_class, into = c("sex", "class"))

students2 %>%
    gather(sex_class, count, -grade) %>%
    separate(sex_class , c("sex", "class")) %>%
    print

students3
students3 %>%
    gather(class, grade , class1:class5 , na.rm = TRUE) %>%
    print

#spread
?spread
students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread(test, grade) %>%
    print

extract_numeric("class5")
students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread(test, grade) %>%
    mutate(class, class = extract_numeric(class)) %>%
    print

students4
student_info <- students4 %>%
    select(id, name, sex) %>%
    unique %>%
    print
gradebook <- students4 %>%
    select(id, class, midterm, final) %>%
    print

passed
failed
passed <- mutate(passed, status = "passed")
failed <- mutate(failed, status = "failed")
?rbind_list
rbind_list(passed, failed)

sat
sat %>%
    select(-contains("total")) %>%
    gather(part_sex, count, -score_range) %>%
    separate(part_sex, c("part", "sex")) %>%
    group_by(part, sex) %>%
    mutate(total = sum(count),
           prop = count/total
    ) %>% print



##################################
# Dates and Times with lubridate #
##################################

Sys.getlocale("LC_TIME")
library(lubridate)
help(package = lubridate)
this_day <- today()
this_day
year(this_day)
month(this_day)
day(this_day)
wday(this_day)
wday(this_day, label = TRUE)
this_moment <- now()
this_moment
hour(this_moment)
minute(this_moment)
second(this_moment)

my_date <- ymd("1989-05-17")
my_date
class(my_date)
ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)
ymd(192012)
ymd("2012/1/2")
ymd("1920/1/2")

dt1
ymd_hms(dt1)
hms("03:22:14")

dt2
ymd(dt2)

update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment
this_moment <- update(this_moment, hours = 6, minutes = 23)
this_moment

nyc <- now("America/New_York")
nyc
depart <- nyc + days(2)
depart

depart <- update(depart, hours = 17, minutes = 34)
depart

arrive <- depart + hours(15) + minutes(50)
arrive

?with_tz
arrive <- with_tz(arrive, "Asia/Hong_Kong")
arrive
last_time <- mdy("June 17, 2008", tz = "Singapore")
last_time

?new_interval
how_long <- new_interval(last_time, arrive)
as.period(how_long)

stopwatch()
