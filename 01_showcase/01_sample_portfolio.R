library(data.tree)

#read from file
pfodf <- read.csv('../useR15/data/portfolio.csv', stringsAsFactors = FALSE)
pfodf

#convert to data.tree
pfodf$pathString <- paste("portfolio", pfodf$AssetCategory, pfodf$AssetClass, pfodf$SubAssetClass, pfodf$ISIN, sep = "/")
pfo <- as.Node(pfodf)

#Calculate breakdown
pfo$Get(Aggregate, "Weight", sum, assign = "Weight")
pfo$Get(function(x) x$Weight / x$parent$Weight, traversal = "post-order", assign = "WoP")
pfo$Get(attribute = Aggregate, 
        function(x) x$Weight * x$Duration / x$parent$Weight, 
        fun = function(x) sum(x, na.rm = TRUE),
        traversal = "post-order",
        assign = "Duration")

#Formatters
pfo$formatters$WoP <- function(x) FormatPercent(x, digits = 1)
pfo$formatters$Weight <- FormatPercent
pfo$formatters$Duration <- function(x) {
  if (x != 0) res <- FormatFixedDecimal(x, digits = 1)
  else res <- ""
  return (res)
}

#Print
print(pfo, 
      "Weight", 
      "WoP",
      "Duration",
      filterFun = function(x) !x$isLeaf)


