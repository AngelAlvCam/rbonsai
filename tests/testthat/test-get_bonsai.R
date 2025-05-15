test_that("`get_bonsai` returns a string", {
    expect_true(is.character(get_bonsai()))
    expect_true(is.character(get_bonsai("Hello World!")))
})

test_that("`get_bonsai` returns a non-empty string", {
    expect_true(str_length(paste0(get_bonsai(), collapse = "")) > 0)
    expect_true(str_length(paste0(get_bonsai("Hello World!"), collapse = "")) > 0)
})

test_that("`get_bonsai` generates a bonsai with the specified message", {
    expect_match(paste0(get_bonsai("Hello"), collapse = ""), "Hello", fixed = TRUE)
    expect_match(paste0(get_bonsai("12345"), collapse = ""), "12345", fixed = TRUE)
})