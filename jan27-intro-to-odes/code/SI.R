library(deSolve)

parms_si <- c(beta = 0.333, k = 3)
inits_si <- c(S = 499, I = 1)
dt <- seq(0, 300, 1)

SI <- function(t, x, parms){
    with(as.list(c(parms, x)), {
        
        N <- S + I
        dS <- - (beta * k * S * I) / N
        dI <- + (beta * k * S * I) / N
        
        der <- c(dS, dI)
        
        return(list(der))
    }) 
}

simulation_si <- as.data.frame(ode(y = inits_si, times = dt, 
                                   func = SI, parms = parms_si))

matplot(x = simulation_si[, 1], y = simulation_si[, 2:3], type = "l", 
        lty = 1, xlim = c(1, 40), 
        xlab = "Time", ylab = "People (count)", 
        main = "SI Model")
legend(x = "right", legend = c('S', 'I'), 
       col = 1:2, lty = 1)

