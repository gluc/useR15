# github.com/gluc/useR15

# Create a tree from scratch
library(data.tree)

#useR! 2015 Sessions

useR <- Node$new("UseR! Conference 2015")
  aalborghallen <- useR$AddChild("Aalborghallen")
  #add some ad hoc properties
  aalborghallen$seats <- 790
    k1 <- aalborghallen$AddChild("Kaleidoscope 1")
    k1$start <- as.POSIXlt("2015-07-01 10:30 CEST")
    k1$end <- as.POSIXlt("2015-07-01 12:00 CEST")
      flowcatchR <- k1$AddChild("flowcatchR")
      flowcatchR$presentor <- "Federico Marini"
    
