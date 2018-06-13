#' Emoji geom
#'
#' Use emoji as you would \code{\link{geom_point}}.
#'
#' @author David L Miller
#' @importFrom proto proto
#' @importFrom grid rasterGrob
#' @export geom_emoji
#'
#'
#' @export
emojisGrob <- function(x, y, size, img){

   rasterGrob(x             = x,
              y             = y,
              image         = img,
              default.units = "native",
              height        = size,
              width         = size)
}

GeomEmoji <- ggproto("GeomEmoji", Geom,
#  objname = "emoji",
#  desc = "Emojis!!!",

  #draw_panel = function(., data, scales, coordinates, ...) {
  draw_panel = function(data, panel_scales, coord, img, na.rm = FALSE) {
    #coords = coord_transform(coordinates, data, scales)
    coords = coord$transform(data, panel_scales)

    ggplot2:::ggname("geom_emoji",

     emojisGrob(coords$x, coords$y, coords$size, img)
    )
  },

#  draw_legend = function(., data, ...) {
#    data = aesdefaults(data, .$default_aes(), list(...))
#
#    with(data, ggname(.$my_name(),
#         emojisGrob(0.05, 0.05, size, emoji)))
#  },

#  default_stat = function(.) StatIdentity,
  non_missing_aes = c("emoji", "size"),
  required_aes = c("x", "y"),
  default_aes = aes(size=0.05, emoji="1f697"),
#  guide_geom = "emoji",

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

#GeomEmoji <- proto(ggplot2:::Geom, {
#
#  objname <- "emoji"
#  desc <- "Emojis!!!"
#
#  draw <- function(., data, scales, coordinates, ...) {
#    coords <- coord_transform(coordinates, data, scales)
#    emojisGrob(coords$x, coords$y, coords$size, coords$emoji)
#  }
#
#  draw_legend <- function(., data, ...) {
#    data <- aesdefaults(data, .$default_aes(), list(...))
#
#    with(data, ggname(.$my_name(),
#         emojisGrob(0.05, 0.05, size, emoji)))
#  }
#
#  default_stat <- function(.) StatIdentity
#  required_aes <- c("x", "y")
#  default_aes <- function(.) aes(size=0.05, emoji="1f697")
#  guide_geom <- function(.) "emoji"
#
#  icon <- function(.) # a grob representing the geom for the webpage
#
#  desc_params <- list( # description of the (optional) parameters of draw
#     )
#
#  seealso <- list(
#    geom_point = GeomPoint$desc
#  )
#
#  examples <- function(.) {
#    # examples of the geom in use
#  }
#
#})


geom_emoji <- function(mapping = NULL, data = NULL, stat = "identity",
                       position = "identity", na.rm = FALSE,
                       show.legend = NA, inherit.aes = TRUE, ...) {
  # get the emojipar
  emojipar <- eval(substitute(alist(...)))
  # download the emoji in advance!
  img <- emoji_get(emojipar$emoji)[[1]]

  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomEmoji,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      img   = img,
      ...
    )
  )
}

