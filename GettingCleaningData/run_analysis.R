# Getting and Cleaning Data
# Course Project 

# Dataset
# Human Activity Recognition Using Smartphones Data Set 

# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that 
# can be used for later analysis. 

# The code does following:
#    1. Merges the training and the test sets to create one data set.
#    2. Extracts only the measurements on the mean and standard deviation 
#       for each measurement. 
#    3. Uses descriptive activity names to name the activities in the 
#       data set
#    4. Appropriately labels the data set with descriptive variable names. 
#    5. From the data set in step 4, creates a second, independent tidy 
#       data set with the average of each variable for each activity and 
#       each subject.

##################
##### Part 0 #####
##################

# Preparations

# Change the working directory
setwd("/Users/cemalperozen/Documents/Repos/datasciencecoursera/GettingCleaningData/")
getwd()

# Create a sub-directory for the data
if(!file.exists("Data")) {
    dir.create("Data")
}

# Download Files
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Data/SmartPhoneData.zip", method = "curl")

# Extract Zip File
unzip("./Data/SmartPhoneData.zip", exdir = "./Data/")

# Look at extracted files
list.files("Data/UCI HAR Dataset/")

####################
##### Part 1&4 #####
####################

# Read Files
# Activity labels file has two columns: first column is the label ID and second
# column is the label name. We will match label ids in y_test and y_train with 
# label names later
activity_labels <- read.table("./Data/UCI HAR Dataset/activity_labels.txt", col.names = c("label_ID", "activity_name"))

# Features file includes all the column names for the x_test and x_train file
# There are 2 columns in this data but we are only interested in the 2nd column
# where we are going to get the headers
features <- read.table("./Data/UCI HAR Dataset/features.txt")
featureNames <- features[,2]

# subject_test and subject_train files includes the subject ids
subject_test <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt", col.names = c("subject_ID"))
subject_train <- read.table("./Data/UCI HAR Dataset/train//subject_train.txt", col.names = c("subject_ID"))

# x_test and x_train files include all the measured data
# we will use the featureNames vector we created earlier to name the columns of this data
x_test <- read.table("./Data/UCI HAR Dataset/test/X_test.txt", , col.names = featureNames)
x_train <- read.table("./Data/UCI HAR Dataset/train/X_train.txt", col.names = featureNames)

# y_test and y_train files have the label ids for the test and training data
y_test <- read.table("./Data/UCI HAR Dataset/test/y_test.txt", col.names = c("label_ID"))
y_train <- read.table("./Data/UCI HAR Dataset/train//y_train.txt", col.names = c("label_ID"))

# Combine test data: First column is the subject id, second column is the 
# label ID and the data in the rest of the columns
testData <- cbind(subject_test, y_test, x_test)

# Same combine process for the training data
trainData <- cbind(subject_train, y_train, x_train)

# Merge training and test data
completeData <- rbind(testData, trainData) 
# Look at the data
str(completeData)

##################
##### Part 2 #####
##################

# The first part is now complete
# Now in the second part we will subset the data so that we only have mean 
# and standard deviation information in our reduced data set

# The column names for data contains "mean" and "std". We can use them to grep data
names_for_subsetting <- grep("mean|std", names(completeData), ignore.case = TRUE)
# Include the first 2 column names for subject id and labal id
names_for_subsetting <- c(1, 2, names_for_subsetting)

# Now use the vector we just created for subsetting
requiredData <- completeData[, names_for_subsetting]
# Look at the data
str(requiredData)

##################
##### Part 3 #####
##################

# Add activity labels
activityData <- merge(requiredData, activity_labels, by.x = "label_ID", by.y = "label_ID", all = TRUE)
# Change the order of columns
activityData <- activityData[, c(2, 1, length(names(activityData)), c(3:(length(names(activityData))-1)))]
# Observe output
str(activityData)

##################
##### Part 4 #####
##################

# Done in step 1 when reading data

##################
##### Part 5 #####
##################

# Create a data with mean values each variable for each activity and subject

# Use reshape library like in the 3rd week of the class

# Start with reshaping
library(reshape2)

# Melt data
dataMelt <- melt(activityData, id = c(1:3))
head(dataMelt,3)
tail(dataMelt, 3)

# Casting data
tidyData <- dcast(dataMelt, subject_ID + activity_name ~ variable, mean)
str(tidyData)

# Write data 
write.table(tidyData, "./Data/tidyData.txt")
