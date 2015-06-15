library(data.tree)
#useRdf <- read.csv('data/useR15.csv', stringsAsFactors = FALSE)
useRdf <- read.csv('../useR15/data/useR15.csv', stringsAsFactors = FALSE)
head(useRdf[,-ncol(useRdf)])
useRdf$pathString <- paste("useR", useRdf$session, useRdf$room, useRdf$speaker, sep="|")


cols <- list(c('session', 'start', 'end', 'sessionName'),
             c('room', 'seats'))

useRtree <- as.Node(useRdf, pathDelimiter = "|", colLevels = cols)


print(useRtree, 
      "start", "seats", 
      filterFun = function(x) x$level < 3)
