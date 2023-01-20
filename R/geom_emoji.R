#' Emoji geom
#'
#' Use emoji as you would \code{\link{geom_point}}.
#'
#' @author David L Miller
#' @importFrom proto proto
#' @importFrom grid rasterGrob grobTree
#' @importFrom grDevices rgb
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' library(emoGG)
#'
#' # I want a tulip to plot for the iris example data
#' emoji_search("tulip")
#'
#' # plot the data, but with emojis
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
#'   geom_emoji(emoji="1f337")
#'
#'}
geom_emoji <- function(mapping = NULL, data = NULL, stat = "emoji",
                       position = "identity", na.rm = FALSE,
                       show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomEmoji,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}


stat_emoji <- function(mapping = NULL, data = NULL, geom = "emoji",
                       position = "identity", na.rm = FALSE, show.legend = NA,
                       inherit.aes = TRUE, ...) {
  ggplot2::layer(
    stat = StatEmoji, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

StatEmoji <- ggproto("StatEmoji", Stat,
  compute_group = function(data, scales) {
    data
  },
  required_aes = c("x", "y")
)

emojisGrob <- function(coords){
  raster_it <- function(x, y, size, emoji){
    rasterGrob(x             = x,
               y             = y,
               image         = emoji,
               default.units = "native",
               height        = size,
               width         = size)
  }
  ff <- function(coords){
    raster_it(coords$x, coords$y, coords$size, coords$emoji)
  }

  # smoosh everything together
  do.call(grobTree, apply(coords, 1, ff))
}

GeomEmoji <- ggproto("GeomEmoji", Geom,
#  objname = "emoji",
#  desc = "Emojis!!!",

  draw_panel = function(data, panel_scales, coord, na.rm = FALSE) {
    data$emoji <- emoji_get(data$emoji)
    coords = coord$transform(data, panel_scales)

    ggplot2:::ggname("geom_emoji",

      emojisGrob(coords)

    )
  },

  default_stat = function(.) StatEmoji,
  non_missing_aes = c("emoji", "size"),
  required_aes = c("x", "y"),
  default_aes = aes(size=0.05, emoji="1f697"),
  guide_geom = "emoji",

  icon = function(.){}, # a grob representing the geom for the webpage

  desc_params = list( # description of the (optional) parameters of draw
     ),

  seealso = list(
    geom_point = GeomPoint$desc
  ),

  examples = function(.) {
    # examples of the geom in use
  }
)



