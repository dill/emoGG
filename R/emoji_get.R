#' Get an emoji image from its codepoint
#'
#' @export
#' @rdname emoji_get
#' @param input either a codepoint (without \code{\\U} etc), or the result from \code{\link{emoji_search}}
#' @param size the size of the resulting image (72, 36, 16)
#' @return list of images
#'
#' @note Adapted from \code{rphylopic} code by Scott Chamberlain
#' @importFrom png readPNG
#' @importFrom RCurl getURLContent
#' @importFrom methods is
#' @author David L Miller
emoji_get <- function(input, size=72, cdn="https://twemoji.maxcdn.com/2/"){

  # set the size (default to biggest for best display)
  size <- match.arg(as.character(size), c("72", "36", "16"))
  size <- paste0(size, "x", size)

  # content delivery network
  #cdn <- "https://twemoji.maxcdn.com/"
  format <- ".png"

  if(is(input, "image_info")){
#    if(!size %in% c('thumb','icon')){
#      urls <- input[ as.character(input$height) == size , "url" ]
#      urls <- sapply(urls, function(x) file.path("http://phylopic.org", x), USE.NAMES = FALSE)
#    } else {
#      urls <- paste0(gsub("\\.64\\.png", "", unname(daply(input, .(uuid), function(x) x$url[1]))), sprintf(".%s.png", size))
#      urls <- sapply(urls, function(x) file.path("http://phylopic.org", x), USE.NAMES = FALSE)
#    }
#    lapply(urls, function(x) readPNG(getURLContent(x)))
stop("arg!")
  }else{
    url <- paste0(cdn, size, "/", input, format)
    lapply(url, function(x) readPNG(getURLContent(x)))
  }
}

