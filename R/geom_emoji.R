library(proto)
library(grid)
library(ggplot2)

#geom_emoji <- function (mapping = NULL, data = NULL, stat = "identity",
#                         position = "identity", show_guide = FALSE, ...) {
#  GeomEmoji$new(mapping = mapping, data = data, stat = stat,
#                 position = position, show_guide = show_guide, ...)
#}


emojisGrob <- function(x, y, size, code){

   img <- emoji_get(code)[[1]]
   rasterGrob(x             = x,
              y             = y,
              image         = img,
              default.units = "native",
              height        = size,
              width         = size)
}

# test
## library(RCurl)
## library(png)
## library(grid)
## source("emoji_get.R")
## id <- "1f697"
## pp <- emoji_get(id)[[1]]
## g <- emojiGrob(c(1,0.5), c(1,0.5), 1, pp)
## pushViewport(vp=viewport(width=1, height=1))
## grid.draw(g)

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



#geom_emoji <- GeomEmoji$new()
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

#library(RCurl)
#library(png)
#library(grid)
#source("emoji_get.R")
#acar <- "1f4a9"
##p <- qplot(mpg, wt, data=mtcars, geom="emoji", code=acar, size=cyl)
#p <- ggplot(aes(x=mpg, y=wt), data=mtcars)+
#      geom_emoji(size=I(0.05))#img=I(emoji_get("1f697")[[1]]))
#print(p)




