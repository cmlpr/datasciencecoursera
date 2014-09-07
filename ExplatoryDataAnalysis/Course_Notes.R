###############################################################################
############################ EXPLATORY DATA ANALYSIS ##########################
###############################################################################

########## Principles of Analytic Graphics ##########

# Edward Tufte (2006) : Beautiful Evidence,  Graphics Press LLC

# Principle 1 : Show comparisons
    # Evidence for a hypothesis is always relative to another competing hypothesis
    # Always ask "Compared to What?"

# Principle 2 : Show causality, mechanism, explanation, systematic structure
    # What is your causal framework for thinking about a question?

# Principle 3 : Show multivariate 
    # Multivariate = more than 2 variables
    # The real world is multivariate
    # Need to "escape flatland"

# Principle 4 : Integration of evidence
    # Completely integrate words, numbers, images, diagrams
    # Data graphics should make use of many modes of data presenation
    # Don't let the tool drive the analysis

# Principle 5 : DEscribe and document the evidence with appropriate labels
    #scales, sources, etc
    # A datagraphic should tell a complete story that is credible

# Principle 6 : Content is king
    # Analytical presentations ultimately stand or fall depending on the quality,
        # relevance, and integrity of their content

########## Exploratory Graphs ##########

# Why do we use graphs in data analysis?
    # To understand data properties
    # To find patterns in data
    # To suggest modeling strategies
    # To "debug" analysis
    # To communicate results

# Characteristics of explatory graphs
    # They are made quickly
    # A large number are made
    # The goal is personal understanding
    # Axes/leends are generally cleaned up later
    # Color size are primarily used for information

# Air pollutin in the US
    # The US Environmental Protection Agency (EPA) sets national ambient air
        # quality standars for outdoor air pollution
    # For fine particle pollution (PM2.5), the annual mean, averaged over 3
        # years cannot exeed 12microgram/m3
    # Data on daily PM2.5 are available from the US EPA web site
    # Question: Are there any counties in the US that exceed that national
        # standar for fine particle pollution?

getwd()
setwd("/Users/cemalperozen/Documents/Repos/datasciencecoursera/ExplatoryDataAnalysis")
dir()
?unzip
unzip("Data/PM25data.zip", exdir = "Data/")
dir('Data/data')

# Data 
    # Annual average PM2.5 averaged over the period 2008 through 2010
    # Do any countries exceed the standard of 12 micrograms/m3?

pollution <- read.csv("Data/data/avgpm25.csv", 
            colClasses = c("numeric","character", "factor", "numeric", "numeric"))

head(pollution)

# One dimension
    # five-number summary
    # box plots
    # histograms
    # density plots
    # bar plots

#summary
summary(pollution$pm25)

#boxplot
boxplot(pollution$pm25, col = "blue")
abline(h = 12) # add a horizontal line to show the national limit

#histogram
hist(pollution$pm25, col = "green")
rug(pollution$pm25) #plots all the points underneath the hist, helpful

#change the breaks
hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25) #plots all the points underneath the hist, helpful

hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

#barplot
barplot(table(pollution$region), col = "wheat", 
        main = "Number of Counties in Each Region")


# Two dimensions
    # Multiple/overlayed 1-D plots (Lattice/ggplot2)
    # scatterplots
    # smooth scatterplots

# 2 dimensions
    # Overlayed/multiple 2-D plots; coplots
    # Use color, size, shape to add dimensions
    # spinning plots
    # actual 3-D plots (not useful)

# multiple boxplots
boxplot(pm25 ~ region, data = pollution, col = "red")

