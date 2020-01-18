
<!-- README.md is generated from README.Rmd. Please edit that file -->

# add2bibtex

<!-- badges: start -->

[![DOI](https://zenodo.org/badge/168483185.svg)](https://zenodo.org/badge/latestdoi/168483185)
[![Travis build
status](https://travis-ci.org/JiaxiangBU/add2bibtex.svg?branch=master)](https://travis-ci.org/JiaxiangBU/add2bibtex)
<!-- badges: end -->

The goal of add2bibtex is to help users to easily to use bibtex or
bibLatex.

## Installation

You can install the released version of add2bibtex from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("add2bibtex")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JiaxiangBU/add2bibtex")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(add2bibtex)
## basic example code
```

``` r
library(add2bibtex)
```

``` r
add_kaggle("https://www.kaggle.com/lijiaxiang/stacking", is_paste = FALSE)
#> @online{Jiaxiang_Li2019,
#>       author = {Jiaxiang Li},
#>       title = {stacking | Kaggle},
#>       year = 2019,
#>       howpublished = {Kaggle},
#>       url = {https://www.kaggle.com/lijiaxiang/stacking},
#>       urldate = {2020-01-18}
#> }
#> 
#> 
#> 
#> This bibtex is already pasted on your clipboard.
```

``` r
add_datacamp(
  "https://www.datacamp.com/courses/extreme-gradient-boosting-with-xgboost",
  is_paste = FALSE
)
#> @online{Sergey_Fogelson2020,
#> author = {Sergey Fogelson},
#> title = {Extreme Gradient Boosting with XGBoost},
#> year = 2020,
#> howpublished = {DataCamp},
#> url = {https://www.datacamp.com/courses/extreme-gradient-boosting-with-xgboost},
#> urldate = {2020-01-18}
#> }
#> 
#> 
#> 
#> This bibtex is already pasted on your clipboard.
```

``` r
add_bibtex("book", is_paste = FALSE)
#> @book{Li2019,
#>   author    = {Jiaxiang Li},
#>   title     = {add2bibtex: Add bib(La)tex},
#>   publisher = {add2bibtex},
#>   year      = 2019,
#>   volume    = 1,
#>   series    = 1,
#>   address   = {Shanghai},
#>   edition   = 1,
#>   month     = 1,
#>   note      = {An optional note},
#>   isbn      = {111111111}
#> }
#> 
#> 
#> 
#> This bibtex is already pasted on your clipboard.
add_bibtex("manual", is_paste = FALSE)
#> @manual{Li2019,
#>   title = {add2bibtex: Add bib(La)tex},
#>   subtitle = {Easily Adding Bibliographies and Citations},
#>   author = {Jiaxiang Li},
#>   year = {2019},
#>   url = {https://github.com/JiaxiangBU/add2bibtex}
#> }
#> 
#> 
#> 
#> This bibtex is already pasted on your clipboard.
add_bibtex("online", is_paste = FALSE)
#> @online{Li2019,
#>   author = {Jiaxiang Li},
#>   title = {add2bibtex: Add bib(La)tex},
#>   year = 2019,
#>   howpublished = {add2bibtex},
#>   url = {https://github.com/JiaxiangBU/add2bibtex},
#>   urldate = {2020-01-18}
#> }
#> 
#> 
#> 
#> This bibtex is already pasted on your clipboard.
add_bibtex("more", is_paste = FALSE)
#> More types are under development, please click
#> 
#> 
#>           https://jiaxiangli.netlify.com/2018/03/10/bibtex/
```

``` r
add_wechat("https://mp.weixin.qq.com/s/2-1taZ5o4uzVcGMe5u4P-A", is_paste = FALSE)
#> Warning in max(.): 所有的参数都不存在; 回覆NA

#> Warning in max(.): 所有的参数都不存在; 回覆NA
#> @online{王迪2020,
#>   author = {王迪},
#>   title = {案例分享 | TensorFlow 助力网易严选供应链需求预测（系列之四）},
#>   year = 2020,
#>   howpublished = {TensorFlow},
#>   url = {https://mp.weixin.qq.com/s/2-1taZ5o4uzVcGMe5u4P-A},
#>   urldate = {2020-01-18}
#> }
#> 
#> 
#> 
#> This bibtex is already pasted on your clipboard.
```
