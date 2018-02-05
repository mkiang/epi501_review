## Boilerplate code

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