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

### Distributions with increasing variance

library(ggplot2)
xvals <- seq(-10, 10, by = .01)
dat <- data.frame(
    y = c(
        dnorm(xvals, mean = 0, sd = 1),
        dnorm(xvals, mean = 0, sd = 2),
        dnorm(xvals, mean = 0, sd = 3),
        dnorm(xvals, mean = 0, sd = 4)
    ),
    x = rep(xvals, 4),
    factor = factor(rep(1 : 4, rep(length(xvals), 4)))
)
ggplot(dat, aes(x = x, y = y, color = factor)) + geom_line(size = 2)    


###Simulating from a population with variance 1

library(ggplot2)
nosim <- 10000; 
dat <- data.frame(
    x = c(apply(matrix(rnorm(nosim * 10), nosim), 1, var),
          apply(matrix(rnorm(nosim * 20), nosim), 1, var),
          apply(matrix(rnorm(nosim * 30), nosim), 1, var)),
    n = factor(rep(c("10", "20", "30"), c(nosim, nosim, nosim))) 
)
ggplot(dat, aes(x = x, fill = n)) + 
    geom_density(size = 2, alpha = .2) + 
    geom_vline(xintercept = 1, size = 2) 
# as we use more data we get concentrated around population variance


#### Standard normals have variance 1; means of n standard normals have standard deviation 1/sqrt(n)
    
nosim <- 1000
n <- 10
sd(apply(matrix(rnorm(nosim * n), nosim), 1, mean))
1 / sqrt(n)


#### Standard uniforms have variance 1/12; means of random samples of n uniforms have sd 1/sqrt(12n}

nosim <- 1000
n <- 10
sd(apply(matrix(runif(nosim * n), nosim), 1, mean))
1 / sqrt(12 * n)


#### Poisson(4) have variance 4; means of random samples of n Poisson(4) have sd $2/\sqrt{n}$
    
nosim <- 1000
n <- 10
sd(apply(matrix(rpois(nosim * n, 4), nosim), 1, mean))
2 / sqrt(n)
Simulation example

#### Fair coin flips have variance 0.25; means of random samples of n coin flips have sd 1 / (2 * sqrt{n})
    
nosim <- 1000
n <- 10
sd(apply(matrix(sample(0 : 1, nosim * n, replace = TRUE),
                nosim), 1, mean))
1 / (2 * sqrt(n))


#### Data example

library(UsingR); data(father.son); 
x <- father.son$sheight
n<-length(x)
 
#Plot of the son's heights

g <- ggplot(data = father.son, aes(x = sheight)) 
g <- g + geom_histogram(aes(y = ..density..), fill = "lightblue", binwidth=1, colour = "black")
g <- g + geom_density(size = 2, colour = "black")
g

# Let's interpret these numbers

round(c(var(x), var(x) / n, sd(x), sd(x) / sqrt(n)),2)

###Summarizing what we know about variances

# The sample variance estimates the population variance
# The distribution of the sample variance is centered at what its estimating
# It gets more concentrated around the population variance with larger sample sizes
# The variance of the sample mean is the population variance divided by $n$
# The square root is the standard error
# It turns out that we can say a lot about the distribution of averages from 
    #random samples, even though we only get one to look at in a given data set


#Law of large numbers in action

n <- 10000; means <- cumsum(rnorm(n)) / (1  : n); library(ggplot2)
g <- ggplot(data.frame(x = 1 : n, y = means), aes(x = x, y = y)) 
g <- g + geom_hline(yintercept = 0) + geom_line(size = 2) 
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

#Law of large numbers in action, coin flip

means <- cumsum(sample(0 : 1, n , replace = TRUE)) / (1  : n)
g <- ggplot(data.frame(x = 1 : n, y = means), aes(x = x, y = y)) 
g <- g + geom_hline(yintercept = 0.5) + geom_line(size = 2) 
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

#die rolling experiment

#Simulate a standard normal random variable by rolling $n$ (six sided)
#Let $X_i$ be the outcome for die $i$
#    Then note that $\mu = E[X_i] = 3.5$
#    $Var(X_i) = 2.92$
#    SE $\sqrt{2.92 / n} = 1.71 / \sqrt{n}$
#    Let's roll $n$ dice, take their mean, subtract off 3.5, and divide by $1.71 / \sqrt{n}$ and repeat this over and over

