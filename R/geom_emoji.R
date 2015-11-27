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
emojisGrob <- function(x, y, size, code){

   img <- emoji_get(code)[[1]]
   rasterGrob(x             = x,
              y             = y,
              image         = img,
              default.units = "native",
              height        = size,
              width         = size)
}

GeomEmoji <- proto(ggplot2:::Geom, {

  objname <- "emoji"
  desc <- "Emojis!!!"

  draw <- function(., data, scales, coordinates, ...) {
    coords <- coord_transform(coordinates, data, scales)
    emojisGrob(coords$x, coords$y, coords$size, coords$code)
  }

  draw_legend <- function(., data, ...) {
    data <- aesdefaults(data, .$default_aes(), list(...))

    with(data, ggname(.$my_name(),
        emojisGrob(0.5, 0.5, size, code) )
    )
  }

  default_stat <- function(.) StatIdentity
  required_aes <- c("x", "y")
  default_aes <- function(.) aes(size=0.05, code="1f697")
  guide_geom <- function(.) "emoji"

  icon <- function(.) # a grob representing the geom for the webpage

  desc_params <- list( # description of the (optional) parameters of draw
     )

  seealso <- list(
    geom_point = GeomPoint$desc
  )

  examples <- function(.) {
    # examples of the geom in use
  }

})


geom_emoji <- function(mapping = NULL, data = NULL, stat = "identity",
                       position = "identity", na.rm = FALSE,
                       show.legend = NA, inherit.aes = TRUE, ...) {
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
      ...
    )
  )
}

