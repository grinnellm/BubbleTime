# Packages
require(tidyverse)
require(here)

# Example dive times (simplified)
dives_simple <- tribble(
  ~Date,        ~Transect, ~Diver, ~Start,  ~End,
  "2024-05-02", 1,         "Matt", "08:00", "08:45",
  "2024-05-02", 2,         "Matt", "11:30", "12:15",
  "2024-05-02", 3,         "Matt", "16:00", "18:00",
  "2024-05-03", 11,        "Matt", "09:00", "09:45",
  "2024-05-03", 12,        "Matt", "10:30", "11:15"
) %>%
  mutate(
    Date = as.Date(Date),
    Transect = as.character(Transect),
    Start = lubridate::hm(Start),
    End = lubridate::hm(End)
  )
save(dives_simple, file = here("data", "dives_simple.RData"))

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
