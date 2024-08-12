
<!-- README.md is generated from README.Rmd; please edit README.Rmd. -->

# BubbleTime

<!-- <img src='man/sticker/sticker.png' align="right" height="250"/> -->

Calculate Dive Time.

<!-- badges: start -->

[![R-CMD-check](https://github.com/grinnellm/BubbleTime/workflows/R-CMD-check/badge.svg)](https://github.com/grinnellm/BubbleTime/actions)
[![Codecov](https://codecov.io/gh/grinnellm/BubbleTime/branch/master/graph/badge.svg)](https://codecov.io/gh/grinnellm/BubbleTime)
[![lint](https://github.com/grinnellm/BubbleTime/workflows/lint/badge.svg)](https://github.com/grinnellm/BubbleTime/actions)
[![Lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![Version](https://img.shields.io/badge/Version-0.0.0.9000-orange.svg?style=flat-square)](commits/master)
[![CRAN](https://www.r-pkg.org/badges/version/BubbleTime)](https://CRAN.R-project.org/package=BubbleTime)
<!-- badges: end -->

## Description

Calculate adjusted daily dive time based on dive start and end times
according to the collective agreement for biologists. Dive time may be
used to calculate dive pay; double-check dive times before submitting
them.

## Note

The BubbleTime package replaces the DiveTime script.

## Installation

Install the BubbleTime package from
[GitHub](https://github.com/grinnellm/BubbleTime) with:

``` r
# install.packages("remotes")
remotes::install_github(repo = "grinnellm/BubbleTime")
```

## Example

This example shows how to calculate adjusted daily dive time from a
table of dive start and end times. This table is included in the package
data; use it as a template to ensure you set up your input file the same
way. First, load the BubbleTime package in the usual way.

``` r
library(BubbleTime)
```

    ## This is BubbleTime version 0.0.0.9000.

Then, calculate dive times.

``` r
# Calculate dive times
dive_times <- dive_buddy(
  file_path = system.file("extdata", "dives.csv", package = "BubbleTime")
)
```

![](README_files/figure-gfm/dive_buddy-1.png)<!-- -->![](README_files/figure-gfm/dive_buddy-2.png)<!-- -->

``` r
# Print adjusted daily hours
dive_times$daily_hrs
```

    ## # A tibble: 3 × 5
    ##   Date        Matt  Mike Sarah Seaton
    ##   <date>     <dbl> <dbl> <dbl>  <dbl>
    ## 1 2015-04-30   2       2   2        2
    ## 2 2015-05-01   4       4   2        2
    ## 3 2015-05-02   2.5     2   2.5      2

## Additional information

Build the manual

``` r
devtools::build_manual(pkg = ".", path = here("doc"))
```

and open the file `./doc/BubbleTime_0.0.0.9000.pdf`. In addition, there
is a vignette with an example workflow; build the vignette

``` r
devtools::build_vignettes(pkg = ".")
```

and open the file `./doc/Introduction.html`.

## Contributing

If you would like to contribute to this project, please start by reading
the [guide to contributing](CONTRIBUTING.md). This applies to bug
reports, documentation, feature requests, mistakes, and other issues.
Note that this project is released with a [contributor code of
conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
