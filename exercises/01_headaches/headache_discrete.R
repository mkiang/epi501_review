## Headache example: discrete model of a non-infectious process
## Last modified: Jan 24 2018

## Let's set some initial values and parameters
N_t <- 500      # Number of people without a headache at time zero
P_t <- 0        # Number of people with a headache at time zero
incidence <- 0.05  # Probability of going from {No Headache} to {Headache}
recovery <- 0.9    # Probability of going from {Headache} to {No Headache}

## Again, we make a data container
dat <- NULL

## Make a sequence of time steps
timesteps <- 1:100  ## Or, equivalently, seq(1, 100, 1)

## Loop through our sequence of time steps
for (t in timesteps){
    
    ## Calculate the number of unaffected at time t + 1
    N_t1 <- N_t - round(incidence*N_t) + round(recovery*P_t) 
    
    ## Calculate the number of affected at time t + 1
    P_t1 <- P_t + round(incidence*N_t) - round(recovery*P_t)
    
    ## Bind these numbers as a new row (rbind) in our data container
    dat <- rbind(dat, c(N_t1, P_t1)) 
    
    ## Update the unaffected and affect for the next time step
    N_t <- N_t1 
    P_t <- P_t1 
}

## Plot it 
matplot(dat, xlab="time", ylab="number of people", type="l", lty = 1)
legend("topright", col = 1:2, legend = c("no headache","headache"), lwd=1)
