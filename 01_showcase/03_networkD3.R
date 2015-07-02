library(data.tree)

useRdf <- read.csv('../useR15/data/useR15.csv', stringsAsFactors = FALSE, encoding = "UTF-8")
useRdf$pathString <- paste("useR", useRdf$session, useRdf$room, useRdf$speaker, sep="|")
useRtree <- as.Node(useRdf, pathDelimiter = "|")

library(networkD3)
network <- treeNetwork(useRtree$ToList(mode = "explicit", unname = TRUE))
network
#saveNetwork(network, "network.html", selfcontained = TRUE)
