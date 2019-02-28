#' Bib(La)tex template
#'
#' This function helps users to add Add a bib(La)tex template

#' @return Character.
#' @author Jiaxiang Li
#'
#' @importFrom clipr write_clip
#' @importFrom glue glue
#' @import stringr
#' @importFrom xfun read_utf8
#' @import rvest
#' @importFrom xml2 read_html
#' @export


################################################################################
# add_bibtex
################################################################################

add_bibtex <- function(type = 'more'){
    current_date <- Sys.Date()
    if (type == 'online') {
        text <-glue(
        "
@online{Li2019,
  author = {Jiaxiang Li},
  title = {add2bibtex: Add bib(La)tex},
  year = 2019,
  howpublished = {add2bibtex},
  url = {https://github.com/JiaxiangBU/add2bibtex},
  urldate = {<current_date>}
}
        "
    ,.open = "<"
    ,.close = ">"
    )
    }

    if (type == 'book') {
        text <-glue(
        "
@book{Li2019,
  author    = {Jiaxiang Li},
  title     = {add2bibtex: Add bib(La)tex},
  publisher = {add2bibtex},
  year      = 2019,
  volume    = 1,
  series    = 1,
  address   = {Shanghai},
  edition   = 1,
  month     = 1,
  note      = {An optional note},
  isbn      = {111111111}
}
        "
    ,.open = "<"
    ,.close = ">"
    )
    }

    if (type == 'more') {
        cat("More types are under development, please click")
        cat("https://jiaxiangli.netlify.com/2018/03/10/bibtex/")
    }

        clipr::write_clip(text)
        cat(text)
        cat("\nThis bibtex is already pasted on your clipboard.")
}

################################################################################
# add_kaggle
################################################################################

add_kaggle <- function(url = ''){
    if (!stringr::str_detect(url,'kaggle')) {
        stop("It is not a kaggle url.")
    }
    text <- xfun::read_utf8(url) %>% stringr::str_flatten("\n")

    author <- text %>% stringr::str_match('"displayName":"([A-z\\s]+)"') %>% .[2]

    title <- text %>% stringr::str_match('<title>([A-z\\s|:]+)</title>') %>% .[2]

    year <- text %>% stringr::str_match('"updatedTime":"([\\d]{4})') %>% .[2]

    howpublished <- "Kaggle"

    urldate <- Sys.Date()

    first_name <- stringr::str_replace_all(author,'\\s','_')
    alias <- stringr::str_c(first_name,year)

    output <- glue::glue("@online{<<alias>>,
  author = {<<author>>},
  title = {<<title>>},
  year = <<year>>,
  howpublished = {<<howpublished>>},
  url = {<<url>>},
  urldate = {<<urldate>>}
  }"
    ,.open = "<<"
    ,.close = ">>"
    )

    clipr::write_clip(output)
    cat(output)
    cat("\nThis bibtex is already pasted on your clipboard.")
}

################################################################################
# add_wechat
################################################################################

add_wechat <- function(url = ''){
  if (!stringr::str_detect(url,'weixin')) {
    stop("It is not a weixin url.")
  }
  text <- xml2::read_html(url)

  author <- text %>%
    html_nodes('.rich_media_meta_text') %>%
    html_text() %>%
    .[!str_detect(.,'：')] %>%
    str_trim() %>%
    str_flatten('') %>%
    str_extract("[\\p{Han}A-z\\s|:：——，]+")

  title <- text %>%
    html_nodes('#activity-name') %>%
    html_text() %>%
    str_extract("[\\p{Han}A-z\\s|:——]+") %>%
    str_trim()

  year <- Sys.Date() %>% str_sub(1,4)

  howpublished <- text %>%
    html_nodes('#js_name') %>%
    html_text() %>%
    str_trim()

  urldate <- Sys.Date()

  first_name <- stringr::str_replace_all(author,'[\\s，]','_')
  alias <- stringr::str_c(first_name,year)

  output <- glue::glue("@online{<<alias>>,
    author = {<<author>>},
    title = {<<title>>},
    year = <<year>>,
    howpublished = {<<howpublished>>},
    url = {<<url>>},
    urldate = {<<urldate>>}
    }"
                       ,.open = "<<"
                       ,.close = ">>"
  )

  clipr::write_clip(output)
  cat(output)
  cat("\nThis bibtex is already pasted on your clipboard.")
}

################################################################################
# add_datacamp
################################################################################

add_datacamp <- function(url = ''){
  if (!stringr::str_detect(url,'datacamp')) {
    stop("It is not a datacamp url.")
  }
  text <- xml2::read_html(url)

  author <- text %>%
    html_nodes('.course__instructor-name') %>%
    html_text()

  title <- text %>%
    html_nodes('.header-hero__title') %>%
    html_text()

  year <- Sys.Date() %>% str_sub(1,4)

  howpublished <- "DataCamp"

  urldate <- Sys.Date()

  first_name <- stringr::str_replace_all(author,'[\\s，]','_')
  alias <- stringr::str_c(first_name,year)

  output <- glue::glue("@online{<<alias>>,
    author = {<<author>>},
    title = {<<title>>},
    year = <<year>>,
    howpublished = {<<howpublished>>},
    url = {<<url>>},
    urldate = {<<urldate>>}
    }"
                       ,.open = "<<"
                       ,.close = ">>"
  )

  clipr::write_clip(output)
  cat(output)
  cat("\nThis bibtex is already pasted on your clipboard.")
}
