#' Bib(La)tex template
#'
#' This function helps users to add Add a bib(La)tex template

#' @return Character.
#' @author Jiaxiang Li
#'
#' @importFrom clipr write_clip
#' @export

add_bibtex <- function(type = 'more'){

    if (type == 'online') {
        text <-
        "
@online{Li2019,
  author = {Jiaxiang Li},
  title = {add2bibtex: Add bib(La)tex},
  year = 2019,
  howpublished = {add2bibtex},
  url = {https://github.com/JiaxiangBU/add2bibtex},
  urldate = {2019-01-31}
}
        "
    }
    if (type == 'more') {
        cat("More types are under development, please click")
        cat("https://jiaxiangli.netlify.com/2018/03/10/bibtex/")
    }

        clipr::write_clip(text)
        cat(text)
        cat("\nThis bibtex is already pasted on your clipboard.")
}