# multiple histograms
par(mfrow = c(2,1), mar = c(4,4,2,1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

# scatter plot
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

# Scatter plot using color
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)

# multiple scatterplots

par(mfrow = c(1, 2), mar = c(5,4,2,1))
with(subset(pollution, region = "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region = "east"), plot(latitude, pm25, main = "East"))


########## Plotting Systems in R ##########

# Base Plotting System
    # Artists platte model
    # Start with blank canvas and build up from there
    # Start with plot function (or similar)
    # Use annotation functions to add/modify text, lines, points, axis
    
    # Convenient, mirrors how we think of building plots and analyzing data
    # Can't go back once plot has sarted (i.e adjust margins); need to plan in advance
    # Difficult to "translate" to others once a new plot has been created 
        # no graphical language
    # Plot is just a series of R commands

library(datasets) 
data(cars)
with(cars, plot(speed, dist))

# The Lattice Plotting System
    # Plots are created with a single function call(xyplot, bwplot,..)
    # Most useful for conditioning types of plots
        # Looking for how y changes with x across levels of z
    # Things like margins/spacing set automatically
        # bacause entire plot is specified at once
    # Good for putting many many plots on screen
    # Sometimes called "panel" plots

    # Sometimes awkeward to specify an entire plot in a single functionc call
    # Annotation in plot is not escpecially intuitive
    # Use of panel functions and subscripts difficult to wield, and
        # requires intense preparation
    # Cannot "add" to the plot once it is created

library(lattice)
state <- data.frame(state.x77, region = state.region)

xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

# The ggplot2 System
    # Splits the difference between base and lattice in a number of ways
    # Automatically deals with spacings, text, titles but allows you to
        #annotate by "adding" to a plot
    # Superficial similarity to lattice but generally easier/more intuitive
    # Default mode makes many choces for you

install.packages("ggplot2")

library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)


########## Base Plotting System ##########

# Core plotting engine:
# graphics package: contains plotting functions for the "base" graphing systems
    #including plot, hist, boxplot...
# grDevices package: contains all the code implementing the various graphics
    #devices, including X11, PDF, PostScript, PNG, etc

# Lattice plotting system:
# lattice package: contains code for poducing Trellis graphics
    # which are independent of the "base" graphics system
    # includes functions like xyplot, bqplot, levelplot
# grid package: implements a different graphing system independent of the base
    # system, the lattice package build on top of grid
    # we selcom call functions from the grid package directly

# The process of making a plot
    # Where will the plot be made? on the screen or in a file
    # Hwo will the plot be used?
        # Is the plot for viewing temporarily on screen?
        # Will it be presented in a web browser?
        # Will it eventually end up in a paper that might be printed?
        # Are you using it in a presentation?
    # Is there a large amount of data going into the plot? 
        # Or is it just a few points?
    # Do you need to be able to dynamically resize the graphics?

# Here we will be using the base plotting system to create graphics on screen device

# Base graphics:
    # Initialize a new plot
    # Annotate (adding to) an existing plot
# Calling plot(x,y) or hist() will launch a graphics device and draw a new plot
    # on the device
# arguments for plot 
?par

library(datasets)
# default hist
hist(airquality$Ozone) 
# default scatterplot
with(airquality, plot(Wind, Ozone)) 
# boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

# Key parameters:
# pch : plotting symbol (open circle) - number or character
# lty : the line type (default is solid line), can be dashed, dotted
# lwd : line width, integer multipled
# col : color, specified as number, string, hex code
    color () #this fucntions give a vector of colors
# xlab : char string x axis label
# ylab :

par() # specify global graphics parameters, will be similar in all plots in an R session

# las : orientation of the axis labels
# bg : background color
# mar : margin size
# oma : the outer margin size
# mfrow : number of plots per row
# mfcol : number of plots per col

# to see the defaults
par("lty")
par("col")
par("pch")
par("bg")
par("mar") #starts from "bottom" and goes clockwise
par("mfrow")

# Key functions
plot #makes scatterplots
lines # adds to a plot, given a vector x values and corresponding y values
points # add points
text # add text labels to a plit using specified x, y coordinates
titile # add annotations to x, y axis labels, title, subtitle, outer margin
mtext # add arbitrary text to the margins of the plot
axis # adding axis ticks/labels

library(datasets)
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and Wind in NYC") # add title

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue")) #re add blue points

# type n plots everything but the data
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other"))

#regression line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in NYC", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

# Multipled Base Plots
par(mfrow = c(1,2))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

par(mfrow = c(1,3), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main = "Ozone and Temperature")
    mtext("Ozone and Weather in NYC", outer = TRUE)
})

