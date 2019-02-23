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
#' @export

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
    if (type == 'more') {
        cat("More types are under development, please click")
        cat("https://jiaxiangli.netlify.com/2018/03/10/bibtex/")
    }

        clipr::write_clip(text)
        cat(text)
        cat("\nThis bibtex is already pasted on your clipboard.")
}

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
