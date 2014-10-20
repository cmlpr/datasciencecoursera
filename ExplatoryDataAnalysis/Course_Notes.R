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

########## LATTICE PLOTTING SYSTEM IN R ##########

# Good for plotting lots of plots at once

# lattice package:
# grid package: lattice is built on top of grid

# plot needs to be created at once
# no annotations

# Functions:
    # xyplot: this is the main function for creating scatter plots
    # bwplot: box and whisker plots
    # histogram: histograms
    # stripplot: like a boxplot but with actual data points
    # dotplot: plot dots on "violin strings"
    # splom : scatter plot matrix, like "pairs" in base plotting system
    # levelplot, contourplot: for plotting image data

# xyplot
xplot(y ~ x | f * g, data)
# we use the formula notation here, hence we use "~"
# On the left of the "~" is the y axis variable, on the right is the x axis
# f and g are conditioning variables (optional)
    # f and g are categorical variables
    # the "*" indicates an interaction between two variables
# The second argument is the data frame or list from which the vraibles
    # in the formula should be looked up
    # if no data frame or list is passed, then the parent frame is used
# If no other arguments are passed, there are defaults that can be used

library(lattice)
library(datasets)

#scatterplot
str(airquality)
xyplot(Ozone ~ Wind, data = airquality)

# simple lattice plot
# convert "Month" to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

# Lattice behaviour
    # Base graphics functions plot data directly to the graphics device
    # Lattice graphics functions return an object of class trellis
    # The print methods for lattice functions actually do the work of plotting
        # the data on the graphics device
    # Lattice functions return "plot objects" that can, in principle, be stored
        # but it's usually better to just save the code + data
    # On the command line, trellis objects are autoprinted so that it appears
        # the function is plotting the data


p <- xyplot(Ozone ~ Wind, data = airquality) ## Nothing happens
print(p) ## Plot appears

xyplot(Ozone ~ Wind, data = airquality) ## autoprinting

# Lattice have panel functions which controls what happens inside each panel
# The lattice package comes with default panel functions but can supply your
    # own if you want to customize what happens in each panel
# Panel functions receive the x-y coordinates of the data points
    # in their panel (along with optional arguments)

set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("Group 1", "Group 2"))
xyplot(y ~ x | f,layout = c(2,1)) # plot with 2 panels

## Custom panel function: add median line

xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) ## first call the default panel func for 'xyplot'
    panel.abline(h = median(y), lty = 2) ## add a horizontal line at the median
})

xyplot(y ~ x | f, panel = function(x, y, ...) {
    panel.xyplot(x, y, ...) ## first call the default panel func for 'xyplot'
    panel.lmline(x, y, col = 2) ## overlay a simple linear regression line
})



########## GGPLOT2 PLOTTING SYSTEM ##########

# Grammar of Graphics - Leland Wilkinson
# Hadley Wickham - During Iowa state years
# 3rd graphics system
# install.packages(ggplot2)
# http://ggplot2.org

# Grammar
    # Mapping
    # Aesthetic
    # Geometric
    # Stat graphic is a mapping from data to aesthetic attributes of geometric
        # objects

# Basic function qplot() # quick plot
    # Works much like the plot function in base plotting system
    # Looks for data in a data frame, simlat to lattice
    # Plots are made of aesthetics and geoms
    # Aesthetics size shape color
    # Geom : lines points
    # Factor variables are important: subset of data, they should be labeled
    # qplot() hides what goes on underneath
    # ggplot() is the core function and very flexible things qplot() cannot do


library(ggplot2)
str(mpg)
    # manufacturer, model, drv are all factor variables

qplot(displ, hwy, data = mpg) # basic
qplot(displ, hwy, data = mpg, color = drv) # modify aesthetics
qplot(displ, hwy, data = mpg, geom = c("point", "smooth")) # add geom - smooth
# smooth - grey band is the 95% conf interval

qplot(hwy, data = mpg, fill = drv) #histogram

# facets
# facets ~ > right determine the columns, left determines the rows
# there are no rows, so we used . 
qplot(displ, hwy, data = mpg, facets = . ~ drv)
# right hand side of ~ is a . > 1 column
qplot(hwy, data = mpg, facets = drv ~., binwidth = 2)

