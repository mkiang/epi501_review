## Code for the worksheet that was given out on 1/30
library(deSolve)

parms <- c(beta = 0.75, k = 12 , r = 1)
inits <- c(S = 999999, I = 1, R = 0)
dt <- seq(0, 10, 1/7)

SIR <- function(t, x, parms){
    with(as.list(c(parms, x)), {
        
        N <- S + I + R
        dS <- - (beta * k * S * I) / N
        dI <- + (beta * k * S * I) / N - r * I
        dR <- r * I
        
        der <- c(dS, dI, dR)
        
        return(list(der))
    }) 
}

simulation <- as.data.frame(ode(y = inits, times = dt,
                                func = SIR, parms = parms))

matplot(x = simulation[, 1], y = simulation[, 2:4], type = "l", 
        lty = 1, xlab = "Time (weeks)", ylab = "People (count)", 
        main = "Measles")
legend(x = "right", legend = c('S', 'I', 'R'), 
       col = 1:3, lty = 1)

## NOTE: We could have done ANY arbitrary time scale. Let's do days.
## Note that k and r get scaled by 7 since there are 7 days in a week
parms <- c(beta = 0.75, k = 12/7 , r = 1/7)
inits <- c(S = 999999, I = 1, R = 0)
dt <- seq(0, 10 * 7, 1)

simulation_days <- as.data.frame(ode(y = inits, times = dt,
                                     func = SIR, parms = parms))

matplot(x = simulation[, 1], y = simulation[, 2:4], type = "l", 
        lty = 1, xlab = "Time (days)", ylab = "People (count)", 
        main = "Measles")
legend(x = "right", legend = c('S', 'I', 'R'), 
       col = 1:3, lty = 1)

## Compare the two datasets
head(cbind(simulation, simulation_days))

## Mumps and chickenpox exercise
parms_mumps <- c(beta = 0.38, k = 12 , r = 1)
parms_cpox <- c(beta = .51, k = 12, r = 1)
sim_mumps <- as.data.frame(ode(y = inits, times = dt,
                               func = SIR, parms = parms_mumps))
sim_cpox <- as.data.frame(ode(y = inits, times = dt,
                               func = SIR, parms = parms_cpox))

# Get the maximum number of infected for each
max(simulation$I)
max(sim_mumps$I)
max(sim_cpox$I)

# When did it hit the maximum?
print(c(simulation$time[which.max(simulation$I)], 
        sim_mumps$time[which.max(sim_mumps$I)], 
        sim_cpox$time[which.max(sim_cpox$I)]))

# Plot all three
plot(x = simulation$time, y = simulation$I, type = "l", 
     xlab = "Time (weeks)", ylab = "People (count)", main = "Infections")
lines(x = sim_cpox$time, y = sim_cpox$I, col = "red")
lines(x = sim_mumps$time, y = sim_mumps$I, col = "green")
legend(x = "topright", legend = c('Measles', 'Chicken Pox', 'Mumps'), 
       col = c("black", "red", "green"), lty = 1)
