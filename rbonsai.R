# Load necessary libraries
library("stringr")

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
t_rows <- dims[1]
t_cols <- dims[2]

# Split bonsai in lines
bonsai_length <- str_length(bonsai_text)
starts <- seq(1, bonsai_length, t_cols)
ends <- seq(t_cols, bonsai_length, t_cols)
bonsai_lines <- bonsai_text |>
    substring(starts, ends)

# Remove top padding
max_row <- max(which(str_detect(bonsai_lines, regex("^\\s+$"))))
if (!is.finite(max_row)) {
    max_row <- 1
}

