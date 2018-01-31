library(deSolve)

parms_sis <- c(beta = 0.333, k = 3, alpha = .3)
inits_sis <- c(S = 499, I = 1)
dt <- seq(0, 300, 1)

SIS <- function(t, x, parms){
    with(as.list(c(parms, x)), {
        
        N <- S + I
        dS <- - (beta * k * S * I) / N + (alpha * I)
        dI <- + (beta * k * S * I) / N - (alpha * I)
        
        der <- c(dS, dI)
        
        return(list(der))
    }) 
}

simulation_sis <- as.data.frame(ode(y = inits_sis, times = dt, 
                                   func = SIS, parms = parms_sis))

matplot(x = simulation_sis[, 1], y = simulation_sis[, 2:3], type = "l", 
        lty = 1, xlim = c(0, 40),
        xlab = "Time", ylab = "People (count)", 
        main = "SIS Model")
legend(x = "right", legend = c('S', 'I'), 
       col = 1:2, lty = 1)

