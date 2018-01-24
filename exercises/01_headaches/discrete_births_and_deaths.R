## Discrete births and deaths model
## Last modified: Jan 24 2018

## Set a starting population
population <- 1000

## Define some time sequence
## Note: a more general version of this is:
##      time_seq <- seq(start = 1, end = 500, by = 1)
time_seq <- 1:500  

## Some parameters for births and deaths
birth_rate <- 0.4
death_rate <- 0.4

## Make a container to hold your results
dat <- NULL

## Now we are going to loop through our timesteps.
for (t in time_seq){ 
    
    ## Formula for your new population (relative to current time step)
    new_population <- population + round(birth_rate*population) - 
        round(death_rate*population)
    
    ## Bind this new population as a row (rbind) to the data 
    ## container we made earlier.
    dat <- rbind(dat, new_population)
    
    ## Now set your "new" population to your current population and move on
    ## to the next time step.
    population <- new_population
}

## Plot it
plot(dat[, 1], type = "l")
