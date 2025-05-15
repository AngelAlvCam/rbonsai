# Load `stringr` package
library("stringr")

get_bonsai_frame <- function(message = NULL) {
    bonsai_lines <- get_bonsai(message)
    bonsai_width <- str_length(bonsai_lines[1])

    # Build frame based on the `bonsai_lines` object
    bonsai_frame <- data.frame(
        str_split_fixed(bonsai_lines, "", bonsai_width),
        check.names = FALSE
    )
    return(bonsai_frame)
}