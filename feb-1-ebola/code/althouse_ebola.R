## Make an SEIR model that keeps track of cumulative cases (C) and
## total deaths D
library(deSolve)

dt <- seq(0, 365, 1) 
inits_alt1 <- c(S = 999999,E = 0, I = 1, R = 0, C = 0, D = 0) 

## NOTE: Using Beta not (b * k) as before.
parms <- c(B = 0.45,        # Transmission prob * average num of contacts
           s = 1/5.3,       # Transition rate from E to I 
           g = 1/5.61,      # Recover rate -- I to R
           f = 0.6)         # Case fatality ratio

SEIR_alt1 <- function(t, x, parms) {
    with(as.list(c(parms, x)), {
        
        N <- S + E + I + R
        dS <- - (B * S * I) / N 
        dE <- + (B * S * I) / N - (s * E) 
        dI <- (s * E) - (g * I) 
        dR <- (1 - f) * (g * I) 
        
        dC <- s * E
        dD <- f * g * I
        
        der <- c(dS, dE, dI, dR, dC, dD)
        
        return(list(der))
    }) 
}

data_alt1 <- as.data.frame(ode(inits_alt1, dt, SEIR_alt1, parms = parms))

matplot(data_alt1[, 1], data_alt1[, 2:7], type = 'l', 
        ylab = 'People', xlab = 'Time (days)',lty = 1)

# Create an SEIR with time-varying transmission rate
## Make an SEIR model that keeps track of cumulative cases (C) and
## total deaths D
library(deSolve)

dt <- seq(0, 120, 1/24) 
inits_alt1 <- c(S = 999999,E = 0, I = 1, R = 0, C = 0, D = 0) 

## NOTE: Using Beta not (b * k) as before.
parms_alt2 <- c(B_init = 0.45,   # Initial transmission prob * avg num contacts
                s = 1/5.3,       # Transition rate from E to I
                g = 1/5.61,      # Recover rate -- I to R
                f = 0.6,         # Case fatality ratio
                k = 0.0097)      # decay of transmission rate


SEIR_alt2 <- function(t, x, parms) {
    with(as.list(c(parms, x)), {
        
        B  <- B_init * exp(-k * t)
        N  <- S + E + I + R
        dS <- -(B * S * I) / N 
        dE <- +(B * S * I) / N - (s * E) 
        dI <- (s * E) - (g * I) 
        dR <- (1 - f) * (g * I) 
        
        dC <- s * E
        dD <- f * g * I
        
        der <- c(dS, dE, dI, dR, dC, dD)
        
        return(list(der))
    }) 
}

data_alt2 <- as.data.frame(ode(inits_alt1, dt, SEIR_alt2, parms = parms_alt2))

matplot(data_alt2[, 1], data_alt2[, 2:7], type = 'l', 
        ylab = 'People', xlab = 'Time (days)',lty = 1)
matplot(data_alt2[, 1], data_alt2[, 4], type = 'l', 
        ylab = 'Infectious People', xlab = 'Time (days)', lty = 1)


## Set constants
beta0 <- 0.45
k <- 0.0097
tau <- 0

## Plug into formula
days <- 1:120
betas <- beta0 * exp(-k * (days - tau))
r0s <- betas / (1/5.61)

## Plot it
plot(x = days, y = betas, type = "l")
plot(x = days, y = r0s, type = "l")
lines(x = days, y = rep(1, length(days)))
which(r0s <= 1)[1]