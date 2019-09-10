#' @importFrom rvest html_nodes html_text
#' @importFrom readr read_lines
#' @importFrom stringr str_subset str_trim
#'
get_amazon_cn_table <- function(html) {
    html %>%
        rvest::html_nodes("#detail_bullets_id") %>%
        rvest::html_text(trim = TRUE) %>%
        readr::read_lines() %>%
        .[. != ""] %>%
        stringr::str_subset("^[\\p{Han}[A-z]]+") %>%
        stringr::str_subset("：|:\\s") %>%
        stringr::str_trim()
}

#' @importFrom stringr str_subset str_extract str_trim
#'
get_amazon_cn_isbn <- function(html) {
    html %>%
        get_amazon_cn_table() %>%
        stringr::str_subset("ASIN") %>%
        stringr::str_extract("[A-Z0-9]+$") %>%
        stringr::str_trim()
}


get_amazon_cn_title <- function(html) {
    title_text <-
        html %>%
        get_wechat_raw_text("#ebooksProductTitle")
    return(title_text)
}

#' @importFrom rvest html_nodes html_attr
#'
get_amazon_cn_html_sub <- function(html) {
    html_sub <-
        html %>%
        rvest::html_nodes("meta") %>%
        rvest::html_attr("content")
}



get_amazon_cn_publisher <- function(html) {
    html %>%
        get_amazon_cn_html_sub() %>%
        str_extract("\\p{Han}+出版社") %>%
        max(na.rm = TRUE)

}



get_amazon_cn_edition <- function(html) {
    edition_text <-
        html %>%
        get_amazon_cn_html_sub() %>%
        str_extract("第\\d+版") %>%
        str_extract("\\d+") %>%
        max(na.rm = TRUE)
    return(edition_text)


}



get_amazon_cn_html_sub2 <- function(html) {
    text_sub <-
        html %>%
        html_nodes("ul") %>%
        html_text() %>%
        str_trim()
    return(text_sub)
}

get_amazon_cn_date <- function(html) {
    date_text <-
        html %>%
        get_amazon_cn_html_sub2() %>%
        str_extract("\\d{4}年\\d+月") %>%
        max(na.rm = TRUE)
    return(date_text)
}

get_amazon_cn_year <- function(date_text) {
    year_text <-
        date_text %>%
        str_extract("\\d{4}年") %>%
        str_extract("\\d{4}")
    return(year_text)
}

get_amazon_cn_month <- function(date_text) {
    month_text <-
        date_text %>%
        str_extract("\\d+月") %>%
        str_extract("\\d+")
    return(month_text)
}

get_amazon_cn_author <- function(html) {
    a_nodes <- html %>%
        html_nodes(".a-link-normal")
    a_class <- a_nodes %>%
        html_attr("href")
    a_index <- a_class %>% str_which("field-author")
    author_text <-
        a_nodes %>%
        html_text() %>%
        .[a_index]
    return(author_text)
}

#' @importFrom xml2 read_html
#' @importFrom glue glue
#' @importFrom stringr str_replace_all
#' @export
add_amazon_cn <- function(url) {
    html <-
        xml2::read_html(
            url
        )
    author <- get_amazon_cn_author(html)
    title <- get_amazon_cn_title(html)
    publisher <- get_amazon_cn_publisher(html)
    year <- get_amazon_cn_year(html)
    edition <- get_amazon_cn_edition(html)
    month <- get_amazon_cn_month(html)
    isbn <- get_amazon_cn_isbn(html)
    reference <-
        paste(author, year) %>% stringr::str_replace_all("[[:punct:]\\s]", "_")

    bibtex_text <- glue::glue(
        "@book{<reference>,
    author    = {<author>},
    title     = {<title>},
    publisher = {<publisher>},
    year      = <year>,
    edition   = <edition>,
    month     = <month>,
    isbn      = {<isbn>}
  }",
        .open = "<",
        .close = ">"
    )
    clip_and_print(bibtex_text)
    invisible(bibtex_text)
}
