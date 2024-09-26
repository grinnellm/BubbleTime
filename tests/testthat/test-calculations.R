# TODO: Do tests with different dive_pars values using ...
test_that("Determine dive period", {
  expect_equal(
    calc_period(dat = dives_simple, dive_period = dive_pars$dive_period),
    c(1, 1, 2, 1, 1)
  )
  expect_equal(
    calc_period(dat = dives_simple, dive_period = 1),
    c(1, 5, 10, 1, 3)
  )
  expect_equal(
    calc_period(dat = dives_simple, dive_period = 2),
    c(1, 3, 5, 1, 2)
  )
  expect_equal(
    calc_period(dat = dives_simple, dive_period = 3),
    c(1, 2, 4, 1, 1)
  )
  expect_equal(
    calc_period(dat = dives_simple, dive_period = 4),
    c(1, 2, 3, 1, 1)
  )
  expect_equal(
    calc_period(dat = dives_simple, dive_period = 5),
    c(1, 1, 2, 1, 1)
  )
  expect_equal(
    calc_period(dat = dives_simple, dive_period = 10),
    c(1, 1, 1, 1, 1)
  )
})

# TODO: Do tests with different dive_pars values using ...
test_that("Calculate raw dive time", {
  expect_equal(
    calc_raw_mins(dat = dives) %>%
      dplyr::pull(Time) %>%
      sum(),
    1052
  )
  expect_equal(
    calc_raw_mins(dat = dives, dive_period = 2) %>%
      dplyr::pull(Time) %>%
      sum(),
    1052
  )
  expect_equal(
    calc_raw_mins(dat = dives, dive_period = 20) %>%
      dplyr::pull(Time) %>%
      sum(),
    1052
  )
  expect_equal(
    load_dives(
      file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
    ) %>%
      calc_raw_mins() %>%
      dplyr::pull(Time) %>%
      sum(),
    1052
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
    36
  )
  expect_equal(
    load_dives(
      file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
    ) %>%
      calc_raw_mins() %>%
      calc_daily_hrs() %>%
      dplyr::select(-Date) %>%
      sum(),
    36
  )
})
