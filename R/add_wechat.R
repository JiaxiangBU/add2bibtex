globalVariables(c(".", "text"))


#' Add BibTex for a WeChat article URL.
#' @param url URL.
#' @param is_paste Logical, by default \code{TRUE}
#' @export
#' @examples
#' add_wechat("https://mp.weixin.qq.com/s/2-1taZ5o4uzVcGMe5u4P-A", is_paste = FALSE)
add_wechat <- function(url = '', is_paste = TRUE) {
    if (!stringr::str_detect(url, 'weixin')) {
        stop("It is not a weixin url.")
    }
    text <- xml2::read_html(url)

    author <- get_wechat_author(text)

    title <- get_wechat_title(text)

    year <- Sys.Date() %>% str_sub(1, 4)

    howpublished <- text %>%
        rvest::html_nodes('#js_name') %>%
        rvest::html_text() %>%
        stringr::str_trim()

    urldate <- Sys.Date()

    first_name <- stringr::str_replace_all(author, '[\\s\uff0c]', '_')
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

    clip_and_print(output, is_paste = is_paste)
}

#' @importFrom rvest html_nodes html_text
#' @importFrom stringr str_trim
get_wechat_raw_text <- function(html, pattern) {
    html %>%
        rvest::html_nodes(pattern) %>%
        rvest::html_text() %>%
        max %>%
        stringr::str_trim()
}

#' @importFrom stringr str_detect str_trim str_flatten str_extract str_remove_all str_trim str_replace_all
get_wechat_author <- function(text) {
    if (is_wechat_author(text, '#js_author_name')) {
        get_wechat_raw_text(text, '#js_author_name') %>%
            .[!stringr::str_detect(., '\uff1a')] %>%
            stringr::str_trim() %>%
            stringr::str_flatten('') %>%
            stringr::str_extract("[\\p{Han}A-z\\s|:\uff1a\u2014\u2014\uff0c]+")
    } else if (is_wechat_author(text, '#js_author')) {
        get_wechat_raw_text(text, '#js_author') %>%
            stringr::str_remove_all("\u4f5c\u8005|\u7b49") %>%
            stringr::str_trim() %>%
            stringr::str_replace_all("\\s", " and ")
    } else if (is_wechat_author(text, ".rich_media_meta_text")) {
        get_wechat_raw_text(text, ".rich_media_meta_text") %>%
            stringr::str_remove_all("\u4f5c\u8005|\u7b49") %>%
            stringr::str_trim() %>%
            stringr::str_replace_all("\\s", " and ")
    }
}

is_wechat_author <- function(text, pattern) {
    !text %>%
        get_wechat_raw_text(pattern) %>%
        is.na()
}

#' Extract the title of a WeChat article.
#'
#' @param text Character.
#' @importFrom rvest html_nodes html_text
#' @importFrom stringr str_trim
#' @export
get_wechat_title <- function(text) {
    title <- text %>%
        rvest::html_nodes('#activity-name') %>%
        rvest::html_text() %>%
        stringr::str_trim()
    return(title)
}
