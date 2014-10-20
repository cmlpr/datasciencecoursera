###############################################################################
############################ GETTING AND CLEANING DATA #########################
###############################################################################

### GET/SET Working Directory
getwd()
setwd()
getwd()
###Relative
setwd("../") #goes one level up
getwd()
setwd("./Documents") ##goes to level that you indicate
getwd()
###Absolute
setwd("C:/Users/ozenca/Documents/Courses")
getwd()
###Windows machines
setwd("C:\\Users\\ozenca\\Documents\\Courses")
getwd()
###Check if a directory exits
file.exists("Coursera-Getting and Cleaning Data")
file.exists("Some Folder")
###Create a directory
dir.create("Sole Folder") ## will create a folder if it doesn't exists
###Example
setwd("C:\\Users\\ozenca\\Documents\\Courses\\Coursera-Getting and Cleaning Data\\Notes")
getwd()
if(!file.exists("data")) {
    dir.create("data")
}

###Download a file from internet
download.file()
?download.file
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv")
download.file(fileUrl, destfile="./data/cameras.csv", method = "curl") ##for linux because the url is https
list.files("./data")
dateDownloaded <- date()
dateDownloaded





setwd("C:\\Users\\ozenca\\Documents\\Courses\\Coursera-Getting and Cleaning Data\\Notes")
getwd()
if(!file.exists("data")) {
    dir.create("data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

###Loading Flat Files
read.table() ## this is the main function for reading data into R
# Flexible and robust but requires more parameters
# Reads data into RAM - big data creates problems
read.table() - file, header, sep, row.names, nrows
# read.csv(), read.csv2()
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

cameraData <- read.csv("./data/cameras.csv") #automaticly assigns sep = "," and header = TRUE
head(cameraData)

cameraData <- read.csv("./data/cameras.csv", nrows = 4)
head(cameraData)

cameraData <- read.csv("./data/cameras.csv", skip = 2, nrows = 4)
head(cameraData)

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.xlsx", method = "internal")
list.files("./data")
dateDownloaded <- date()
dateDownloaded

library(xlsx)
cameraData <- read.xlsx("./data/Baltimore_Fixed_Speed_Cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)

colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/Baltimore_Fixed_Speed_Cameras.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
head(cameraDataSubset)

write.xlsx()
read.xlsx2() - faster but not stable when reading subsets

XLConnect Package
XLConnect vignette

######   XML #####
Components:
    Markup - labesl that give the text structure 
Content = actual text of the document

Tags corresponds to general labels
start tag  <section>
    end tag </section>
    empty tags <line-break />
    Elements are specific examples of tags
<Greeting> Hello, world </Greeting>
    Attributes are components of the label
<img src="jeff.jpg" alt="instructor" />
    <step number = "3"> Connect A to B. </step>
    
    library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
xmlSApply(rootNode, xmlValue)

XPath language
/node Top level node
//node Node at any level
node[@attr-name] Node with an attribute name
node[@attr-name='bob'] Node with attribute name 'bob'

xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)
scores <- xpathSApply(doc, "//li[@class='scores']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams


######   JSON   #####

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)
head(iris)


######   Data.Table   #####

Inherets from data.frame
written in C
much faster, subset, group, update

library(data.table)
DF <- data.frame(x=rnorm(9), y=rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF)
head(DF,3)
DT <- data.table(x=rnorm(9), y=rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DT,3)

tables() #shows the tables in the memory

DT[2,]
DT[DT$y=="a",]

DT[c(2,3)]

DT[,c(2,3)]

DT[,list(mean(x), sum(z))]
DT[,table(y)]

DT[,w := z^2]
DT

tables()

DT2 <- DT
DT[,y:=2]
head(DT, n = 3)
head(DT2, n = 3)
use copy function

DT[, m:={tmp <- (x+z); log2(tmp+5)}]
DT
DT[, a:=x>0]
DT
DT[, b:=mean(x+w), by = a]
DT

set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT
DT[, .N, by=x] # count the number of times grouped by x variable

DT <- data.table(x=rep(c("a","b","c"), each = 100), y = rnorm(300))
DT
setkey(DT,x)
DT['a']

DT1 <- data.table(x=c("a","a","b", "dt1"), y = 1:4)
DT2 <- data.table(x=c("a","b","dt2"), z = 5:7)
setkey(DT1, x)
setkey(DT2, x)
merge(DT1, DT2)


big_df <- data.frame(x=rnorm(1e6), y =rnorm(1e6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))