# histogram
qplot(log(x), data = data)
qplot(log(x), data = data, fill = y)

# density smooth
qplot(log(x), data = data, geom = "density")
qplot(log(x), data = data, geom = "density", color = z)

# scatter plot
qplot(log(x), log(y), data = data)
qplot(log(x), log(y), data = data, shape = y)
qplot(log(x), log(y), data = data, color = y)

# add smoothing
qplot(log(x), log(y), data = data, color = z, geom =c("point", "smooth"), 
                                                      method = "lm")

# split into facets
qplot(log(x), log(y), data = data, geom =c("point", "smooth"), method = "lm", 
      facets = . ~ z)


### Basic Components of ggplot2 Plot
    # A data frame
    # aesthetic mappings: how data are mapped to color and size
    # geoms: geometric objects like points, lines, shapes
    # facets: for conditioanl plots
    # stats: stat transformations like binning, quantiles, smoothing
    # scales: what scale an aesthetic map uses (ex: male = red, fem = blue)
    # coordinate system

# plots are built up in layers
    # Data
    # Overlay summary
    # Metadata and annotation

#qplot version
qplot(logpm25, NocturnalSympt, data = maacs, facets = . ~ bmicat, 
      geom =c("point", "smooth"), method = "lm")

g <- ggplot(maacs, aes(logpm25, NocturnalSympt)) # initial call to ggplot
summary(g) ## summary of ggplot object
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
print(g) # Error, no laers in plot
p <- g + geom_point()
print(p) # prints now

g + geom_point() + geom_smooth() #low s moother
g + geom_point() + geom_smooth(method = "lm") # linear model
g + geom_point() + facet_grid(. ~ bmicat) + geom_smooth(method = "lm")

# Annotation
    #Labels: xlab, ylab, ggtitle,
    # geom functions has options to modify
    # global - theme()
    # two general themes
    # theme_grey()
    # theme_bw()

#modify aesthetics
# assign to a constant
g + geom_point(color = "steelblue", size = 4, aplha = 1/2)
# assign to data variable
g + geom_point(aes(color = bmicat), size = 4, aplha = 1/2)

g + geom_point(aes(color = bmicat)) + 
    labs(title = "xx") + 
    labs(x = expression("log " * PM[2.5]), y = "xxx")

g + geom_point(aes(color = bmicat), size = 4, aplha = 1/2) + 
    geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

g + geom_point(aes(color = bmicat)) + 
    theme_bw(base_family = "Times")


### VERY IMPORTANT
# Notes about Axis limits

testdat <- data.frame(x= 1:100, y = rnorm(100))
testdat[50,2] <- 100 ## outlier
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))

g<- ggplot(testdat, aes(x = x, y = y))
g + geom_line()

# this eiminates the point
g + geom_line() + ylim(-3,3)
# this one only changes the axis cuts
g + geom_line() + coord_cartesian(ylim = c(-3, 3))


# More Complex Example

# cut function is very handy when creating factors

# calculate the deciles of the data
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, legth = 4), na.rm = TRUE)
# cut the data at the deciles and create a new factor variable
maacs$no2dec <- cut(maacs$logno2_new, cutpoints)
# see the levels of the newly created factor variable
levels(maacs$no2dec)

# setup ggplot2 with data frame
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
# add layers
g + geom_point(alpha = 1/3) +
    facet_wrap(bmicat ~ no2dec, nrow = 2, ncol = 4) +
    geom_smooth(method = "lm", se = FALSE, col = "steelblue") +
    theme_bw(base_family = "Avenir", base_size = 10) +
    labs(x = expression("log " * PM[2.5])) + 
    labs(y = "Nocturnal Symptoms") + 
    labs(title = "MAACS Cohort")


########## Plotting and Color in R ##########

# The default color schemes for most plots in R are horrendous
    # I don't have good taste and even I know that
# Recently there have been developments to improve the handling/specification
    # of colors in plots/graphs/etc
# There are functions in R and in external packages that are very handy

# Color Utilities in R
# The grDevices package has two functions
    # colorRamp
    # colorRampPalette
# These functions take palettes of colots and help to interpolate between the colors
# The function colors() lists the names of colors you can use in any plotting func
colors()

