% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{dive_buddy}
\alias{dive_buddy}
\title{Dive buddy has your back.}
\usage{
dive_buddy(file_path = choose_file(), save_plot = FALSE, save_csv = FALSE)
}
\arguments{
\item{file_path}{Character. Path and name of dive file. Passed to
\code{\link[=load_dives]{load_dives()}}. Default \code{\link[=choose_file]{choose_file()}}.}

\item{save_plot}{Logical. Save plots of raw and cumulative adjusted dive time
to file. Default FALSE.}

\item{save_csv}{Logical. Write raw and adjusted daily dive times to files.
Default FALSE.}
}
\value{
List with one tibble from \code{\link[=calc_raw_mins]{calc_raw_mins()}} and one tibble from
\code{\link[=calc_daily_hrs]{calc_daily_hrs()}}.
}
\description{
Don't panic. Breathe. Dive buddy has your back. And an octopus:) This is a
wrapper around the functions required to calculate adjusted daily dive time
in hours.
}
\examples{
dive_buddy(
  file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
)
\dontrun{
dive_buddy()
}
}
\seealso{
\code{\link[=load_dives]{load_dives()}} \code{\link[=choose_file]{choose_file()}} \code{\link[=calc_raw_mins]{calc_raw_mins()}} \code{\link[=plot_daily_mins]{plot_daily_mins()}}
\code{\link[=calc_daily_hrs]{calc_daily_hrs()}} \code{\link[=plot_cumulative_hrs]{plot_cumulative_hrs()}}

Other helpers functions: 
\code{\link{choose_file}()}
}
\concept{helpers functions}
