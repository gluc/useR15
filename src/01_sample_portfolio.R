library(data.tree)
#useRdf <- read.csv('data/useR15.csv', stringsAsFactors = FALSE)
pfodf <- read.csv('../useR15/data/portfolio.csv', stringsAsFactors = FALSE)
pfodf


pfodf$pathString <- paste("portfolio", pfodf$AssetCategory, pfodf$AssetClass, pfodf$SubAssetClass, pfodf$ISIN, sep = "/")

pfo <- as.Node(pfodf)

pfo$Get(Aggregate, "Weight", sum, assign = "Weight")


pfo$Get(function(x) x$Weight / x$parent$Weight, assign = "WoP")

pfo$formatters$WoP <- function(x) FormatPercent(x, digits = 1)
pfo$formatters$Weight <- FormatPercent

pfo$formatters$Duration <- function(x) {
  if (x != 0) res <- FormatFixedDecimal(x, digits = 1)
  else res <- ""
  return (res)
}

pfo$Get(attribute = Aggregate, 
        function(x) x$Weight * x$Duration / x$parent$Weight, 
        fun = function(x) sum(x, na.rm = TRUE), 
        assign = "Duration")

print(pfo, 
              "Weight", 
              "WoP",
              "Duration",
              filterFun = function(x) !x$isLeaf)


