#' Bib(La)tex template
#'
#' This function helps users to add Add a bib(La)tex template

#' @return Character.
#' @author Jiaxiang Li
#'
#' @importFrom clipr write_clip
#' @export

add_bibtex <- function(type = 'online'){

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
        clipr::write_clip(text)
        cat(text)
        cat("\nThis bibtex is already pasted on your clipboard.")
    }
}
