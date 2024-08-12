#' Load dive times from file.
#'
#' Load a table of dive times from a CSV file. See the help file for the [dives]
#' data for required format (i.e., column names and types).
#'
#' @param file_path Path and name of a CSV file with dive time information. See
#'   [dives] for more information.
#' @importFrom Rdpack reprompt
#' @importFrom readr read_csv cols
#' @importFrom plyr round_any
#' @importFrom dplyr select mutate %>%
#' @importFrom lubridate is.Date
#' @return Tibble with rows for transects and columns for diver times.
#' @seealso [dives] [choose_file()]
#' @family loaders functions
#' @note Dives that span midnight must be entered as two separate dives: the
#'   first part of the dive (before midnight) on the first day and the second
#'   part (after midnight) on the next day.
#' @export
#' @examples
#' my_dives <- load_dives(
#'   file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
#' )
#' \dontrun{
#' my_dives <- load_dives(file_path = choose_file())
#' }
load_dives <- function(file_path) {
  # Read the file
  dives <- read_csv(file = file_path, col_types = cols())
  # Ensure Date is date
  if (!is.Date(dives$Date)) stop("Date column must be dates", call. = FALSE)
  # Ensure Transect is character
  dives <- dives %>%
    mutate(Transect = as.character(Transect))
  # Grab date and transect columns
  dt <- dives %>%
    select(Date, Transect)
  # Error if NAs in date or transect
  if (any(is.na(dt))) {
    stop("Missing dates and/or transects", call. = FALSE)
  } # End if error
  # Grab times
  dive_times <- dives %>%
    select(-Date, -Transect)
  # Check for all missing
  missing_times <- dive_times %>%
    apply(MARGIN = 2, FUN = function(x) all(is.na(x)))
  # Error if diver(s) have all NAs
  if (any(missing_times)) {
    stop("Diver(s) have no dive times: ",
      paste(names(dive_times)[missing_times], collapse = ", "),
      call. = FALSE
    )
  } # End if error
  # # Ensure that times are times
  # not_times <- dive_times %>%
  #   apply(MARGIN = 2, FUN = function(x) !is.difftime(x))
  # # Error if time is not time
  # if (any(not_times)) {
  #   stop("Dive time is not time: ",
  #        paste(names(dive_times)[not_times], collapse = ", "), call. = FALSE
  #   )
  # }
  # Return dive times
  return(dives)
} # End load_dives functions
