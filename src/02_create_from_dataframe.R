library(data.tree)
#useRdf <- read.csv('data/useR15.csv', stringsAsFactors = FALSE)
useRdf <- read.csv('../useR15/data/useR15.csv', stringsAsFactors = FALSE, encoding = "UTF-8")
useRdf$rating <- sample(1:10, nrow(useRdf), replace=T)

head(useRdf[,-ncol(useRdf)])


useRdf$pathString <- paste("useR", useRdf$session, useRdf$room, useRdf$speaker, sep="|")



cols <- list(c('session', 'start', 'end', 'sessionName'),
             c('room', 'seats'))

useRtree <- as.Node(useRdf, pathDelimiter = "|", colLevels = cols)


print(useRtree, 
      "start", "seats", 
      filterFun = function(x) x$level < 3)
