#' Search for emoji
#'
#' Do a simple search through emoji keywords and names for a given term.
#'
#' @note Data are taken from \url{https://github.com/muan/emojilib}
#'
#' @author David L Miller
#' @export
emoji_search <- function(search){

  dat.filename <- system.file("emojis.RData", package="emoGG")
  load(dat.filename)

  # keywords contain things like ;) which need to be regexified
  keywords <- gsub("([[:punct:]])", "\\\\\\1", emojis$keyword)
  
  key_search <- unlist(lapply(keywords, grepl, search))
  name_search <- unlist(lapply(emojis$emoji, grepl, search))

  return(emojis[key_search | name_search,])
}
