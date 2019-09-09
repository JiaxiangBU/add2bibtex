#' BibTex and BibLaTex template
#'
#' This function helps users to add Add a bib(La)tex template
#'
#' @return Character.
#' @author Jiaxiang Li
#'
#' @importFrom clipr write_clip
#' @importFrom glue glue
#' @import stringr
#' @importFrom xfun read_utf8
#' @import rvest
#' @import xml2
#' @export

# add_bibtex --------------------------------------------------------------

add_bibtex <- function(type = 'more') {
  current_date <- Sys.Date()
  if (type == 'online') {
    text <- glue::glue(
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
  , .open = "<"
  , .close = ">"
    )
  }

if (type == 'book') {
  text <- glue::glue(
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
, .open = "<"
, .close = ">"
  )
}

if (type == 'manual') {
  text <- glue::glue(
    "
@manual{Li2019,
  title = {add2bibtex: Add bib(La)tex},
  subtitle = {Easily Adding Bibliographies and Citations},
  author = {Jiaxiang Li},
  year = {2019},
  url = {https://github.com/JiaxiangBU/add2bibtex}
}
        "
, .open = "<"
, .close = ">"
  )
}

if (type == 'more') {
  cat("More types are under development, please click")
  cat("https://jiaxiangli.netlify.com/2018/03/10/bibtex/")
}

clip_and_print(text)
}


# add_kaggle --------------------------------------------------------------
#' @export


add_kaggle <- function(url = '') {
  if (!stringr::str_detect(url, 'kaggle')) {
    stop("It is not a kaggle url.")
  }
  text <- xfun::read_utf8(url) %>% stringr::str_flatten("\n")

  author <-
    text %>% stringr::str_match('"displayName":"([A-z\\s]+)"') %>% .[2]

  title <-
    text %>% stringr::str_match('<title>([A-z\\s|:]+)</title>') %>% .[2]

  year <-
    text %>% stringr::str_match('"updatedTime":"([\\d]{4})') %>% .[2]

  howpublished <- "Kaggle"

  urldate <- Sys.Date()

  first_name <- stringr::str_replace_all(author, '\\s', '_')
  alias <- stringr::str_c(first_name, year)

  output <- glue::glue(
    "@online{<<alias>>,
        author = {<<author>>},
        title = {<<title>>},
        year = <<year>>,
        howpublished = {<<howpublished>>},
        url = {<<url>>},
        urldate = {<<urldate>>}
  }"
    ,
    .open = "<<"
    ,
    .close = ">>"
  )

  clip_and_print(output)
}



#' @export
# add_datacamp ------------------------------------------------------------


add_datacamp <- function(url = '') {
  if (!stringr::str_detect(url, 'datacamp')) {
    stop("It is not a datacamp url.")
  }
  text <- xml2::read_html(url)

  author <- text %>%
    rvest::html_nodes('.course__instructor-name') %>%
    rvest::html_text()

  title <- text %>%
    rvest::html_nodes('.header-hero__title') %>%
    rvest::html_text()

  year <- Sys.Date() %>% str_sub(1, 4)

  howpublished <- "DataCamp"

  urldate <- Sys.Date()

  first_name <- stringr::str_replace_all(author, '[\\s，]', '_')
  alias <- stringr::str_c(first_name, year)

  output <- glue::glue(
    "@online{<<alias>>,
    author = {<<author>>},
    title = {<<title>>},
    year = <<year>>,
    howpublished = {<<howpublished>>},
    url = {<<url>>},
    urldate = {<<urldate>>}
    }"
    ,
    .open = "<<"
    ,
    .close = ">>"
  )

  clip_and_print(output)
}
