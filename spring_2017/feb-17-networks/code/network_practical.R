networkPractical <- function(network, attackRate, acquireImmunity, runTime) {
  
  #we will encode susceptible individuals as 0, infected as 1, immune as 2
  numberOfPeople <- network.size(network) #size of the population
  #start out with everyone susceptible
  statusList <- array(0,dim=c(numberOfPeople,1)) 
  timeSeries <- NULL
  keepStatus <- NULL
  
  #INFECT THE FIRST PERSON!
  statusList[1] <- 1 
  
  for(time in 1:runTime){
    print(time)
    
    whoIsInfected <- which(statusList==1)
    whoIsImmune <- which(statusList==2)
    
    if(length(whoIsInfected)==numberOfPeople | 
       length(whoIsImmune)==numberOfPeople | 
       length(whoIsInfected)==0) {}
    
    else {
    for(i in 1:length(whoIsInfected)){ #only look at people who are infected
        #see who is connected to infected node
        contacts <- get.neighborhood(network, whoIsInfected[i]) 
        #see which contacts are susceptible to infection
        suscContacts <- which(statusList[contacts]==0) 
        
        if(length(suscContacts)>0) {
            #see which infectious contacts lead to infection
            successfulInfect <- which(runif(length(suscContacts))<attackRate) 
            
            if(length(successfulInfect)>0){	
                #INFECT SUSCEPTIBLES!
                statusList[contacts[suscContacts[successfulInfect]]] <- 1 
            }
        }
    }
        if(length(whoIsInfected)>0){
            #see who becomes immune
        becomeImmune <- which(runif(length(whoIsInfected)) < acquireImmunity)
        statusList[whoIsInfected[becomeImmune]] <- 2
      }
      
      S <- length(which(statusList==0))
      I <- length(which(statusList==1))
      R <- length(which(statusList==2))
      timeSeries <- rbind(timeSeries,c(S,I,R)) #keep track of people
      keepStatus <- cbind(keepStatus,statusList)
    }}
  #timeSeries will contain the simulated results, 
  # status will contain the status of each person at each time step,
  #  and this will be used for plotting purposes
  return(list(timeSeries=timeSeries,status=keepStatus))
}
