---
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# emoGG(plot)

Use emoji in your `ggplot2` plots.

This is silly.

## Installation

```r
devtools::install_github("dill/emoGG")
```

## Usage


```r
library(ggplot2)
#> Loading required package: methods
library(emoGG)
```

First need to find an emoji, using the `emoji_search` function. First look for a tulip:


```r
emoji_search("tulip")
#>            keyword       code     emoji
#> tulip1     flowers \U0001f337     tulip
#> tulip2       plant \U0001f337     tulip
#> tulip3      nature \U0001f337     tulip
#> tulip4      summer \U0001f337     tulip
#> tulip5      spring \U0001f337     tulip
#> copyright1      ip           ©️ copyright
```

The `iris` example with **real** irises (well, tulips...)


```r
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_emoji(emoji="1f337")
```

![plot of chunk iris_ex](figure/iris_ex-1.png) 

What about plotting `mtcars` with **real** cars?


```r
ggplot(mtcars, aes(wt, mpg))+ geom_emoji(emoji="1f697")
```

![plot of chunk mtcars](figure/mtcars-1.png) 

Some random cats?


```r
posx <- runif(50, 0, 10)
posy <- runif(50, 0, 10)
ggplot(data.frame(x = posx, y = posy), aes(x, y)) + geom_emoji(emoji="1f63b")
```

![plot of chunk catplotlib](figure/catplotlib-1.png) 

We can also just put a big emoji in the background:


```r
qplot(x=Sepal.Length, y=Sepal.Width, data=iris, geom="point") + add_emoji(emoji="1f337")
```

![plot of chunk big-emoji](figure/big-emoji-1.png) 

## Acknowledgements

Emoji lookup is from @muan's [`emojilib`](https://github.com/muan/emojilib).

Emoji are loaded from a CDN using Twitter's [`twemoji`](https://github.com/twitter/twemoji), which is [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) licensed. You can get attribution details [on the project page](https://github.com/twitter/twemoji#attribution-requirements).

With apologies, DLM.
