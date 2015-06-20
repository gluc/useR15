#counting
useRtree$count
useRtree$totalCount
useRtree$leafCont


#find a specific node
ritz <- useRtree$Find("Session 5", "Musiksalen", "Christian Ritz")

#and navigate
ritz$parent
ritz$root

#find attributes
ritz$fields

#find attributes anywhere in the tree
ritz$fieldsAll

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
