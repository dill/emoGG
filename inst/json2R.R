# take emojis.json and make a data.frame

library(jsonlite)
library(plyr)

# load the emojis
ff <- fromJSON("emojis.json")

# extract keys
keys <- ff$keys
ff$keys <- NULL

# is keys in the same order as ff?
# all.equal(keys, names(ff)) # TRUE

# how many keywords per emoji?
reps <- laply(ff, function(x) length(x$keywords))

# extract the keywords
keywords <- lapply(ff, function(x) x$keywords)
keywords <- unlist(keywords)

# codes
char <- lapply(ff, function(x) if(!is.null(x$char)) x$char else "")
char <- unlist(char)

# put that together
options(stringsAsFactors=FALSE) # what am I, a monster?
emojis <- data.frame(emoji   = rep(keys, reps),
                     code    = rep(char, reps),
                     keyword = keywords)
rownames(emojis) <- NULL

# and save!
save(emojis, file="emojis.RData")
