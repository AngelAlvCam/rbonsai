test_that("`rbonsai` prints something", {
    expect_output(rbonsai())
    expect_output(rbonsai("Hello World!"))
})