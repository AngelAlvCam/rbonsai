test_that("`get_bonsai_frame` returns a data frame", {
    expect_true(is.data.frame(get_bonsai_frame()))
    expect_true(is.data.frame(get_bonsai_frame("Hello World!")))
})

test_that("`get_bonsai_frame` returns a data frame with no NAs", {
    expect_true(!any(is.na.data.frame(get_bonsai_frame())))
    expect_true(!any(is.na.data.frame(get_bonsai_frame("Hello World!"))))
})