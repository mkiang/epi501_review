## EPI 501: Differential equations of headaches (or non-infectious diseases)

## Load deSolve
library(deSolve)

## Set your initial values
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
        
        ## Don't forget you need to return your compartments
        return(list(c(dno_headache, dheadache)))
    })
}

## Run your model
result <- as.data.frame(ode(y = yinit, times = times, 
                            func = headache_model, parms = parameters))