nosim <- 1000
cfunc <- function(x, n) sqrt(n) * (mean(x) - 3.5) / 1.71
dat <- data.frame(
x = c(apply(matrix(sample(1 : 6, nosim * 10, replace = TRUE), 
nosim), 1, cfunc, 10),
apply(matrix(sample(1 : 6, nosim * 20, replace = TRUE), 
nosim), 1, cfunc, 20),
apply(matrix(sample(1 : 6, nosim * 30, replace = TRUE), 
nosim), 1, cfunc, 30)
),
size = factor(rep(c(10, 20, 30), rep(nosim, 3))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(alpha = .20, binwidth=.3, colour = "black", aes(y = ..density..)) 
g <- g + stat_function(fun = dnorm, size = 2)
g + facet_grid(. ~ size)


#Coin CLT

# Let $X_i$ be the $0$ or $1$ result of the $i^{th}$ flip of a possibly unfair coin
# The sample proportion, say $\hat p$, is the average of the coin flips
# $E[X_i] = p$ and $Var(X_i) = p(1-p)$
#     Standard error of the mean is $\sqrt{p(1-p)/n}$
#     Then $$ \frac{\hat p - p}{\sqrt{p(1-p)/n}} $$ will be approximately normally distributed
# Let's flip a coin $n$ times, take the sample proportion of heads, subtract off .5 and multiply the result by $2 \sqrt{n}$ (divide by $1/(2 \sqrt{n})$)

#Simulation results

nosim <- 1000
cfunc <- function(x, n) 2 * sqrt(n) * (mean(x) - 0.5) 
dat <- data.frame(
  x = c(apply(matrix(sample(0:1, nosim * 10, replace = TRUE), 
                     nosim), 1, cfunc, 10),
        apply(matrix(sample(0:1, nosim * 20, replace = TRUE), 
                     nosim), 1, cfunc, 20),
        apply(matrix(sample(0:1, nosim * 30, replace = TRUE), 
                     nosim), 1, cfunc, 30)
        ),
  size = factor(rep(c(10, 20, 30), rep(nosim, 3))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(binwidth=.3, colour = "black", aes(y = ..density..)) 
g <- g + stat_function(fun = dnorm, size = 2)
g + facet_grid(. ~ size)

#Simulation results, $p = 0.9$
    
nosim <- 1000
cfunc <- function(x, n) sqrt(n) * (mean(x) - 0.9) / sqrt(.1 * .9)
dat <- data.frame(
    x = c(apply(matrix(sample(0:1, prob = c(.1,.9), nosim * 10, replace = TRUE), 
                       nosim), 1, cfunc, 10),
          apply(matrix(sample(0:1, prob = c(.1,.9), nosim * 20, replace = TRUE), 
                       nosim), 1, cfunc, 20),
          apply(matrix(sample(0:1, prob = c(.1,.9), nosim * 30, replace = TRUE), 
                       nosim), 1, cfunc, 30)
    ),
    size = factor(rep(c(10, 20, 30), rep(nosim, 3))))
g <- ggplot(dat, aes(x = x, fill = size)) + geom_histogram(binwidth=.3, colour = "black", aes(y = ..density..)) 
g <- g + stat_function(fun = dnorm, size = 2)
g + facet_grid(. ~ size)


#Give a confidence interval for the average height of sons

#in Galton's data

library(UsingR);data(father.son); x <- father.son$sheight
(mean(x) + c(-1, 1) * qnorm(.975) * sd(x) / sqrt(length(x))) / 12


# Binomial interval

.56 + c(-1, 1) * qnorm(.975) * sqrt(.56 * .44 / 100)
binom.test(56, 100)$conf.int
Simulation

n <- 20; pvals <- seq(.1, .9, by = .05); nosim <- 1000
coverage <- sapply(pvals, function(p){
    phats <- rbinom(nosim, prob = p, size = n) / n
    ll <- phats - qnorm(.975) * sqrt(phats * (1 - phats) / n)
    ul <- phats + qnorm(.975) * sqrt(phats * (1 - phats) / n)
    mean(ll < p & ul > p)
})


# Simulation

#First let's show that coverage gets better with $n$

n <- 100; pvals <- seq(.1, .9, by = .05); nosim <- 1000
coverage2 <- sapply(pvals, function(p){
phats <- rbinom(nosim, prob = p, size = n) / n
ll <- phats - qnorm(.975) * sqrt(phats * (1 - phats) / n)
ul <- phats + qnorm(.975) * sqrt(phats * (1 - phats) / n)
mean(ll < p & ul > p)
})

#Plot of coverage for $n=100$

ggplot(data.frame(pvals, coverage), aes(x = pvals, y = coverage2)) + geom_line(size = 2) + geom_hline(yintercept = 0.95)+ ylim(.75, 1.0)

#Simulation

#Now let's look at $n=20$ but adding 2 successes and failures

n <- 20; pvals <- seq(.1, .9, by = .05); nosim <- 1000
coverage <- sapply(pvals, function(p){
    phats <- (rbinom(nosim, prob = p, size = n) + 2) / (n + 4)
    ll <- phats - qnorm(.975) * sqrt(phats * (1 - phats) / n)
    ul <- phats + qnorm(.975) * sqrt(phats * (1 - phats) / n)
    mean(ll < p & ul > p)
})

#Adding 2 successes and 2 failures

#(It's a little conservative)
 
 ggplot(data.frame(pvals, coverage), aes(x = pvals, y = coverage)) + geom_line(size = 2) + geom_hline(yintercept = 0.95)+ ylim(.75, 1.0)
 Poisson interval
 
#A nuclear pump failed 5 times out of 94.32 days, give a 95% confidence interval for the failure rate per day?
# $X \sim Poisson(\lambda t)$.
# Estimate $\hat \lambda = X/t$
# $Var(\hat \lambda) = \lambda / t$
# $\hat \lambda / t$ is our variance estimate

#R code
 
 x <- 5; t <- 94.32; lambda <- x / t
 round(lambda + c(-1, 1) * qnorm(.975) * sqrt(lambda / t), 3)
 poisson.test(x, T = 94.32)$conf
 Simulating the Poisson coverage rate
 
# Let's see how this interval performs for lambda values near what we're estimating
 
 lambdavals <- seq(0.005, 0.10, by = .01); nosim <- 1000
 t <- 100
 coverage <- sapply(lambdavals, function(lambda){
 lhats <- rpois(nosim, lambda = lambda * t) / t
 ll <- lhats - qnorm(.975) * sqrt(lhats / t)
 ul <- lhats + qnorm(.975) * sqrt(lhats / t)
 mean(ll < lambda & ul > lambda)
 })
 
#Covarage
 
# (Gets really bad for small values of lambda)
 
 ggplot(data.frame(lambdavals, coverage), aes(x = lambdavals, y = coverage)) + geom_line(size = 2) + geom_hline(yintercept = 0.95)+ylim(0, 1.0)
 
#What if we increase t to 1000?
 
 lambdavals <- seq(0.005, 0.10, by = .01); nosim <- 1000
 t <- 1000
 coverage <- sapply(lambdavals, function(lambda){
 lhats <- rpois(nosim, lambda = lambda * t) / t
 ll <- lhats - qnorm(.975) * sqrt(lhats / t)
 ul <- lhats + qnorm(.975) * sqrt(lhats / t)
 mean(ll < lambda & ul > lambda)
 })
 ggplot(data.frame(lambdavals, coverage), aes(x = lambdavals, y = coverage)) + geom_line(size = 2) + geom_hline(yintercept = 0.95) + ylim(0, 1.0)
 
#Summary
 
# The LLN states that averages of iid samples converge to the population means that they are estimating
# The CLT states that averages are approximately normal, with distributions
    # centered at the population mean
    # with standard deviation equal to the standard error of the mean
    # CLT gives no guarantee that $n$ is large enough
# Taking the mean and adding and subtracting the relevant normal quantile times the SE yields a confidence interval for the mean
    # Adding and subtracting 2 SEs works for 95% intervals
# Confidence intervals get wider as the coverage increases (why?)
# Confidence intervals get narrower with less variability or larger sample sizes
# The Poisson and binomial case have exact intervals that don't require the CLT
    # But a quick fix for small sample size binomial calculations is to add 2 successes and failures




### Swirl

library(swirl)
install_from_swirl("Statistical Inference")
swirl()

