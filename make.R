# Additional checks to run before `R-CMD-CHECK`

# Load packages
require(BubbleTime)

# Build the raw data files
source(file = here::here("data-raw", "pars.R"))

# Build the read me file (may have to use RStudio "Knit" button)
rmarkdown::render(input = here::here("README.Rmd"))
file.remove(here::here("README.html"))

# Compile the supporting documents
devtools::build_manual(path = here::here("doc"))
devtools::build_vignettes(pkg = ".")

# Styler
styler::style_pkg()
styler::style_file(path = here::here("vignettes", "Introduction.Rmd"))
styler::style_file(path = here::here("man", "sticker", "sticker.R"))
styler::style_file(path = here::here("README.Rmd"))

# Lint
lintr::lint_package()
lintr::lint(filename = here::here("vignettes", "Introduction.Rmd"))
lintr::lint(filename = here::here("man", "sticker", "sticker.R"))
lintr::lint(filename = here::here("README.Rmd"))

# Good practice (takes a while; restart R and require `BubbleTime` first)
goodpractice::gp(path = ".")
