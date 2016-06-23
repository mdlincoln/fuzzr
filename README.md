
<!-- README.md is generated from README.Rmd. Please edit that file -->
fuzzr
=====

[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip) [![Travis-CI Build Status](https://travis-ci.org/mdlincoln/fuzzr.svg?branch=master)](https://travis-ci.org/mdlincoln/fuzzr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdlincoln/fuzzr?branch=master&svg=true)](https://ci.appveyor.com/project/mdlincoln/fuzzr)

fuzzr implements some simple ["fuzz tests"](https://en.wikipedia.org/wiki/Fuzz_testing) for your R functions, passing in a wide array of inputs and returning a report on how your function reacts.

Installation
------------

``` r
devtools::install_github("mdlincoln/fuzzr")
```

Usage
-----

Evaluate a function argument by supplying it's quoted name along with the tests to run to `fuzz_function`, along with any other required static values. `fuzz_function` returns a "fuzz\_results" object that stores conditions raised by a function (message, warning, or error) along with any value returned by that function.

``` r
library(fuzzr)
fuzz_results <- fuzz_function(fun = lm, arg_name = "subset", data = iris, 
                              formula = Sepal.Length ~ Petal.Width + Petal.Length, 
                              tests = test_all())
```

You can render these results as a data frame:

``` r
as.data.frame(fuzz_results)
#> Source: local data frame [33 x 6]
#> 
#>             fuzz_input output messages warnings           errors
#>                  (chr)  (chr)    (chr)    (chr)            (chr)
#> 1           char_empty              NA       NA 0 (non-NA) cases
#> 2          char_single              NA       NA 0 (non-NA) cases
#> 3    char_single_blank              NA       NA 0 (non-NA) cases
#> 4        char_multiple              NA       NA 0 (non-NA) cases
#> 5  char_multiple_blank              NA       NA 0 (non-NA) cases
#> 6         char_with_na              NA       NA 0 (non-NA) cases
#> 7            int_empty              NA       NA 0 (non-NA) cases
#> 8           int_single              NA       NA               NA
#> 9         int_multiple              NA       NA               NA
#> 10         int_with_na              NA       NA               NA
#> ..                 ...    ...      ...      ...              ...
#> Variables not shown: result_classes (chr)
```

You can also access the value returned by any one test by calling the index or name of that test with `value_returned`:

``` r
model <- fuzz_value(fuzz_results, "int_multiple")
coefficients(model)
#>  (Intercept)  Petal.Width Petal.Length 
#>          0.8           NA          3.0
```

### Tests

Tests are set by passing functions that return named lists of input values. These values will be passed as function arguments. Several default suites are provided with this package, such as `test_char`, however you may implement your own by passing a function that returns a similarly-formatted list.

``` r
test_char()
#> $char_empty
#> character(0)
#> 
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
