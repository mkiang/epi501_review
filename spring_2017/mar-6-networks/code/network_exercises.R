## Uncomment and install these if you don't already have them
# install.packages("network")
# install.packages("tidyverse")

## Load the libraries (install if necessary)
library(network)
library(tidyverse)

## Load up a modified network simulation function -- it will run exactly as
## before, except I've now added an extra parameter (start_infected) that
## allows you to specify which node should be the first infected.
source('./code/network_practical.R')

## Load up data (make sure you have the right file path)
mat1 <- read_csv('./data/unnamed_contact_network.csv', trim_ws = TRUE)

## Convert the matrix into a network
net1 <- as.network(mat1, directed = FALSE)

## Take a look at the network
plot(net1, label = network.vertex.names(net1))

## Plot the degree distribution
deg <- NULL
for(i in 1:network.size(net1)) {
    deg <- rbind(deg, length(get.neighborhood(net1, i))) 
}
hist(deg)

## This just loops through n_sims times and makes that many lines/simulations
## NOTE: There's a difference between matplot and matlines
n_sims <- 500
for (i in 1:n_sims) {
    sim <- networkPractical(net1, .2, .2, runTime = 50)
    ## If it is the first simulation, we need to create the plot canvas
    if (i == 1) {
        matplot(sim$timeSeries, lty = 1, type = "l", xlim = c(0, 50), 
                ylim = c(0, network.size(net1)), col = alpha(1:3, .15))
    ## If it is not the first one, we just draw on top of the existing canvas
    } else {
        matlines(sim$timeSeries, lty = 1, type = "l", col = alpha(1:3, .15))
    }
}

## This just loops through n_sims times and makes that many lines/simulations
## NOTE: There's a difference between matplot and matlines
n_sims <- 2000
for (i in 1:n_sims) {
    sim <- networkPractical(net1, .2, .2, runTime = 50, start_infected = 7)
    sim2 <- networkPractical(net1, .2, .2, runTime = 50, start_infected = 10)
    ## If it is the first simulation, we need to create the plot canvas
    if (i == 1) {
        matplot(sim$timeSeries[, 2], lty = 1, type = "l", xlim = c(0, 50), 
                ylim = c(0, 40), col = alpha(3, .03))
        matlines(sim2$timeSeries[, 2], lty = 1, type = "l", 
                 col = alpha(2, .03))
    ## If it is not the first one, we just draw on top of the existing canvas
    } else {
        matlines(sim$timeSeries[, 2], lty = 1, type = "l", col = alpha(3, .03))
        matlines(sim2$timeSeries[, 2], lty = 1, type = "l", 
                 col = alpha(2, .03))
    }
}
