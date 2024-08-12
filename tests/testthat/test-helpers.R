# test_that("Manually choose a file",{
# })

test_that("Dive buddy has your back", {
  expect_true(
    "list" == class(
      dive_buddy(
        file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
      )
    )
  )
  expect_true("Rplots.pdf" %in% list.files())
  # file.remove("Rplots.pdf")
  expect_true(
    "list" == class(
      dive_buddy(
        file_path = system.file("extdata", "dives.csv", package = "BubbleTime"),
        save_plot = TRUE, save_csv = TRUE
      )
    )
  )
  file.remove(
    here("raw_mins.csv"), here("daily_hrs.csv"), here("plot_daily.png"),
    here("plot_cumulative.png")
  )
})
