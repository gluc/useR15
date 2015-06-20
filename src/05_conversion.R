#Convert to data.frame, hierarchy
useRtree$ToDataFrame("start", "end")

#Convert to tabular form again (where we started off)
useRtree$ToDataFrameTable("session", "room", "speaker")


#Convert to list of lists
lol <- useRtree$ToList()

#Convert to JSON
library(jsonlite)
cat(toJSON(lol))

library(rjson)
cat(toJSON(lol))

#Convert to XML


#convert from dendrogram
hc <- hclust(dist(USArrests), "ave")
dend1 <- as.dendrogram(hc)
node <- as.Node(dend1)

print(node, "height", "midpoint", "value")

dend2 <- as.dendrogram(node)
