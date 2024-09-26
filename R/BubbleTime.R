#' BubbleTime: `r read.dcf(file = "DESCRIPTION", fields = "Title")`.
#'
#' `r read.dcf(file = "DESCRIPTION", fields = "Description")`
#'
#' The BubbleTime package provides example data, parameters, as well as four
#' families of functions: loaders, calculations, figures, and helpers.
#' Calculations are based on the collective agreement for biologists (see
#' [dive_pars]).
#'
#' @section Data: The data are dive times ([dives]), dive parameters
#'   ([dive_pars]), and simplified dive times ([dives_simple]) for internal
#'   use/testing.
#'
#' @section Loaders functions: The loaders functions are [load_dives()].
#'
#' @section Calculations functions: The calculations functions are
#'   [calc_raw_mins()], [adjust_time()], [calc_period()], and
#'   [calc_daily_hrs()].
#'
#' @section Figures functions: The figures functions are [plot_daily_mins()] and
#'   [plot_cumulative_hrs()].
#'
#' @section Helpers functions: The helpers functions are [choose_file()] and
#'   [dive_buddy()].
#'
#' @name BubbleTime-package
#' @keywords internal
"_PACKAGE"
NULL