# colorRamp
    # Take a platte of colors and return an function that takes values between
    # o and 1, indicating the extremes of the color palette (e.g. see the gray function)
gray(0.5)

pal <- colorRamp(c("red", "blue"))
pal(0) #RGB = Red, Green, Blue
pal(1)
pal(0.5)

pal(seq(0, 1, len = 10))

# colorRampPalette
    # Take a platte of colors and return a function that takes integer
    # arguments and returns a vectir of colors interpolating the palette
    # like heat.colors, topo.colors

pal <- colorRampPalette(c("red", "yellow"))
pal(2) # will give 2 colors which are given to colorRampPalette function 
pal(10) # will give 10 colors including and in between the function arguments


## RColorBrewer Package

# One package on CRAN that contains interesting/useful color palettes
# There are 3 types of palettes
    # Sequential
    # Diverging - can be used to show deviations from mean
    # Qualitative - no order, may be factors, individual colors, categorical data

# Palatte information can be use in conjuction with the colorRamp() and 
    #colorRampPalette()

install.packages("RColorBrewer")
library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
cols
pal <- colorRampPalette(cols)
image(volcano, col = pal(8))

# The smoothScatter Function
# When you have a lot of scatter points, this function is very useful
# Creates 2D histogram and plots it
# Uses RColorBrewer package, default is blues palette

x <- rnorm(10000)
y <- rnorm(10000)
plot(x,y) # doesn't look good
smoothScatter(x, y) # uses KernSmooth function


# Some other plotting notes
# rgb function can be used to produce any volor via red, green and blue proportions
# Color transparency can be added via the alpha parameter to rgb
# The colorspace package can be used for a different control over colors

x <- rnorm(1000)
y <- rnorm(1000)
plot(x,y, pch = 19)
plot(x,y, pch = 19, col = rgb(0, 0, 0, 0.2))



########## Hierarchical Clustering ##########

# Can we find things that are close together?
# Clustering organizes things that are close into groups
    # How do we define close?
    # How do we group things?
    # How do we visualize the grouping?
    # How do we interpret the grouping?

# Google scholar: search cluster analysis

# Hierarchical clustering
    # An agglomerative approach
        # Find closest two things
        # Put them together
        # Find the next closest
    # Requires
        # A defined distance
        # A merging approach
    # Produces
        # A tree showing how close things are to each other

# How do we define close?
    # Most important step
        # Grabage in > garbage out
    # Distance or similarity
        # Continious - euclidean distance
        # Continious - correlation similarity
        # Binary - manhattan distance
    # Pick a distance/similarity that makes sense for your problem


# Euclidean distance
    # rafalab.jhsph.edu/688/lec/lecture5-clustering.pdf
    # e.g. calculate the line distance between two points
    # bird flight distance
    # sqrt((a1-a2)^2 + (b1-b2)^2 + ... + (z1-z2)^2)

# Manhattan distance
    # Zig-zag distance: like in a city
    # abs(a1-a2) + abs(b1-b2) + ... + abs(z1-z2)
    # en.wikipedia.org/wiki/Taxicab_geometry

# Hierarchical clustering - example

set.seed(1234)
par(mar = c(5,5,4,3))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# The first thing to do is to calculate the distance between points
# dist - function will calculate the distances
# Important parameters:x, method

dataFrame <- data.frame(x = x, y = y)
dist(dataFrame)
?dist
#default method is euclidean

# Apply clustering - hclust
?hclust

dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)
hClustering$labels
hClustering$height
hClustering$merge
hClustering$order

# Prettier Dendrograms
myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)), 
                      hang = 0.1, ...) {
    ## modifiction of plclust for plotting hclust objects *in colour*! Copyright
    ## Eva KF Chan 2009 Arguments: hclust: hclust object lab: a character vector
    ## of labels of the leaves of the tree lab.col: colour for the labels;
    ## NA=default device foreground colour hang: as in hclust & plclust Side
    ## effect: A display of hierarchical cluster with coloured leaf labels.
    y <- rep(hclust$height, 2)
    x <- as.numeric(hclust$merge)
    y <- y[which(x < 0)]
    x <- x[which(x < 0)]
    x <- abs(x)
    y <- y[order(x)]
    x <- x[order(x)]
    plot(hclust, labels = FALSE, hang = hang, ...)
    text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order],
         col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
}

