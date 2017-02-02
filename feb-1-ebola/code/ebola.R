library(deSolve)
# Example SEIR Model
# Note that the time unit in this model is days

dt <- seq(0, 365, 1) 
inits <- c(S = 999999,E = 0, I = 1, R = 0) 

## NOTE: Using Beta not (b * k) as before.
parms <- c(B = 0.45,        # Transmission prob * average num of contacts
           s = 1/5.3,       # Transition rate from E to I 
           g = 1/5.61,      # Recover rate -- I to R
           f = 0.6)         # Case fatality ratio

SEIR_ex <- function(t, x, parms) {
    with(as.list(c(parms, x)), {
        
        N <- S + E + I + R
        dS <- - (B * S * I) / N 
        dE <- + (B * S * I) / N - (s * E) 
        dI <- (s * E) - (g * I) 
        dR <- (1 - f) * (g * I) 
        
        der <- c(dS, dE, dI, dR)
        
        return(list(der))
    }) 
}

data_out <- as.data.frame(ode(inits, dt, SEIR_ex, parms = parms))

matplot(data_out[, 1], data_out[, 2:5], type = 'l', 
        ylab = 'People', xlab = 'Time (days)',lty = 1)

matplot(data_out[, 1], data_out[, 4], type = 'l',
        ylab = 'Infectious People', xlab = 'Time (days)', lty = 1)



