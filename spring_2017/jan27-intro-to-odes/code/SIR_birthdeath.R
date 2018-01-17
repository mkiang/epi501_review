#SIR practical from Debarre and Bonhoeffer ("SIR models of epidemics")
library(deSolve)

parms_bd <- c(beta = 0.333, k = 3 , r = 0.333, birth = .02, death = .02)
inits_bd <- c(S = 499, I = 1, R = 0)
dt <- seq(0, 300, 1)

SIR_bd <- function(t, x, parms){
    with(as.list(c(parms, x)), {
        
        N <- S + I + R
        dS <- - (beta * k * S * I) / N - (death * S) + (birth * N)
        dI <- + (beta * k * S * I) / N - r * I - (death * I)
        dR <- r * I - (death * R)
        
        der <- c(dS, dI, dR)
        
        return(list(der))
    }) 
}

simulation_bd <- as.data.frame(ode(y = inits_bd, times = dt, 
                                func = SIR_bd, parms = parms_bd))

matplot(x = simulation_bd[, 1], y = simulation_bd[, 2:4], type = "l", 
        lty = 1, xlim = c(1, 150), 
        xlab = "Time", ylab = "People (count)", 
        main = "SIR Model (with births/deaths)")
legend(x = "right", legend = c('S', 'I', 'R'), 
       col = 1:3, lty = 1)

