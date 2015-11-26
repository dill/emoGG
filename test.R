# try out emoji in ggplot2


library(RCurl)
library(png)
library(grid)
source("recolor_phylopic.r")
source("add_phylopic.r")
source("emoji_get.R")

# load the emojis
load("data/emojis.RData")

# use Twitter's emoji CDN
# more info: https://github.com/twitter/twemoji



#id <- "1f4a9"
id <- "1f697"

pp <- emoji_get(id)[[1]]


# working example
library(ggplot2)
#posx <- runif(50, 0, 10)
#posy <- runif(50, 0, 10)
#sizey <- runif(50, 0.4, 2)
#cols <- sample(c("black", "darkorange", "grey42", "white"), 50, replace = TRUE)
#
###cat <- get_image("23cd6aa4-9587-4a2e-8e26-de42885004c9", size = 128)[[1]]
#cat <- pp
#p <- ggplot(data.frame(x = posx, y = posy), aes(x, y)) +
#            geom_point(color = rgb(0,0,0,0))
#for (i in 1:50) {
#  p <- p + add_phylopic(cat, 1, posx[i], posy[i], sizey[i])#, cols[i])
#}

p <- ggplot(mtcars, aes(wt, mpg))+
      geom_point(color = rgb(0,0,0,0))
for (i in 1:nrow(mtcars)) {
  p <- p + add_phylopic(pp, 1, mtcars$wt[i], mtcars$mpg[i], 1)
}
print(p)


