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


