#find a specific node
ritz <- useRtree$Find("Session 5", "Musiksalen", "Christian Ritz")

#call attributes
ritz$presentation
ritz$parent$parent$sessionName

#create a deep copy
useRtree2 <- useRtree$Clone()

#prune
useRtree2$Prune(function(x) x$level!=2 || x$room == 'Radiosalen')
useRtree2
useRtree2$totalCount

#sort
useRtree$Sort("speaker")
print(useRtree)
