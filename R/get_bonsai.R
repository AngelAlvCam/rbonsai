# Load `stringr` and `cli` packages
library("stringr")
library("cli")

get_bonsai <- function(message = NULL) {
    # Build and get bonsai using `cbonsai` in Bash
    optional_args <- if (is.null(message)) {
        ""
    } else {
        paste0(" -m '", message, "'")
    }
    command <- paste0("cbonsai -p", optional_args, " | sed 's/\x1b\\[[0-9;]*m//g'")
    bonsai_text <- system(command, intern = TRUE)

    # Clean bonsai
    bonsai_text <- bonsai_text |>
        str_extract(regex(">(.*)")) |>
        str_replace(">", "")

    # Split bonsai in lines
    window_width <- as.integer(system("tput cols", intern = TRUE))
    window_height <- as.integer(system("tput lines", intern = TRUE))

    bonsai_length <- str_length(bonsai_text)
    starts <- seq(1, bonsai_length, window_width)
    ends <- seq(window_width, bonsai_length, window_width)
    bonsai_lines <- bonsai_text |>
        substring(starts, ends)

    # Identify top padding
    top_row <- suppressWarnings(max(which(str_detect(bonsai_lines, regex("^\\s+$")))))
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

    # Return bonsai
    return(bonsai_lines)
}