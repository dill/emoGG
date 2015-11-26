#' Recolor a phylopic image
#'
#' Internal function to recolour and change alpha levels of a phylopic image.
#'
#' @param img A png object, e.g, from using \code{get_image}.
#' @param alpha A value between 0 and 1, specifying the opacity of the silhouette.
#' @param color Color to plot the silhouette in.
recolor_phylopic <- function(img, alpha = 0.2, color = NULL){

  if (is.null(color)) {
    mat <- matrix(rgb(img[,,1], img[,,2], img[,,3], img[,,4] * alpha),
                  nrow = dim(img)[1])
  } else {
    cols <- col2rgb(color)
    imglen <- length(img[,,1])
    mat <- matrix(ifelse(img[,,4] > 0, rgb(rep(cols[1,1], imglen),
                                           rep(cols[2,1], imglen),
                                           rep(cols[3,1], imglen),
                                           img[,,4]*255*alpha, maxColorValue = 255),
                         rgb(rep(1, imglen),
                             rep(1, imglen),
                             rep(1, imglen),
                             img[,,4]*alpha)), ## make background white for devices
                  nrow = dim(img)[1])       ## that do not support alpha channel
  }

  return(mat)
}
