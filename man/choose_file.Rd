% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{choose_file}
\alias{choose_file}
\title{Manually choose a file.}
\usage{
choose_file(dive_dir = here())
}
\arguments{
\item{dive_dir}{Character. Path to folder with dive file. Default \code{here()}.}
}
\value{
Character vector: path and name of file with dive times.
}
\description{
Manually choose a file with dive times to load using \code{\link[=load_dives]{load_dives()}}.
}
\examples{
\dontrun{
dives_file <- choose_file()
}
}
\seealso{
\code{\link[=load_dives]{load_dives()}} and \code{\link[=dive_buddy]{dive_buddy()}}

Other helpers functions: 
\code{\link{dive_buddy}()}
}
\concept{helpers functions}
