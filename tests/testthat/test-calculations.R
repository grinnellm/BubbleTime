# TODO: Do tests with different dive_pars values using ...
test_that("Determine dive period", {
})

# TODO: Do tests with different dive_pars values using ...
test_that("Calculate raw dive time", {
  expect_equal(
    calc_raw_mins(dat = dives) %>%
      dplyr::pull(Time) %>%
      sum(),
    1054
  )
  expect_equal(
    load_dives(
      file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
    ) %>%
      calc_raw_mins() %>%
      dplyr::pull(Time) %>%
      sum(),
    1054
  )
  expect_silent(calc_raw_mins(dat = dives))
  expect_error(
    calc_raw_mins(
      dat = dives %>% dplyr::rename(Jim.Start = Matt.End, Jim.End = Matt.Start)
    )
  )
})

# TODO: Do tests with different dive_pars values using ...
test_that("Adjust daily dive time", {
  expect_type(adjust_time(dive_time = 30), "double")
  expect_error(adjust_time(dive_time = "omega"))
  expect_error(adjust_time(dive_time = -1))
  expect_error(adjust_time(dive_time = NA))
  expect_error(adjust_time(dive_time = Inf))
  expect_error(adjust_time(dive_time = NaN))
  expect_equal(adjust_time(dive_time = 12), 2)
  expect_equal(adjust_time(dive_time = 122), 2.25)
  expect_equal(adjust_time(dive_time = 0), 0)
})

# TODO: Do tests with different dive_pars values using ...
test_that("Calculate adjusted daily dive time", {
  expect_equal(
    calc_raw_mins(dat = dives) %>%
      calc_daily_hrs() %>%
      dplyr::select(-Date) %>%
      sum(),
    29
  )
  expect_equal(
    load_dives(
      file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
    ) %>%
      calc_raw_mins() %>%
      calc_daily_hrs() %>%
      dplyr::select(-Date) %>%
      sum(),
    29
  )
})