dataFrame <- data.frame(x = x, y = y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
myplclust(hClustering)
myplclust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))


# Merging two points togeter
    # Average: Distance between centers of gravities of clusters 
    # Complete: Distance between the 2 farthest points among 2 clusters 

# Heatmap()
    # Good for large table, matrix 
    # Look at the large table in a simple way
    # Oragnizes the row and columns of the table for visualization using clustering
dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
heatmap(dataMatrix)

# Notes and further reseources
    # Gvies an idea of the relationships between variables/observations
    # The picture may be unstable
        # Change a few points
        # Have different missing values
        # Pick a different distance
        # Change the merging strategy
        # Change the scale of points for one variable
    # But it is deterministic
    # Choosing where to cut isn't always obvious
    # Should be primarily used for exploration
    # Rafa's distances and clustering video
        # http://www.youtube.com/watch?v=wQhVWUcXM0A
    # Elements of statistical learning




########## K-means Clustering ##########

# A partition approach
    # Fix a number of clusters
    # Get "centroids" of each cluster
    # Assign things to closest centroid
    # Recalculate centroids
# Requires
    # A defined distance metric
    # A number of clusters
    # An initial guess as to cluster centroids
# Produces
    # Final estimate of cluster centroids
    # An assignment of each point to cluster

# k-means clustering example

set.seed(1234)
#par(mar = c(0, 0, 0, 0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
plot(x, y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# Give an initial guess of cluster centroids
# Assign points to closest cluster
# Recalculate the centroids
# Reassign points to centroids
# Recalculate centroids again
# Update centroids
# .....

# kmeans()
# Important parameters: x, centers, iter.max, nstart

dataFrame <- data.frame(x, y)
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj$cluster
kmeansObj$centers
kmeansObj$totss
kmeansObj$withinss
kmeansObj$tot.withinss
kmeansObj$betweenss
kmeansObj$size
kmeansObj$iter
kmeansObj$ifault

#par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)

# Heatmaps
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12), ]
kmeansObj2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1))
image(t(dataMatrix)[, nrow(dataMatrix):1], yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj$cluster)], yaxt = "n")

#Notes and further resources
    # K-means requires a number of clusters
        # Pick by eye/intuition
        # Pick by cross validation/information theory, etc.
        # Determining the number of clusters
            # http://en.wikipedia.org/wiki/Determining_the_number_of_clusters_in_a_data_set
    # K-means is not deterministic
        # Different # of clusters
        # Different number of iterations    
    # Rafael Irizarry's Distances and Clustering Video
    # Elements of statistical learning




########## Dimension Reduction ##########

# Principal Component Analysis and Singular Value Decomposition

# Matrix data - Generate random data 
set.seed(12345)
par(mar = rep(0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])

# Cluster the data
par(mar = rep(0.2, 4))
heatmap(dataMatrix) # apply clustering but the result does not show a pattern

# What if we add a pattern?
set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coinFlip <- rbinom(1, size = 1, prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip) {
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
    }
}

# What if we add a pattern? - the data
par(mar = rep(0.2, 4))
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])

# What if we add a pattern? - the clustered data
par(mar = rep(0.2, 4))
heatmap(dataMatrix) # now there is a clear pattern

# Patterns in rows and columns - marginal averages - colomn and row means
hh <- hclust(dist(dataMatrix)) # apply clustering
dataMatrixOrdered <- dataMatrix[hh$order, ] # order the matrix bases on cluster
par(mfrow = c(1, 3)) 
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)

# Related problems
# You have multivariate variables X1,..., Xn so X1 = (X11,..., X1m)
    # Find a new set of multivariate variables that are uncorrelated and 
        # explain as much variance as possible.
    # If you put all the variables together in one matrix, find the best matrix 
        # created with fewer variables (lower rank) that explains the original data.
# The first goal is statistical and the second goal is data compression.

