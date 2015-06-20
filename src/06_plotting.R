#dendrogram
den <- as.dendrogram(useRtree$Find("Session 2"))
plot(den, center = TRUE)

#phylo from the ape package
library(ape)
myphylo <- as.phylo(useRtree$Find("Session 2"))

plot(myphylo, type = "clado", show.node.label = TRUE)
plot(myphylo, type = "fan")


#rpart
as.rpart(myphylo)

#networkD3
library(networkD3)
treeNetwork(useRtree$ToList(unname = TRUE))
