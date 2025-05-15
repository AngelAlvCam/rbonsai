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

# Identify top padding
max_row <- max(which(str_detect(bonsai_lines, regex("^\\s+$"))))
if (!is.finite(max_row)) {
    max_row <- 1
}

# Identify left and right padding
list <- str_locate_all(bonsai_lines, regex("[^' ']"))
min_index = t_cols
max_index = 1
for (i in seq(1, t_rows)) {
    if (length(list[[i]] > 0)) {
        print(list[[i]][1,1])
        min_index <- min(min_index, list[[i]][1, 1])
        max_index <- max(max_index, list[[i]][nrow(list[[i]]), 1])
    }
}

# Remove padding from `bonsai_lines`
bonsai_lines <- bonsai_lines[seq(max_row + 1, t_rows)] |>
    substring(min_index, max_index)