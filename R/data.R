#' Dive times.
#'
#' Table with example dive times. The first column is date (YYYY-MM-DD), the
#' second column is transect. Other columns are start and end times (HH:MM) in
#' 24-hour clock for each diver. Column names must be in the format "Matt.Start"
#' and "Matt.End."
#'
#' @format Tibble with rows for transects and columns for divers.
#' @docType data
#' @importFrom Rdpack reprompt
#' @seealso [load_dives()]
#' @family data
#' @note Dives that span midnight must be entered as two separate dives: the
#'   first part of the dive (before midnight) on the first day and the second
#'   part (after midnight) on the next day. See dive times for Transect 119.
#' @examples
#' dives
"dives"

#' Parameters for dive time calculations.
#'
#' Parameters for daily dive time calculations according to the collective
#' agreement for biologists (see notes).
#'
#' @format List with items:
#' \describe{
#'   \item{min_time}{Minimum dive time in minutes.}
#'   \item{round_hr}{Round up to nearest portion of an hour (i.e., 0.25 rounds
#'     up to the nearest 1/4 hour).}
#'   \item{dive_period}{Period of time in hours that is equal to one dive day.}
#' }
#' @docType data
#' @importFrom Rdpack reprompt
#' @seealso [adjust_time()] [calc_period()]
#' @family data
#' @note Relevant section in the [collective agreement for
#'   biologists](https://www.tbs-sct.canada.ca/agreements-conventions/view-visualiser-eng.aspx?id=3#tocxx245084).
#'
#' **Article 22: diving allowance**
#'
#' **22.01** Employees whose job duties require them to dive (as that word is
#'   hereinafter defined) shall be paid an extra allowance of twenty-five
#'   dollars ($25) per hour. The minimum allowance shall be two (2) hours per
#'   dive.
#'
#'   **22.02** A dive is the total of any period or periods of time during any
#'   eight (8) hour period in which an employee carries out required underwater
#'   work with the aid of a self-contained air supply.
#' @examples
#' dive_pars
"dive_pars"
