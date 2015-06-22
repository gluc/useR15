library(data.tree)
#useRdf <- read.csv('data/useR15.csv', stringsAsFactors = FALSE)
useRdf <- read.csv('../useR15/data/useR15.csv', stringsAsFactors = FALSE, encoding = "UTF-8")
head(useRdf[,-ncol(useRdf)])
useRdf$rating <- sample(1:10, nrow(useRdf), replace=T)



#############
# Slide

#all useR 2015 presentations in traditional tabular format:
head(useRdf)

#convert to data.tree
#====================

#1. add a path
#Here, the hieararchy is again Session/Room/Presentation
useRdf$pathString <- paste("useR", useRdf$session, useRdf$room, useRdf$speaker, sep="|")

#2. advanced and optional: define which attributes go to which level in the tree
#By default, they go to the leaf
cols <- list(NULL, 
             c('session', 'start', 'end', 'sessionName'),
             c('room', 'seats'))

#3. convert to tree
useRtree <- as.Node(useRdf, pathDelimiter = "|", colLevels = cols)


print(useRtree, 
      "start", "seats", 
      filterFun = function(x) x$level < 3)
