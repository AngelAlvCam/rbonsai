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

# Build frame by splitting each line into individual characters
bonsai_frame <- data.frame(str_split_fixed(bonsai_lines[seq(max_row, t_rows)], "", t_cols))
min_index_space <- t_cols
max_index_space <- 1
for (r in seq(1, t_rows)) {
    min_index_space <- min(which(bonsai_frame[r, ] != " "), min_index_space)
    max_index_space <- max(which(bonsai_frame[r, ] != " "), max_index_space)
}

# Remove padding at the left and right
bonsai_frame <- bonsai_frame[ , seq(min_index_space, max_index_space)]

# Rename cols
colnames(bonsai_frame) <- rep("+", ncol(bonsai_frame))
options(width = 3 * ncol(bonsai_frame))