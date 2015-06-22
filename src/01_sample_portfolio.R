library(data.tree)
#useRdf <- read.csv('data/useR15.csv', stringsAsFactors = FALSE)
pfodf <- read.csv('../useR15/data/portfolio.csv', stringsAsFactors = FALSE)
pfodf


pfodf$pathString <- paste("portfolio", pfodf$AssetCategory, pfodf$AssetClass, pfodf$SubAssetClass, pfodf$ISIN, sep = "/")

pfo <- as.Node(pfodf)

pfo$Get("Aggregate", "Weight", sum, assign = "Weight")


weightOfParent <- function(x) {
  myWeight <- x$Aggregate("Weight", sum)
  if(x$isRoot) return (myWeight)
  parentWeight <- x$parent$Aggregate("Weight", sum)
  return (myWeight / parentWeight)
}

pfo$Get(weightOfParent, assign = "wop")

DurationContribution <- function(x) {
  if(x$isLeaf) {
    if(is.null(x$Duration)) return (0)
    contrib <- x$Weight * x$Duration
    return (contrib)
  }
  contrib <- x$Aggregate(DurationContribution, sum) * x$Weight
  return (contrib)
}

pfo$Get(DurationContribution, assign = "DurationContrib")

print(pfo, 
              weight = "Weight", 
              wop = "wop",
              duration = "Duration",
              filterFun = function(x) !x$isLeaf)


