#======
#create the data file (prep)

#create from yaml
library(yaml)


useRdf <- read.csv('../useR15/data/useR15.csv', stringsAsFactors = FALSE, encoding = "UTF-8")

useRdf$pathString <- paste("useR", useRdf$session, useRdf$room, useRdf$speaker, sep="|")



cols <- list(c('start', 'end', 'sessionName'), c('seats'))

useRtree <- as.Node(useRdf[c('pathString', 'start', 'end','sessionName','seats','presentation')], pathDelimiter = "|", colLevels = cols)


y <- as.yaml(useRtree$ToList())
fileCon <- file('../useR15/data/useR15.yaml')
writeLines(y, fileCon)
close(fileCon)

#======
#SLIDE

  
fileName <- '../useR15/data/useR15.yaml'
myYaml <- readChar(fileCon, file.info(fileName)$size)

#yaml is easy (for humans) to read and write:
cat(myYaml)

#converting to a list of list is done by the R package yaml:
l <- yaml.load(myYaml)

#convert the nested list to a data.tree Node:
useRtree <- as.Node(l)
