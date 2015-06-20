#dendrogram
den <- as.dendrogram(useRtree$Find("Session 2"))
plot(den, center = TRUE)

#phylo from the ape package
library(ape)
myphylo <- as.phylo(s2)
plot(myphylo, type = "fan")

#or use helper functions to do crazy stuff
s2 <- useRtree$Find("Session 2")
lbls <- GetPhyloLabels(s2, "name")

plot(myphylo, type = "clado")
nodelabels(lbls, attr(lbls, "nodes"), adj = -0.01) 

usrLabelFun <- function(x) {
  if (x$level == 0) {
    #root
    res <- x$name
  } else if(x$level == 1) {
    #session
    res <- paste(x$name, 
                 paste0("start: ", x$start),
                 paste0("end:   ", x$end),
                 paste0("sessions: ", x$leafCount),
                 sep = "\n")
  } else if(x$level == 2) {
    res <- paste(paste0("room: ", x$name),
                 paste0("seats:", x$seats),
                 sep = "\n")
  } else {
    stop("Unexpected level")
  }    
}

lbls <- GetPhyloLabels(s2, usrLabelFun)

plot(myphylo, type = "clado")
nodelabels(lbls, attr(lbls, "nodes"), adj = -0.01) 



#networkD3
library(networkD3)
treeNetwork(useRtree$ToList(unname = TRUE))
