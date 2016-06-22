
<!-- README.md is generated from README.Rmd. Please edit that file -->
fuzzr
=====

[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip) [![Travis-CI Build Status](https://travis-ci.org/mdlincoln/fuzzr.svg?branch=master)](https://travis-ci.org/mdlincoln/fuzzr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdlincoln/fuzzr?branch=master&svg=true)](https://ci.appveyor.com/project/mdlincoln/fuzzr)

fuzzr implements some simple ["fuzz tests"](https://en.wikipedia.org/wiki/Fuzz_testing) for your R functions, passing in a wide array of inputs and returning a report (normally as a data.frame) on how your function reacts.

Installation
------------

``` r
devtools::install_github("mdlincoln/fuzzr")
```

Usage
-----

Evaluate a function argument by supplying it's quoted name along with the tests to run to `fuzz_function`, along with any other required static values. `fuzz_function` returns a "fuzz\_results" object that stores conditions raised by a function (message, warning, or error) along with any value returned by that function. You can preview this list with

``` r
library(fuzzr)
fuzz_results <- fuzz_function(fun = lm, arg_name = "subset", data = iris, 
                              formula = Sepal.Length ~ Petal.Width + Petal.Length, 
                              tests = test_all())

as.data.frame(fuzz_results)
#> Source: local data frame [18 x 5]
#> 
#>             fuzz_input messages warnings           errors result_classes
#>                  (chr)    (chr)    (chr)            (chr)          (chr)
#> 1          char_single       NA       NA 0 (non-NA) cases             NA
#> 2    char_single_blank       NA       NA 0 (non-NA) cases             NA
#> 3        char_multiple       NA       NA 0 (non-NA) cases             NA
#> 4  char_multiple_blank       NA       NA 0 (non-NA) cases             NA
#> 5         char_with_na       NA       NA 0 (non-NA) cases             NA
#> 6           int_single       NA       NA               NA             lm
#> 7         int_multiple       NA       NA               NA             lm
#> 8          int_with_na       NA       NA               NA             lm
#> 9           dbl_single       NA       NA 0 (non-NA) cases             NA
#> 10        dbl_mutliple       NA       NA 0 (non-NA) cases             NA
#> 11         dbl_with_na       NA       NA 0 (non-NA) cases             NA
#> 12         fctr_single       NA       NA               NA             lm
#> 13       fctr_multiple       NA       NA               NA             lm
#> 14        fctr_with_na       NA       NA               NA             lm
#> 15 fctr_missing_levels       NA       NA               NA             lm
#> 16          lgl_single       NA       NA               NA             lm
#> 17        lgl_mutliple       NA       NA               NA             lm
#> 18         lgl_with_na       NA       NA               NA             lm

model <- value_returned(fuzz_results, "int_multiple")
coefficients(model)
#>  (Intercept)  Petal.Width Petal.Length 
#>          0.8           NA          3.0
```

### Tests

Tests are set by passing functions that return named lists of input values. These values will be passed as function arguments. Several default suites are provided with this package, such as `test_char`, however you may implement your own by passing a function that returns a similarly-formatted list.

``` r
test_char()
#> $char_single
#> [1] "a"
#> 
#> $char_single_blank
#> [1] ""
#> 
#> $char_multiple
#> [1] "a" "b" "c"
#> 
#> $char_multiple_blank
#> [1] "a" "b" "c" "" 
#> 
#> $char_with_na
#> [1] "a" "b" NA
```

------------------------------------------------------------------------

[Matthew Lincoln](http://matthewlincoln.net)
