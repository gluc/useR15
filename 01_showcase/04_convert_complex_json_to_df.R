#devtools::install_github("gluc/data.tree")
library(data.tree)
library(jsonlite)
library(magrittr)
reposLoL <- fromJSON("https://api.github.com/users/hadley/repos", simplifyDataFrame = FALSE)

library(data.tree)
repos <- as.Node(reposLoL)
print(repos, "id", "login")

#convert this to a data.frame
reposdf <- repos$ToDataFrameTable(ownerId = "id", 
                                  "login", 
                                  repoName = function(x) x$parent$name, #relative to the leaf
                                  fullName = "full_name", #unambiguous values are inherited from ancestors
                                  repoId = function(x) x$parent$id,
                                  "fork", 
                                  "type")

reposdf

#Now a somewhat more advanced example: In addition, let's download 
#contributors to each repo and store it in the same tree
#NOTE: you can only call 50 unauthenticated api requests per hour,
#so you can run this only once

#Get can also call functions! Here, we are not so much interested in
#the result, but more as some sort of mapply
repos$Get(function(x) x$AddChild("contributors"), filterFun = function(x) x$level == 2)
getContribs <- function(x) {
  contributors <- fromJSON(x$contributors_url, simplifyDataFrame = FALSE)
  for(c in contributors) c %>% as.Node(nodeName = c$login) %>% x$Find("contributors")$AddChildNode()
  return(length(contributors))
}

repos$Get(getContribs, filterFun = function(x) x$level == 2)

#optional: print some information about our structure
print(repos, "login", "id", "contributions")
repos$fieldsAll
#fields/attributes on contributors:
repos$Find("crantastic", "owner", "hadley")$fields

#convert it to a table (all attributes are relative to the leaves, i.e. contributors)
contributorsdf <- repos$ToDataFrameTable(contributorId = "id",
                                         "login", 
                                         isOwner = function(x) x$login == x$parent$parent$Find("owner")$login,
                                         ownerName = function(x) x$parent$parent$Find("owner")$login,
                                         repoName = function(x) x$parent$parent$name,
                                         repoId = function(x) x$parent$parent$id,
                                         "fork", 
                                         "type",
                                         "contributions",
                                         filterFun = function(x) x$name != "owner"
                       )
