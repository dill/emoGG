# try out emoji in ggplot2


library(RCurl)
library(png)
library(grid)
library(ggplot2)
source("recolor_phylopic.r")
source("add_emoji.r")
source("emoji_get.R")
source("geom_custom.R")


# load the emojis
load("data/emojis.RData")

# use Twitter's emoji CDN
# more info: https://github.com/twitter/twemoji



#id <- "1f4a9"
id <- "1f697"

pp <- emoji_get(id)[[1]]


# working example
#posx <- runif(50, 0, 10)
#posy <- runif(50, 0, 10)
#p <- ggplot(data.frame(x = posx, y = posy), aes(x, y, code=I("1f63b"))) + geom_emoji()


#p <- ggplot(mtcars, aes(wt, mpg, code="1f697"))+ geom_emoji()

# background image
#flower <- emoji_get("1f337" )[[1]]
#qplot(x=Sepal.Length, y=Sepal.Width, data=iris, geom="point") + add_emoji(flower)
