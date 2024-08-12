test_that("Dive times", {
  expect_true(tibble::is_tibble(dives))
  expect_equal(dim(dives), c(17, 10))
  expect_equal(class(dives$Date), "Date")
  expect_equal(class(dives$Transect), "character")
  expect_named(
    dives, c(
      "Date", "Transect", "Matt.Start", "Matt.End", "Mike.Start", "Mike.End",
      "Seaton.Start", "Seaton.End", "Sarah.Start", "Sarah.End"
    )
  )
})

test_that("Parameters for dive time calculations", {
  expect_type(dive_pars, "list")
  expect_named(dive_pars, c("min_time", "round_hr", "dive_period"))
  expect_setequal(dive_pars, c(120, 0.25, 8))
})
