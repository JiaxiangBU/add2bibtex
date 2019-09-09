clip_and_print <- function(output) {
    clipr::write_clip(output)
    cat(output)
    cat("\n\n\n")
    cat("\nThis bibtex is already pasted on your clipboard.")
}

read_html <- function(...) {
    xml2::read_html(...)
}
