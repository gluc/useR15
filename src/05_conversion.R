#Convert to data.frame, hierarchy
useRtree$ToDataFrame("start", "end")

#Convert to tabular form again (where we started off)
useRtree$ToDataFrameTable("session", "room", "speaker")


#Convert to list of lists
lol <- useRtree$ToList()

#all conversion functions are also available in traditional R generics style:
lol <- as.list(useRtree)

#Convert to JSON (via list of lists)
library(jsonlite)
j <- toJSON(lol, auto_unbox = TRUE, pretty = TRUE)
cat(substr(j, 1, 1000))

#..and back
as.Node(fromJSON(j))

#use your favourite library
library(rjson)
toJSON(lol)


#convert from dendrogram
hc <- hclust(dist(USArrests), "ave")
dend1 <- as.dendrogram(hc)
node <- as.Node(dend1)

print(node, "height", "midpoint", "value")
# ... and back
dend2 <- as.dendrogram(node)
plot(dend2)
