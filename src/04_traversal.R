#walk the tree and collect values
useRtree$Get("name")



#works also with functions
toUpperName <- function(node) {
  toupper(node$name)
}

useRtree$Get(toUpperName)

#assign values to nodes
useRtree$Set(id = 1:useRtree$totalCount)
print(useRtree, "id")

#you can walk the tree in various orders (both Get and Set)
#default is "pre-order" (see above)
#"post-order" does a depth-first search
useRtree$Set(id = 1:useRtree$totalCount, traversal = "post-order")
print(useRtree, "id")


#you can assign at the same time to a field of the tree (combining Get and Set)
presCount <- function(node) {
  if (node$isLeaf) return (1)
  length(node$leaves)
}

useRtree$Get(presCount, assign = "presentations")
print(useRtree, "presentations", filterFun = function(x) x$level <= 2)