x <- rnorm(100)
hist(x)
y <- rnorm(100)
plot(x, y)
z <- rnorm(100)
plot(x, z)
plot(x, y)
par(mar = c(2, 2, 2, 2))
plot(x, y)
par(mar = c(4, 4, 2, 2))
plot(x, y)
plot(x, y, pch = 20)
plot(x, y, pch = 17)
title("Scatterplot")
text(-2, -2, "Label")
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit)
abline(fit, lwd = 3)
abline(fit, lwd = 3, col = "blue")
plot(x, y, xlab = "Weight", ylab = "Height", main = "Scatter", pch = 20)
legend("topleft", legend = "Data", pch = 20)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "red")

z <- rpois(100,2)
par(mfrow = c(2,1))
plot(x, y, pch = 20)
plot(x, z , pch = 19)

par("mar")
par(mar = c(2,2,1,1))
plot(x, y, pch = 20)
plot(x, z, pch = 20)

par(mfrow = c(1, 2))
plot(x, y, pch = 20)
plot(x, z, pch = 19)

par(mar = c(4,4,2,2))
plot(x, y, pch = 20)
plot(x, z, pch = 19)

par(mfrow = c(2, 2))
plot(x, y)
plot(x, z)
plot(z, x)
plot(y, x)

par(mfcol = c(2, 2))
plot(x, y)
plot(x, z)
plot(z, x)
plot(y, x)

par(mfrow = c(1, 1))
x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2,50)
g <- gl(2, 50, labels = c("Male", "Female"))
str(g)
plot(x,y)
plot(x, y, type = "n")
points(x[g == "Male"], y[g == "Male"], col = "green")
points(x[g == "Female"], y[g == "Female"], col = "blue", pch = 19)


########## Graphics Devices in R ##########

# Agraphics device is something where you can make a plot appear
# A window on your computer (screen device)
# A PDF file (file device)
# A PNG or JPEG file (file device)
# A scalable vector graphics (SVG) file (File device)

# When you make a plot in R, it has to be "sent" to a specific gaphics device

# The most common place for a plot to be sent is the screen device
# On a MAC the screen device is launched with the quartz()
# On Windows the screen device is launched with windows()
# On Linux/Unix the screen device is launched with x11()

?Devices

# file device
pdf(file = "myplot.pdf") # open PDF device and create myplot.pdf 
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Gayser data")
dev.off() # close the device

# Vector Formats # scalable
# pdf # not very efficient if a plot has many objects/points
# svg # support animation, useful for web
# win.metafile #only windows
# postscript # older format

# Bitmap # series pixels
# png  #good for drawings, images with solid colors, uses lossless compression
        # good for web browsers, good for many many points, does not resize well
# jpeg  # good for photos, uses lossy compression, good for plotting many points
        # does not resize well, not great for line drawings
# tiff  # supports lossless compression
# bmp   # a native Windows format

# Possible to open multiple graphics devices
# Plotting can occur on one graphics device at a time
dev.cur() # curently active graphics device
# every open graphics device is assigned an integer >= 2
dev.set(<integer>) # change the graphics device

# Copying a plot to another device can be useful 
dev.copy # copy a plot from one device to another
dev.copy2pdf # specifially copy a plot to a PDF file

# Copying is not an exact operation

library(datasets)
with(faithful, plot(eruptions, waiting))
dev.copy(png, file = "geyserplot.png")
dev.off()

########## P ##########


########## P ##########

