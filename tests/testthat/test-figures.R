test_that("Plot daily dive time", {
  expect_is(
    dives %>%
      calc_raw_mins() %>%
      plot_daily_mins(),
    "ggplot"
  )
})

test_that("Plot cumulative dive time", {
  expect_is(
    dives %>%
      calc_raw_mins() %>%
      calc_daily_hrs() %>%
      plot_cumulative_hrs(),
    "ggplot"
  )
})
