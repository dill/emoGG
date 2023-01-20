#' Get an emoji image from its codepoint
#'
#' @export
#' @rdname emoji_get
#' @param input either a codepoint (without \code{\\U} etc), or the result from \code{\link{emoji_search}}
#' @param size the size of the resulting image (72, 36, 16)
#' @param cdn location of the content delivery network to download emojis from
#' @return list of images
#'
#' @note Adapted from \code{rphylopic} code by Scott Chamberlain
#' @importFrom png readPNG
#' @importFrom RCurl getURLContent
#' @importFrom methods is
#' @author David L Miller
emoji_get <- function(input, size=72, cdn="https://cdnjs.cloudflare.com/ajax/libs/twemoji/14.0.2/"){

  # we only want to retrieve each emoji once, so what are the unique ones?
  uinput <- unique(input)

  # set the size (default to biggest for best display)
  size <- match.arg(as.character(size), c("72", "36", "16"))
  size <- paste0(size, "x", size)

  format <- ".png"

  # form URLs
  url <- paste0(cdn, size, "/", uinput, format)

  # backup if things fail below
  fail_png <- getURLContent(paste0(cdn, size, "/1f645", format))

  # function to retrieve emojis
  getter <- function(x){
    this_png <- try(getURLContent(x))
    if(inherits(this_png, "try-error")){
      this_png <- fail_png
      warning(paste("Failed to retrieve emoji at:", x))
    }
    readPNG(this_png)
  }

  # get the unique emojis
  uemojis <- lapply(url, getter)

  # repopulate including the duplicates
  names(uemojis) <- uinput
  uemojis[input]
}
