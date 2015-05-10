##### STATISTICAL INFERENCE #####

### Probability

# Prob density function for a hypothetical problem
x <- c(-0.5, 0, 1, 1, 1.5); y <- c( 0, 0, 2, 0, 0)
plot(x, y, lwd = 3, frame = FALSE, type = "l")

# Probability that the the number is below 75%. 
plot(x, y, lwd = 3, frame = FALSE, type = "l")
polygon(c(0, .75, .75, 0), c(0, 0, 1.5, 0), lwd = 3, col = "lightblue")

1.5 * .75 / 2
# or we can use the beta distribution given in R
# probability that 75% of the cases happen is 56.25%
pbeta(.75, 2, 1)

pbeta(c(0.4, 0.5, 0.6), 2, 1)

# 50% quantile = number which will corresponds to 50% of the distribution
# or simply population median of the distribution
qbeta(0.5, 2, 1)

install.packages("UsingR")
library(UsingR); data(galton); library(ggplot2)
library(reshape2)
longGalton <- melt(galton, measure.vars = c("child", "parent"))
g <- ggplot(longGalton, aes(x = value)) + 
    geom_histogram(aes(y = ..density..,  fill = variable), 
                   binwidth=1, colour = "black") + geom_density(size = 2)
g <- g + facet_grid(. ~ variable)
g

install.packages("manipulate")
library(manipulate)
library(ggplot2)
myHist <- function(mu){
    g <- ggplot(galton, aes(x = child))
    g <- g + geom_histogram(fill = "salmon", binwidth=1, 
                            aes(y = ..density..), colour = "black")
    g <- g + geom_density(size = 2)
    g <- g + geom_vline(xintercept = mu, size = 2)
    mse <- round(mean((galton$child - mu)^2), 3)  
    g <- g + labs(title = paste('mu = ', mu, ' MSE = ', mse))
    g
}
manipulate(myHist(mu), mu = slider(62, 74, step = 0.5))

# Facts about expected values

# Recall that expected values are properties of distributions
# Note the average of random variables is itself a random variable and its associated distribution has an expected value
# The center of this distribution is the same as that of the original distribution
# Therefore, the expected value of the sample mean is the population mean that it's trying to estimate
# When the expected value of an estimator is what its trying to estimate, we say that the estimator is unbiased
# Let's try a simulation experiment
# Simulating normals with mean 0 and variance 1 versus averages of 10 normals from the same population
nosim <- 10000; n <- 10
dat <- data.frame(
    x = c(rnorm(nosim), apply(matrix(rnorm(nosim * n), nosim), 1, mean)),
    what = factor(rep(c("Obs", "Mean"), c(nosim, nosim))) 
)
ggplot(dat, aes(x = x, fill = what)) + geom_density(size = 2, alpha = .2);

# Averages of x die rolls
dat <- data.frame(
    x = c(sample(1 : 6, nosim, replace = TRUE),
          apply(matrix(sample(1 : 6, nosim * 2, replace = TRUE), 
                       nosim), 1, mean),
          apply(matrix(sample(1 : 6, nosim * 3, replace = TRUE), 
                       nosim), 1, mean),
          apply(matrix(sample(1 : 6, nosim * 4, replace = TRUE), 
                       nosim), 1, mean)
    ),
    size = factor(rep(1 : 4, rep(nosim, 4))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(alpha = .20, binwidth=.25, colour = "black") 
g + facet_grid(. ~ size)

# Averages of x coin flips
dat <- data.frame(
    x = c(sample(0 : 1, nosim, replace = TRUE),
          apply(matrix(sample(0 : 1, nosim * 10, replace = TRUE), 
                       nosim), 1, mean),
          apply(matrix(sample(0 : 1, nosim * 20, replace = TRUE), 
                       nosim), 1, mean),
          apply(matrix(sample(0 : 1, nosim * 30, replace = TRUE), 
                       nosim), 1, mean)
    ),
    size = factor(rep(c(1, 10, 20, 30), rep(nosim, 4))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(alpha = .20, binwidth = 1 / 12, colour = "black"); 
g + facet_grid(. ~ size)

##Sumarizing what we know
#Expected values are properties of distributions
#The population mean is the center of mass of population
#The sample mean is the center of mass of the observed data
#The sample mean is an estimate of the population mean
#The sample mean is unbiased
#The population mean of its distribution is the mean that it's trying to estimate
#The more data that goes into the sample mean, the more concentrated its density / mass function is around the population mean

x <- 2:5
p <- (1:4)/10
sum(p)
rbind(x,p)
sum(x^2*p) - sum(x*p)^2

### Swirl

library(swirl)
install_from_swirl("Statistical Inference")
swirl()

