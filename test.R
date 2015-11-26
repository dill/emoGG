# try out emoji in ggplot2


library(RCurl)
source("recolor_phylopic.r")
source("add_phylopic.r")

# load the emojis
load("data/emojis.RData")

# use Twitter's emoji CDN
# more info: https://github.com/twitter/twemoji
cdn <- "https://twemoji.maxcdn.com/"
size <- "72x72"
size <- "128x128"
#size <- "36x36"
sep <- "/"
id <- "1f638"
format <- ".png"

url <- paste0(cdn, size, sep, id, format)

pp <- readPNG(getURLContent(url))

#' @export
#' @rdname emoji_get
emoji_get <- function(input, size){
  size <- match.arg(as.character(size), c("16", "36", "72"))

  if(is(input, "image_info")){
    if(!size %in% c('thumb','icon')){
      urls <- input[ as.character(input$height) == size , "url" ]
      urls <- sapply(urls, function(x) file.path("http://phylopic.org", x), USE.NAMES = FALSE)
    } else {
      urls <- paste0(gsub("\\.64\\.png", "", unname(daply(input, .(uuid), function(x) x$url[1]))), sprintf(".%s.png", size))
      urls <- sapply(urls, function(x) file.path("http://phylopic.org", x), USE.NAMES = FALSE)
    }
    lapply(urls, function(x) readPNG(getURLContent(x)))
  } else {
    lapply(input, function(x) readPNG(getURLContent(paste0("http://phylopic.org/assets/images/submissions/", x, ".", size, ".png"))))    
  }
}


library(ggplot2)
posx <- runif(50, 0, 10)
posy <- runif(50, 0, 10)
sizey <- runif(50, 0.4, 2)
cols <- sample(c("black", "darkorange", "grey42", "white"), 50, replace = TRUE)

##cat <- get_image("23cd6aa4-9587-4a2e-8e26-de42885004c9", size = 128)[[1]]
cat <- pp
p <- ggplot(data.frame(x = posx, y = posy), aes(x, y)) +
            geom_point(color = rgb(0,0,0,0))
for (i in 1:50) {
  p <- p + add_phylopic(cat, 1, posx[i], posy[i], sizey[i])#, cols[i])
}



