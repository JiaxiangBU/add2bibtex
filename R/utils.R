clip_and_print <- function(output, is_paste = TRUE) {
    if (is_paste == TRUE) {
        clipr::write_clip(output, allow_non_interactive = TRUE)
    }
    cat(output)
    cat("\n\n\n")
    cat("\nThis bibtex is already pasted on your clipboard.")
    invisible(output)
}

read_html <- function(...) {
    xml2::read_html(...)
}
