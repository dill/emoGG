# take emojis.json and make a data.frame

library(jsonlite)
library(plyr)
library(stringi)

# load the emojis
ff <- fromJSON("emojis.json")

# extract keys
keys <- names(ff)

# how many keywords per emoji?
reps <- laply(ff, function(x) length(x$keywords))

# extract the keywords
keywords <- lapply(ff, function(x) x$keywords)
keywords <- unlist(keywords)

# codes
char <- lapply(ff, function(x) if(!is.null(x$char)) x$char else "")
char <- unlist(char)
## get rid of unneeded bits
# convert to strings
char <- stri_escape_unicode(char)
# remove variants (see https://github.com/twitter/twemoji/blob/gh-pages/twemoji.js#L316)
char <- sub("\\\\Ufe0f$" ,"", char, ignore.case=TRUE)
# remove leading chars
char <- sub("^\\\\U0*" ,"", char, ignore.case=TRUE)

# put that together
options(stringsAsFactors=FALSE) # what am I, a monster?
emojis <- data.frame(emoji   = rep(keys, reps),
                     code    = rep(char, reps),
                     keyword = keywords)
rownames(emojis) <- NULL

# and save!
save(emojis, file="emojis.RData")
