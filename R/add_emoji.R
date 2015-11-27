#' Input an emoji and create a ggplot2 layer to add to an existing plot
#'
#' @importFrom grid rasterGrob
#' @export
#' @param emoji either a codepoint (without \code{\\U} etc), or the result from \code{\link{emoji_search}}
#' @param x x value of the emoji center. Ignored if y and ysize are not specified.
#' @param y y value of the emoji center. Ignored if x and ysize are not specified.
#' @param ysize Height of the emoji. The width is determined by the aspect ratio of the original image. Ignored if x and y are not specified.
#' @details Use parameters \code{x}, \code{y}, and \code{ysize} to place the emoji at a specified position on the plot. If all three of these parameters are unspecified, then the emoji will be plotted to the full height and width of the plot.
#' @examples \dontrun{
#' library(ggplot2)
#' library(emoGG)
#'
#' # Put a emoji behind a plot
#' qplot(x=Sepal.Length, y=Sepal.Width, data=iris, geom="point") +
#'  add_emoji("1f337")
#'
#' # Put a silhouette anywhere
#' posx <- runif(50, 0, 10)
#' posy <- runif(50, 0, 10)
#' sizey <- runif(50, 0.4, 2)
#' p <- ggplot(data.frame(x = posx, y = posy), aes(x, y)) +
#'             geom_point(color = rgb(0,0,0,0))
#' for (i in 1:50) {
#'   p <- p + add_emoji("1f697", posx[i], posy[i], sizey[i])
#' }
#' }
#' @note Based on \code{add_phylopic} from \code{rphylopic} by Scott Chamberlain.
#' @importFrom ggplot2 annotation_custom
add_emoji <- function(emoji, x=NULL, y=NULL, ysize=NULL){

  img <- emoji_get(emoji)[[1]]

  if (!is.null(x) && !is.null(y) && !is.null(ysize)){
    aspratio <- nrow(img) / ncol(img) ## get aspect ratio of original image
    ymin <- y - ysize / 2
    ymax <- y + ysize / 2
    xmin <- x - ysize / aspratio / 2
    xmax <- x + ysize / aspratio / 2
  } else {
    ymin <- -Inf ## fill whole plot...
    ymax <- Inf
    xmin <- -Inf
    xmax <- Inf
    img <- matrix(rgb(img[,,1], img[,,2], img[,,3], img[,,4] * 0.4),
                  nrow = dim(img)[1])
  }
  imgGrob <- rasterGrob(img)
  return(
    annotation_custom(xmin = xmin, ymin = ymin, xmax = xmax, ymax = ymax, imgGrob)
  )
}