# Related solutions - PCA/SVD
# SVD
# If X is a matrix with each variable in a column and each observation in a row 
    # then the SVD is a "matrix decomposition"
        # X = UDVT
    # where the columns of U are orthogonal (left singular vectors), 
    # the columns of V are orthogonal (right singular vectors) and 
    # D is a diagonal matrix (singular values).

# PCA
# The principal components are equal to the right singular values if you first 
    # scale (subtract the mean, divide by the standard deviation) the variables.


# Components of the SVD - u and v
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd1$u[, 1], 40:1, , xlab = "Row", ylab = "First left singular vector",
     pch = 19)
plot(svd1$v[, 1], xlab = "Column", ylab = "First right singular vector", pch = 19)


# Components of the SVD - Variance explained
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of variance explained",
     pch = 19)

# Relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pca1$rotation[, 1], svd1$v[, 1], pch = 19, xlab = "Principal Component 1",
     ylab = "Right Singular Vector 1")
abline(c(0, 1))

# Components of the SVD - variance explained
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1),each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)


# What if we add a second pattern?
set.seed(678910)
for (i in 1:40) {
    # flip a coin
    coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
    coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
    # if coin is heads add a common pattern to that row
    if (coinFlip1) {
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), each = 5)
    }
    if (coinFlip2) {
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 5), 5)
    }
}
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]

# Singular value decomposition - true patterns
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rep(c(0, 1), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1")
plot(rep(c(0, 1), 5), pch = 19, xlab = "Column", ylab = "Pattern 2")

# v and patterns of variance in rows
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(svd2$v[, 1], pch = 19, xlab = "Column", ylab = "First right singular vector")
plot(svd2$v[, 2], pch = 19, xlab = "Column", ylab = "Second right singular vector")

# d and variance explained
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1, 2))
plot(svd1$d, xlab = "Column", ylab = "Singular value", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Percent of variance explained",
     pch = 19)

# Missing values
dataMatrix2 <- dataMatrixOrdered
## Randomly insert some missing data
dataMatrix2[sample(1:100, size = 40, replace = FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2)) ## Doesn't work!
## Error: infinite or missing values in 'x'

# Imputing {impute}
library(impute) ## Available from http://bioconductor.org
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100,size=40,replace=FALSE)] <- NA
dataMatrix2 <- impute.knn(dataMatrix2)$data #gets the knn and replace the missing point with the average value of the knn rows
svd1 <- svd(scale(dataMatrixOrdered)); svd2 <- svd(scale(dataMatrix2))
par(mfrow=c(1,2)); plot(svd1$v[,1],pch=19); plot(svd2$v[,1],pch=19)

# Face example
load("data/face.rda")
image(t(faceData)[, nrow(faceData):1])

# Face example - variance explained
svd1 <- svd(scale(faceData))
plot(svd1$d^2/sum(svd1$d^2), pch = 19, xlab = "Singular vector", ylab = "Variance explained")


# Face example - create approximations
svd1 <- svd(scale(faceData))
## Note that %*% is matrix multiplication
# Here svd1$d[1] is a constant
approx1 <- svd1$u[, 1] %*% t(svd1$v[, 1]) * svd1$d[1]
# In these examples we need to make the diagonal matrix out of d
approx5 <- svd1$u[, 1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[, 1:5])
approx10 <- svd1$u[, 1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[, 1:10])

# Face example - plot approximations
par(mfrow = c(1, 4))
image(t(approx1)[, nrow(approx1):1], main = "(a)")
image(t(approx5)[, nrow(approx5):1], main = "(b)")
image(t(approx10)[, nrow(approx10):1], main = "(c)")
image(t(faceData)[, nrow(faceData):1], main = "(d)") ## Original data

# Notes and further resources
# Scale matters
# PC's/SV's may mix real patterns
# Can be computationally intensive
# Advanced data analysis from an elementary point of view
    # http://www.stat.cmu.edu/%7Ecshalizi/ADAfaEPoV/ADAfaEPoV.pdf
# Elements of statistical learning
# Alternatives
    # Factor analysis
        # http://en.wikipedia.org/wiki/Factor_analysis
    # Independent components analysis
        # http://en.wikipedia.org/wiki/Independent_component_analysis
    # Latent semantic analysis
        # http://en.wikipedia.org/wiki/Latent_semantic_analysis


