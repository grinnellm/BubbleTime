# Packages
require(tidyverse)
require(here)

# Example dive times
dives <- read_csv(file = here("data-raw", "dives.csv"), col_types = cols()) %>%
  mutate(Transect = as.character(Transect))
save(dives, file = here("data", "dives.RData"))
write_csv(x = dives, file = here("inst", "extdata", "dives.csv"))

# Parameters for dive time calculation rules
dive_pars <- list(
  min_time = 120,
  round_hr = 0.25,
  dive_period = 8
)
save(dive_pars, file = here("data", "dive_pars.RData"), version = 2)
