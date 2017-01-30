#SIR practical from Debarre and Bonhoeffer ("SIR models of epidemics")
library(deSolve)

parms <- c(beta = 0.333, k = 3 , r = 0.333)
inits <- c(S = 499, I = 1, R = 0)
dt <- seq(0, 300, 1)

SIR <- function(t, x, parms){
    with(as.list(c(parms, x)), {
        
        dS <- - (beta * k * S * I) / (S + I + R)
        dI <- + (beta * k * S * I) / (S + I + R) - r * I
        dR <- r * I
        
        der <- c(dS, dI, dR)
        
        return(list(der))
    }) 
}

simulation <- as.data.frame(ode(y = inits, times = dt, 
                                func = SIR, parms = parms))

matplot(x = simulation[, 1], y = simulation[, 2:4], type = "l", 
        lty = 1, xlim = c(1, 40), 
        xlab = "Time", ylab = "People (count)", 
        main = "SIR Model")
legend(x = "right", legend = c('S', 'I', 'R'), 
       col = 1:3, lty = 1)

