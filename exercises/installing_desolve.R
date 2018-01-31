## Install and load `deSolve` package

if (!require(deSolve)) {
    install.packages("deSolve")
    library(deSolve)
} else {
    library(deSolve)
}

print(packageVersion("deSolve"))    ## Should say 1.20
