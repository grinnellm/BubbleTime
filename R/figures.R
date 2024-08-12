#' Plot daily dive time.
#'
#' Plot raw daily dive time in minutes for each diver based on start and end
#' times.
#'
#' @param dat Tibble. From [calc_raw_mins()].
#' @importFrom Rdpack reprompt
#' @importFrom ggplot2 ggplot aes geom_bar geom_hline coord_flip labs
#'   scale_y_continuous theme_bw theme facet_wrap scale_fill_viridis_d
#' @return Plot with bars for each diver and facets for each day.
#' @seealso [calc_raw_mins()] [dive_buddy()]
#' @family figures functions
#' @export
#' @examples
#' raw_mins <- calc_raw_mins(dat = dives)
#' plot_daily_mins(dat = raw_mins)
plot_daily_mins <- function(dat) {
  # Get plot size for multi-panel
  xy_size <- ceiling(sqrt(length(unique(dat$Date))))
  # Plot raw dive time
  plot <- ggplot(data = dat, mapping = aes(x = Diver, y = Time)) +
    geom_bar(stat = "identity", aes(fill = Diver)) +
    geom_hline(yintercept = 120, linetype = "dashed") +
    coord_flip() +
    scale_fill_viridis_d() +
    labs(y = "Time (mins)") +
    scale_y_continuous(breaks = seq(from = 0, to = 1000, by = 60)) +
    theme_bw() +
    theme(legend.position = "none") +
    facet_wrap(~Date, ncol = xy_size)
  # Return the plot
  return(plot)
} # End plot_daily_mins function

#' Plot cumulative dive time.
#'
#' Plot cumulative adjusted daily dive time in hours for each diver.
#'
#' @param dat Tibble. From [calc_daily_hrs()].
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @importFrom dplyr group_by mutate ungroup
#' @importFrom ggplot2 ggplot aes geom_point geom_path scale_x_date
#'   scale_colour_viridis_d labs expand_limits theme_bw theme element_rect
#'   position_dodge
#' @importFrom tidyr pivot_longer
#' @importFrom scales label_date
#' @return Time series of cumulative dive time.
#' @seealso [calc_daily_hrs()] [dive_buddy()]
#' @family figures functions
#' @export
#' @examples
#' raw_mins <- calc_raw_mins(dat = dives)
#' daily_hrs <- calc_daily_hrs(dat = raw_mins)
#' plot_cumulative_hrs(dat = daily_hrs)
plot_cumulative_hrs <- function(dat) {
  # Get cumulative adjusted daily dive time
  dat_cumulative <- dat %>%
    pivot_longer(cols = !Date, names_to = "Diver", values_to = "Time") %>%
    group_by(Diver) %>%
    # TODO: Fix this to avoid the error about undefined global variables
    # plot_cumulative_hrs: no visible binding for global variable 'Cumulative'
    # Undefined global functions or variables: Cumulative
    # https://github.com/STAT545-UBC/Discussion/issues/451
    # https://dplyr.tidyverse.org/articles/programming.html
    mutate(Cumulative = cumsum(Time)) %>%
    ungroup()
  # Set up horizontal dodge
  pos_jit <- position_dodge(0.1)
  # Plot cumulative dive time
  plot <- ggplot(
    data = dat_cumulative,
    mapping = aes(x = Date, y = Cumulative, colour = Diver)
  ) +
    geom_point(size = 3, position = pos_jit) +
    geom_path(linewidth = 1, position = pos_jit) +
    scale_x_date(labels = label_date("%Y-%m-%d")) +
    scale_colour_viridis_d() +
    labs(y = paste("Cumulative time (hours)", sep = "")) +
    expand_limits(y = 0) +
    theme_bw() +
    theme(legend.position = "top")
  # Return the plot
  return(plot)
} # End plot_cumulative_hrs function
