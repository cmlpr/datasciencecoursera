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
