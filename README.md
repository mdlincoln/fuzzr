
<!-- README.md is generated from README.Rmd. Please edit that file -->
fuzzr
=====

[![Project Status: Concept - Minimal or no implementation has been done yet.](http://www.repostatus.org/badges/latest/concept.svg)](http://www.repostatus.org/#concept)

fuzzr implements some simple ["fuzz tests"](https://en.wikipedia.org/wiki/Fuzz_testing) for your R functions, passing in a wide array of inputs and returning a report (normally as a data.frame) on how your function reacts.

Installation
------------

``` r
devtools::install_github("mdlincoln/fuzzr")
```

Usage
-----

Evaluate a function argument by supplying it's quoted name along with the tests to run to `fuzz_function`, along with any other required static values. `fuzz_function` returns a data frame of results indicating whether a condition (message, warning, or error) was created by your function, along with the value returned by that function.

``` r
library(fuzzr)
fuzz_function(fun = lm, arg_name = "subset", data = iris, formula = Sepal.Length ~ Petal.Width + Petal.Length, tests = fuzz_all())
#> Source: local data frame [16 x 3]
#> 
#>             fuzz_input  type          message
#>                  (chr) (chr)            (chr)
#> 1          char_single error 0 (non-NA) cases
#> 2        char_multiple error 0 (non-NA) cases
#> 3         char_with_na error 0 (non-NA) cases
#> 4           int_single    lm               NA
#> 5         int_multiple    lm               NA
#> 6          int_with_na    lm               NA
#> 7           dbl_single error 0 (non-NA) cases
#> 8         dbl_mutliple error 0 (non-NA) cases
#> 9          dbl_with_na error 0 (non-NA) cases
#> 10         fctr_single    lm               NA
#> 11       fctr_multiple    lm               NA
#> 12        fctr_with_na    lm               NA
#> 13 fctr_missing_levels    lm               NA
#> 14          log_single    lm               NA
#> 15        log_mutliple    lm               NA
#> 16         log_with_na    lm               NA
```

### Tests

Tests are set by passing functions that return named lists of input values. These values will be passed as function arguments. Several default suites are provided with this package, such as `fuzz_char`, however you may implement your own by passing a function that returns a similarly-formatted list.

``` r
fuzz_char()
#> $char_single
#> [1] "a"
#> 
#> $char_multiple
#> [1] "a" "b" "c"
#> 
#> $char_with_na
#> [1] "a" "b" NA
```

------------------------------------------------------------------------

[Matthew Lincoln](http://matthewlincoln.net)
