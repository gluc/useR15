# github.com/gluc/useR15

# Create a tree programmatically
library(data.tree)

#useR! 2015 Sessions
#  session (name, start, end)
#    room (name, seats)
#      presentation (speaker, presentation name)

useR <- Node$new("UseR! Conference 2015")
  session1 <- useR$AddChild("Session 1")
  session1$start <- as.POSIXlt("2015-07-01 10:30 CEST")
  session1$end <- as.POSIXlt("2015-07-01 12:00 CEST")
    aalborghallen <- session1$AddChild("Aalborghallen")
    aalborghallen$seats <- 790
      p1 <- aalborghallen$AddChild("Federico Marini")
      p1$presentation <- "flowcatchR: A user-friendly workflow solution for the analysis of time-lapse cell flow imaging data"
      p2 <- aalborghallen$AddChild("Jonathan Clayden")
      p2$presentation <- "Image processing and alignment with RNiftyReg and mmand"
      #... etc.
    gaestsalen <- session1$AddChild("Gaestsalen")
    gaestsalen$seats <- 149
      p1 <- gaestsalen$AddChild("Costas Varsos")
      p1$presentation <- "Optimized R functions for analysis of ecological community data using the R virtual laboratory (Rvlab)"
      #... etc.

#BUT: normally, you would do this in an algorithm!
#see vignette("ID3")
  
#note: Nodes exhibit reference semantics!
session1$day <- "Tuesday"
session1$fields
    
#equivalent operation with lists doesn't work!
useRlist <- list()
  session1list <- list()
  useRlist$session1 <- session1list
  session1list$day <- "Tuesday"

useRlist$session1

