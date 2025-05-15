# Load necessary libraries
library("stringr")

rbonsai <- function() {
    # Build and get bonsai using `cbonsai` in Bash
    bonsai_text <- system("cbonsai -p | sed 's/\x1b\\[[0-9;]*m//g'", intern = TRUE)

    # Clean bonsai
    bonsai_text <- bonsai_text |>
        str_extract(regex(">(.*)")) |>
        str_replace(">", "")

    # Get terminal dimensions
    dims <- system("stty size", intern = TRUE) |>
        str_split(" ")
    dims <- as.integer(dims[[1]])
    window_height <- dims[1]
    window_width <- dims[2]

    # Split bonsai in lines
    bonsai_length <- str_length(bonsai_text)
    starts <- seq(1, bonsai_length, window_width)
    ends <- seq(window_width, bonsai_length, window_width)
    bonsai_lines <- bonsai_text |>
        substring(starts, ends)

    # Identify top padding
    top_row <- max(which(str_detect(bonsai_lines, regex("^\\s+$"))))
    if (!is.finite(top_row)) {
        top_row <- 1
    }

    # Identify left and right padding
    list <- str_locate_all(bonsai_lines, regex("[^' ']"))
    left_col = window_width 
    right_col = 1
    for (i in seq(1, window_height)) {
        if (length(list[[i]] > 0)) {
            left_col <- min(left_col, list[[i]][1, 1])
            right_col <- max(right_col, list[[i]][nrow(list[[i]]), 1])
        }
    }

    # Remove padding from `bonsai_lines`
    bonsai_lines <- bonsai_lines[seq(top_row + 1, window_height)] |>
        substring(left_col, right_col)

    # Print the bonsai
    cat(bonsai_lines, sep = "\n")
}