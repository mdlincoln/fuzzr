
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
fuzz_df <- as.data.frame(fuzz_results)
dplyr::as_data_frame(fuzz_df)
#> Source: local data frame [33 x 8]
#> 
#>                 subset  data                                   formula
#>                  <chr> <chr>                                     <chr>
#> 1           char_empty  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 2          char_single  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 3    char_single_blank  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 4        char_multiple  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 5  char_multiple_blank  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 6         char_with_na  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 7            int_empty  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 8           int_single  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 9         int_multiple  iris Sepal.Length ~ Petal.Width + Petal.Length
#> 10         int_with_na  iris Sepal.Length ~ Petal.Width + Petal.Length
#> ..                 ...   ...                                       ...
#> Variables not shown: output <chr>, messages <chr>, warnings <chr>, errors
#>   <chr>, result_classes <chr>.
```

You can also access the value returned by any one test by calling the index that test with `value_returned`:

``` r
model <- fuzz_value(fuzz_results, which.max(fuzz_df$subset == "int_multiple"))
coefficients(model)
#>  (Intercept)  Petal.Width Petal.Length 
#>          0.8           NA          3.0
```

Multiple-argument tests
-----------------------

Specify multiple-argument tests with `p_fuzz_function`, passing a named list of arguments and tests to run on each. `p_fuzz_function` will test every combination of argument and variable.

``` r
fuzz_p <- p_fuzz_function(agrep, list(pattern = test_char(), x = test_char()))
dplyr::as_data_frame(as.data.frame(fuzz_p))
#> Source: local data frame [36 x 7]
#> 
#>                pattern           x output messages
#>                  <chr>       <chr>  <chr>    <chr>
#> 1           char_empty  char_empty     NA       NA
#> 2          char_single  char_empty     NA       NA
#> 3    char_single_blank  char_empty     NA       NA
#> 4        char_multiple  char_empty     NA       NA
#> 5  char_multiple_blank  char_empty     NA       NA
#> 6         char_with_na  char_empty     NA       NA
#> 7           char_empty char_single     NA       NA
#> 8          char_single char_single     NA       NA
#> 9    char_single_blank char_single     NA       NA
#> 10       char_multiple char_single     NA       NA
#> ..                 ...         ...    ...      ...
#> Variables not shown: warnings <chr>, errors <chr>, result_classes <chr>.
```

Tests
-----

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
