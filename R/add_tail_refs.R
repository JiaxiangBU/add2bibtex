#' Add reference tag into quote paragraphs.
#'
#' @importFrom readr read_lines write_lines
#' @importFrom stringr str_which
#' @param path The RMarkdown document path.
#' @param append_text The BibTex alias.
#' @export
add_tail_refs <-
    function(path = "jiangning_weaving/analysis/para_length_5_notes.Rmd", append_text = '[@吴蔚_2017江宁织造]') {
        lines <- readr::read_lines(path)
        quote_index <- lines %>%
            stringr::str_which("^>\\s")
        lines[quote_index] <- paste(lines[quote_index], append_text)
        lines %>% readr::write_lines(path)
    }
