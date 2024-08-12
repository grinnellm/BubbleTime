test_that("Load dive times from file", {
  expect_true(
    "tbl" %in% class(
      load_dives(
        file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
      )
    )
  )
})
