#' Determine dive period.
#'
#' Determine the dive period according to the collective agreement for
#' biologists (see [dive_pars]).
#'
#' @param dat Tibble. Columns for date, diver, as well as start and end times
#'   for each dive. See [calc_raw_mins()].
#' @param dive_period Numeric. Number of hours that constitutes a dive period.
#'   From [dive_pars].
#' @importFrom Rdpack reprompt
#' @importFrom dplyr group_by summarise ungroup full_join
#' @importFrom lubridate time_length
#' @return Numeric. Dive period indicating if the dive is in the first (1),
#'   second (2), or third (3) period of the day where periods start at the start
#'   of the first dive of the day.
#' @seealso [dive_pars]
#' @family calculations functions
#' @export
#' @examples
#' calc_period(dat = dives_simple)
calc_period <- function(dat, dive_period = dive_pars$dive_period) {
  # First dive of the day for each diver
  first_dive <- dat %>%
    mutate(DateTime = Date + Start) %>%
    group_by(Date, Diver) %>%
    summarise(First = min(DateTime)) %>%
    ungroup()
  # Append first dive to dives and convert end time of dive
  dat <- dat %>%
    full_join(y = first_dive, by = c("Date", "Diver")) %>%
    mutate(End = Date + End)
  # Duration since start of first dive
  time_hrs <- time_length(x = dat$End - dat$First, unit = "hour")
  # Round up to determine period
  res <- ceiling(time_hrs / dive_period)
  # Return results
  return(res)
} # End calc_period function

#' Calculate raw dive time.
#'
#' Calculate raw dive time in minutes for each dive based on start and end
#' times.
#'
#' @param dat Tibble. From [load_dives()].
#' @param ... Other arguments passed to [calc_period()].
#' @importFrom Rdpack reprompt
#' @importFrom dplyr arrange ungroup summarise group_by mutate filter n
#' @importFrom tidyr pivot_wider pivot_longer separate
#' @return Tibble with four columns: Date, Transect, Diver, and Time (in
#'   minutes).
#' @seealso [load_dives()]
#' @family calculations functions
#' @note Input is time; output is minutes.
#' @export
#' @examples
#' calc_raw_mins(dat = dives)
calc_raw_mins <- function(dat, ...) {
  # Format dive data
  raw_time <- dat %>%
    # Ensure transects are characters
    mutate(
      Date = as.Date(Date),
      Transect = as.character(Transect)
    ) %>%
    # Put times into one column
    pivot_longer(
      cols = -c(Date, Transect), names_to = "Diver", values_to = "Time"
    ) %>%
    # Split diver and start/end times
    separate(col = Diver, into = c("Diver", "StEnd")) %>%
    # Remove missing values
    filter(!is.na(Time)) %>%
    # Group by date, transect, diver, and start/end
    group_by(Date, Transect, Diver, StEnd) %>%
    # Get a unique number if there is more than one dive on a given transect
    mutate(Number = seq_len(n())) %>%
    # Ungroup
    ungroup() %>%
    # pivot_wider time into start and end times
    pivot_wider(names_from = StEnd, values_from = Time) %>%
    # Calculate dive duration
    mutate(
      Time = difftime(time1 = End, time2 = Start, units = "mins"),
      Time = as.numeric(Time)
    )
  # Stop if any dive times are negative or zero
  if (any(raw_time$Time <= 0)) stop("Non-positive dive time(s)", call. = FALSE)
  # Determine periods
  raw_time <- raw_time %>%
    mutate(Period = calc_period(raw_time, ...))
  # Calculate dive time based on start and end time
  raw_mins <- raw_time %>%
    # Group by date, transect, and diver
    group_by(Date, Transect, Diver, Period) %>%
    # Get the total for the transect
    summarise(Time = sum(Time)) %>%
    # Ungroup
    ungroup() %>%
    # Arrange by date and diver
    arrange(Date, Transect, Diver, Period, Time)
  # Return dive times in minutes
  return(raw_mins)
} # End calc_raw_mins function

#' Adjust daily dive time.
#'
#' Adjust daily dive time according to the collective agreement for biologists
#' (see [dive_pars]).
#'
#' @param dive_time Numeric. Dive time in minutes.
#' @param min_time Numeric. Minimum daily dive time in minutes. From
#'   [dive_pars].
#' @param round_hr Numeric. Round up to nearest portion of an hour. From
#'   [dive_pars].
#' @importFrom Rdpack reprompt
#' @importFrom plyr round_any
#' @return Numeric. Adjusted dive time in hours.
#' @seealso [dive_pars]
#' @family calculations functions
#' @export
#' @examples
#' adjust_time(dive_time = 12)
#' adjust_time(dive_time = 122)
adjust_time <- function(
    dive_time,
    min_time = dive_pars$min_time,
    round_hr = dive_pars$round_hr) {
  # Error if not finite
  if (any(is.infinite(dive_time))) {
    stop("Non-finite values in dive times", call. = FALSE)
  } # End if not finite
  # Error if negative
  if (any(dive_time < 0)) stop("Negative values in dive times", call. = FALSE)
  # Adjust time if greater than zero
  if (any(dive_time > 0)) {
    # If time is less than the minimum, make it the minimum (rule 1)
    adj_time <- ifelse(dive_time < min_time, min_time, dive_time)
    # Convert minutes to hours
    time_hrs <- adj_time / 60
    # Round up to nearest portion of an hour (rule 2)
    res <- round_any(x = time_hrs, accuracy = round_hr, f = ceiling)
  } else { # End if > 0, otherwise
    # No dive time for dive tenders
    res <- 0
  } # End if zero
  # Return the adjusted dive time in hours
  return(res)
} # End adjust_time function

#' Calculate adjusted daily dive time.
#'
#' Calculate adjusted daily dive time in hours using raw minutes for each dive
#' and rules in [adjust_time()].
#'
#' @param dat Tibble. From [calc_raw_mins()].
#' @param ... Other arguments passed to [adjust_time()].
#' @importFrom Rdpack reprompt
#' @importFrom dplyr ungroup summarise group_by mutate
#' @importFrom tidyr pivot_wider
#' @return Tibble with Date and one column for each diver indicating daily
#'   adjusted dive time in hours. This can be used to calculate dive pay.
#' @seealso [calc_raw_mins()] [adjust_time()]
#' @family calculations functions
#' @note Input is minutes for each dive; output is daily hours for each diver.
#' @export
#' @examples
#' raw_mins <- calc_raw_mins(dat = dives)
#' calc_daily_hrs(dat = raw_mins)
calc_daily_hrs <- function(dat, ...) {
  # Sum dive time by day and period (minutes)
  daily_mins <- dat %>%
    group_by(Date, Diver, Period) %>%
    summarise(Time = sum(Time)) %>%
    ungroup()
  # Get adjusted daily dive time (hours)
  adj_daily_hrs <- daily_mins %>%
    mutate(Time = adjust_time(Time, ...)) %>%
    group_by(Date, Diver) %>%
    summarise(Time = sum(Time)) %>%
    ungroup()
  # pivot_wider daily hours for easier readability
  res <- adj_daily_hrs %>%
    pivot_wider(names_from = Diver, values_from = Time, values_fill = 0)
  # Return daily dive time in hours
  return(res)
} # End calc_daily_hrs function
