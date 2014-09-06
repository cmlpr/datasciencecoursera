# Question 4
# If I execute the expression x <- 4 in R, what is the class of the object `x' 
  #as determined by the `class()' function?
x <- 4
x
class(x)
#numeric

# Question 5
# What is the class of the object defined by x <- c(4, TRUE)?
x <- c(4, TRUE)
class(x)
#numeric

# Question 6
# If I have two vectors x <- c(1,3, 5) and y <- c(3, 2, 10), what is produced 
  #by the expression cbind(x, y)?
x <- c(1,3,5)
y <- c(3,2,10)
cbind(x,y)
#matrix - 2 col, 3 row

# Question 8
# Suppose I have a list defined as x <- list(2, "a", "b", TRUE). 
  #What does x[[2]] give me?
x <- list(2, "a", "b", TRUE)
x[[2]]
class(x[[2]])
attributes(x[[2]])
# a char vector with length 1

# Question 9
# Suppose I have a vector x <- 1:4 and y <- 2:3. 
  #What is produced by the expression x + y?
x <- 1:4
y <- 2:3
x + y
# an integer vector with values 3, 5, 5, 7

# Question 10
# Suppose I have a vector x <- c(3, 5, 1, 10, 12, 6) and I want to set all elements 
  #of this vector that are less than 6 to be equal to zero. 
  #What R code achieves this?
#method 1
x <- c(3,5,1,10,12,6)
x[x<6] <- 0
x
#method 2
x <- c(3,5,1,10,12,6)
x[x %in% 1:5] <- 0
x

# Question 11
# In the dataset provided for this Quiz, what are the column names of the dataset?
dir()
?unzip
unzip("Data/quiz1_data.zip", exdir = "Data")
dir("Data")
head(read.csv("Data/hw1_data.csv"))
data <- read.csv("Data/hw1_data.csv")
data
names(data)
# [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"  

# Question 12
# Extract the first 2 rows of the data frame and print them to the console. 
  #What does the output look like?
data[1:2,]
#Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2

# Question 13
# How many observations (i.e. rows) are in this data frame?
nrow(data)
#153

# Question 14
# Extract the last 2 rows of the data frame and print them to the console. 
  #What does the output look like?
tail(data,2)
#Ozone Solar.R Wind Temp Month Day
#152    18     131  8.0   76     9  29
#153    20     223 11.5   68     9  30

# Question 15
# What is the value of Ozone in the 47th row?
data$Ozone[47]
#21

# Question 16
# How many missing values are in the Ozone column of this data frame?
data$Ozone
# Method 1
clean.Ozone <- data$Ozone[!is.na(data$Ozone)]
clean.Ozone
length(data$Ozone) - length(clean.Ozone)
# Method 2
clean.Ozone <- na.omit(data$Ozone)
#37

# Question 17
# What is the mean of the Ozone column in this dataset? Exclude missing values 
  #(coded as NA) from this calculation.
mean(data$Ozone)
#NA
mean(data$Ozone, na.rm = TRUE)
# 42.12931

# Question 18
# Extract the subset of rows of the data frame where Ozone values are above 31 
  #and Temp values are above 90. What is the mean of Solar.R in this subset?
subset <- data[which(data$Ozone > 31 & data$Temp > 90), ]
subset
mean(subset$Solar.R, na.rm = T)
#212.8
mean(data[which(data$Month == 6), ]$Temp)
#79.1

# Question 20
# What was the maximum ozone value in the month of May (i.e. Month = 5)?
max(data[which(data$Month == 5), ]$Ozone, na.rm = TRUE)
#115



