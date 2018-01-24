## Differential equations of headaches (or non-infectious diseases)
## Last modified: Jan 24 2018

## Load deSolve so we can use the ode() command
library(deSolve)

## Set your time steps, initial values, parameters
times <- seq(0, 5000, by = 1)
yinit <- c(no_headache = 0.95, headache = 0.05)
parameters <- c(incidence = 0.02, recovery = 0.01, 
                birth = 0.1, death = 0.2)

## Create an ODE model -- the solver needs your model written as a function
## that takes in a vector of times, initial values, and parameters 
## (in that order) and returns a list with derivatives of your compartments 
## relative to time.
headache_model <- function(times, yinit, parameters) {
    with(as.list(c(yinit, parameters)), {
        
        ## Define your no headache compartment
        dno_headache <- recovery*headache - 
            incidence*no_headache - death*no_headache 
        
        ## Define your headache compartment
        dheadache <- incidence*no_headache - recovery*headache - 
            death*headache + birth*(headache+no_headache)
        
        ## Save your compartments into a new variable, as a list
        comparts <- list(c(dno_headache, dheadache))
        
        ## Don't forget you need to return your compartments
        return(comparts))
    })
}

## Run your model
result <- as.data.frame(ode(y = yinit, times = times, 
                            func = headache_model, parms = parameters))

## Plot it
matplot(x = result[, "time"], 
        y = result[, c("no_headache", "headache")], 
        type = "l")

## Try help(matplot) to find an option that will truncate the x-axis for you
## to help visualize these data better.
