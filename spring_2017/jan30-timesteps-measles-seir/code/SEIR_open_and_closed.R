## Closed SEIR model
parms <- c(beta = .75, a = 1/12 * 7, k = 12 , r = 1)
inits <- c(S = 999999, E =0, I = 1, R = 0)
dt <- seq(0, 25, 1/7)
SEIR <- function(t, x, parms){
    with(as.list(c(parms, x)), {
        N <- S + E + I + R 
        dS <- - (beta * k * S * I) / N
        dE <- + (beta * k * S * I) / N - (a * E)
        dI <- + (a * E) - (r * I)
        dR <- r * I
        der <- c(dS, dE, dI, dR)
        return(list(der))
    }) 
}
sim_seir <- as.data.frame(ode(y = inits, times = dt, 
                              func = SEIR, parms = parms))
matplot(x = sim_seir[, 1], y = sim_seir[, 2:5], type = "l", 
        lty = 1, xlab = "Time", ylab = "People (count)", main = "SEIR Model")
legend(x = "right", legend = c('S', 'E', 'I', 'R'), col = 1:4, lty = 1)

## Open SEIR model
# added births and deaths as weekly rates (divide by 52 weeks)
parms_bd <- c(beta = .75, a = 1/12 * 7, k = 12 , r = 1, 
              b = .02/52, d = .02/52)
# Look at 50 years
dt_bd <- seq(0, 52 * 50, 1/7)       
SEIR_bd <- function(t, x, parms){
    with(as.list(c(parms, x)), {
        N <- S + E + I + R 
        dS <- - (beta * k * S * I) / N + (b * N) - (d * S)
        dE <- + (beta * k * S * I) / N - (a * E) - (d * E)
        dI <- + (a * E) - (r * I) - (d * I)
        dR <- r * I  - (d * R)
        der <- c(dS, dE, dI, dR)
        return(list(der))
    }) 
}
simulation_bd <- as.data.frame(ode(y = inits, times = dt_bd, 
                                   func = SEIR_bd, parms = parms_bd))
matplot(x = simulation_bd[, 1], y = simulation_bd[, 2:5], type = "l", 
        lty = 1, xlab = "Time", ylab = "People (count)", 
        main = "SEIR with births/deaths")
legend(x = "right", legend = c('S', 'E', 'I', 'R'), col = 1:4, lty = 1)

## Plot only infections and only after 5 years
plot(x = simulation_bd$time[simulation_bd$time >= 5 * 52], 
     y = simulation_bd$I[simulation_bd$time >= 5 * 52], 
     type = "l", lty = 1, xlab = "Time", ylab = "Infections (count)", 
     main = "Infections, Open SEIR")

## Loop through different values for birth/death
bd_rates <- seq(from = .013, to = .025, length.out = 5)
dt_bd <- seq(0, 25 * 52, 1/7)
holder <- NULL
for (bd in bd_rates) {
    parms_bd <- c(beta = .75, a = 1/12 * 7, k = 12 , r = 1, 
                  b = bd/52, d = bd/52)
    simulation_bd <- as.data.frame(ode(y = inits, times = dt_bd, 
                                       func = SEIR_bd, parms = parms_bd))
    holder <- cbind(holder, simulation_bd$I)
}
t5_more <- simulation_bd$time >= 52 * 5
matplot(simulation_bd$time[t5_more], holder[t5_more, ], type = 'l', 
        lty = 1, xlab = "Time (weeks)", ylab = "Infections (count)", 
        main = "Changing birth/deaths")
legend(x = "topleft", legend = bd_rates, col = 1:5, lty = 1)

