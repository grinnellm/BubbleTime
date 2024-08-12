#' Manually choose a file.
#'
#' Manually choose a file with dive times to load using [load_dives()].
#'
#' @param dive_dir Character. Path to folder with dive file. Default `here()`.
#' @importFrom Rdpack reprompt
#' @importFrom here here
#' @importFrom utils choose.files
#' @return Character vector: path and name of file with dive times.
#' @seealso [load_dives()] and [dive_buddy()]
#' @family helpers functions
#' @export
#' @examples
#' \dontrun{
#' dives_file <- choose_file()
#' }
choose_file <- function(dive_dir = here()) {
  # Choose input file interactively
  csv_path <- choose.files(
    caption = "Select CSV file with dive times",
    multi = FALSE,
    filters = matrix(c("CSV", "*.csv", nrow = 1))
  )
  # Get the file name
  csv_file <- basename(csv_path)
  # Split the file name
  fn_split <- strsplit(csv_file, split = ".", fixed = TRUE)[[1]]
  # Error if more than one part
  if (length(fn_split) > 2) {
    stop("Input file name can not have `.`", call. = FALSE)
  } # End if error
  # Deconstruct the input file name: extension
  fn_ext <- fn_split[2]
  # Stop if it's not CSV
  if (fn_ext != "csv") stop("Input file must be a CSV", call. = FALSE)
  # List to return
  res <- csv_path
  # Return the list
  return(res)
} # End choose_file function

#' Dive buddy has your back.
#'
#' Don't panic. Breathe. Dive buddy has your back. And an octopus:) This is a
#' wrapper around the functions required to calculate adjusted daily dive time
#' in hours.
#'
#' @param file_path Character. Path and name of dive file. Passed to
#'   [load_dives()]. Default [choose_file()].
#' @param save_plot Logical. Save plots of raw and cumulative adjusted dive time
#'   to file. Default FALSE.
#' @param save_csv Logical. Write raw and adjusted daily dive times to files.
#'   Default FALSE.
#' @importFrom Rdpack reprompt
#' @importFrom readr write_csv
#' @importFrom ggplot2 ggsave
#' @return List with one tibble from [calc_raw_mins()] and one tibble from
#'   [calc_daily_hrs()].
#' @seealso [load_dives()] [choose_file()] [calc_raw_mins()] [plot_daily_mins()]
#'   [calc_daily_hrs()] [plot_cumulative_hrs()]
#' @family helpers functions
#' @export
#' @examples
#' dive_buddy(
#'   file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
#' )
#' \dontrun{
#' dive_buddy()
#' }
dive_buddy <- function(
    file_path = choose_file(),
    save_plot = FALSE,
    save_csv = FALSE) {
  # Load dive times from file
  dives_raw <- load_dives(file_path = file_path)
  # Calculate raw dive time
  raw_mins <- calc_raw_mins(dat = dives_raw)
  # Plot daily dive time
  plot_daily <- plot_daily_mins(dat = raw_mins)
  # Show the plot
  print(plot_daily)
  # Calculate adjusted daily dive time in hours
  daily_hrs <- calc_daily_hrs(dat = raw_mins)
  # Plot cumulative dive time
  plot_cumulative <- plot_cumulative_hrs(dat = daily_hrs)
  # Show the plot
  print(plot_cumulative)
  # Save plots if requested
  if (save_plot) {
    # Save the plot
    ggsave(plot = plot_daily, filename = here("plot_daily.png"))
    # Save the plot
    ggsave(plot = plot_cumulative, filename = here("plot_cumulative.png"))
  } # End if saving plots
  # Save CSVs if requested
  if (save_csv) {
    # Save raw minutes
    write_csv(x = raw_mins, file = here("raw_mins.csv"))
    # Save adjusted daily hours
    write_csv(x = daily_hrs, file = here("daily_hrs.csv"))
  } # End if saving CSVs
  # List to return
  res <- list(raw_mins = raw_mins, daily_hrs = daily_hrs)
  # Return raw dive times and adjusted daily hours
  return(res)
} # End dive_buddy function
