#' @export


add_wechat <- function(url = '') {
    if (!stringr::str_detect(url, 'weixin')) {
        stop("It is not a weixin url.")
    }
    text <- xml2::read_html(url)

    author <- get_wechat_author(text)

    title <- text %>%
        rvest::html_nodes('#activity-name') %>%
        rvest::html_text() %>%
        stringr::str_trim()

    year <- Sys.Date() %>% str_sub(1, 4)

    howpublished <- text %>%
        rvest::html_nodes('#js_name') %>%
        rvest::html_text() %>%
        stringr::str_trim()

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

#' @importFrom rvest html_nodes html_text
get_wechat_raw_text <- function(html, pattern) {
    html %>%
        rvest::html_nodes(pattern) %>%
        rvest::html_text() %>%
        max
}

#' @importFrom stringr str_detect str_trim str_flatten str_extract str_remove_all str_trim str_replace_all
get_wechat_author <- function(text) {
    if (!text %>%
        get_wechat_raw_text('#js_author_name') %>%
        is.na()) {
        get_wechat_raw_text(text, '#js_author_name') %>%
            .[!stringr::str_detect(., '：')] %>%
            stringr::str_trim() %>%
            stringr::str_flatten('') %>%
            stringr::str_extract("[\\p{Han}A-z\\s|:：——，]+")
    } else if (!text %>%
               get_wechat_raw_text('#js_author') %>%
               is.na()) {
        get_wechat_raw_text(text, '#js_author') %>%
            stringr::str_remove_all("作者|等") %>%
            stringr::str_trim() %>%
            stringr::str_replace_all("\\s", " and ")
    }
}
