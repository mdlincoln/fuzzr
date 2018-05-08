
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fuzzr

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/fuzzr)](https://cran.r-project.org/package=fuzzr)
[![Travis-CI Build
Status](https://travis-ci.org/mdlincoln/fuzzr.svg?branch=master)](https://travis-ci.org/mdlincoln/fuzzr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/mdlincoln/fuzzr?branch=master&svg=true)](https://ci.appveyor.com/project/mdlincoln/fuzzr)

fuzzr implements some simple [“fuzz
tests”](https://en.wikipedia.org/wiki/Fuzz_testing) for your R
functions, passing in a wide array of inputs and returning a report on
how your function reacts.

## Installation

``` r
install.package("fuzzr")

# Or, for the development version:
devtools::install_github("mdlincoln/fuzzr")
```

## Usage

Tests are set by passing functions that return named lists of input
values. These values will be passed as function arguments. Several
default suites are provided with this package, such as `test_char`,
however you may implement your own by passing a function that returns a
similarly-formatted list.

``` r
library(fuzzr)
str(test_char())
#> List of 8
#>  $ char_empty         : chr(0) 
#>  $ char_single        : chr "a"
#>  $ char_single_blank  : chr ""
#>  $ char_multiple      : chr [1:3] "a" "b" "c"
#>  $ char_multiple_blank: chr [1:4] "a" "b" "c" ""
#>  $ char_with_na       : chr [1:3] "a" "b" NA
#>  $ char_single_na     : chr NA
#>  $ char_all_na        : chr [1:3] NA NA NA
```

Evaluate a function argument by supplying `fuzz_function` its quoted
name, the tests to run, along with any other required static values.
`fuzz_function` returns a `fuzz_results` object that stores conditions
raised by a function (message, warning, or error) along with any value
returned by that
function.

``` r
fuzz_results <- fuzz_function(fun = lm, arg_name = "subset", data = iris, 
                              formula = Sepal.Length ~ Petal.Width + Petal.Length, 
                              tests = test_all())
#> Warning: `cross_n()` is deprecated; please use `cross()` instead.

#> Warning: `cross_n()` is deprecated; please use `cross()` instead.
#> Warning: at_depth() is deprecated, please use `modify_depth()` instead
```

You can render these results as a data frame:

``` r
fuzz_df <- as.data.frame(fuzz_results)
knitr::kable(head(fuzz_df))
```

| subset                | data | formula                                   | output | messages | warnings | errors           | result\_classes | results\_index |
| :-------------------- | :--- | :---------------------------------------- | :----- | :------- | :------- | :--------------- | :-------------- | -------------: |
| char\_empty           | iris | Sepal.Length ~ Petal.Width + Petal.Length | NA     | NA       | NA       | 0 (non-NA) cases | NA              |              1 |
| char\_single          | iris | Sepal.Length ~ Petal.Width + Petal.Length | NA     | NA       | NA       | 0 (non-NA) cases | NA              |              2 |
| char\_single\_blank   | iris | Sepal.Length ~ Petal.Width + Petal.Length | NA     | NA       | NA       | 0 (non-NA) cases | NA              |              3 |
| char\_multiple        | iris | Sepal.Length ~ Petal.Width + Petal.Length | NA     | NA       | NA       | 0 (non-NA) cases | NA              |              4 |
| char\_multiple\_blank | iris | Sepal.Length ~ Petal.Width + Petal.Length | NA     | NA       | NA       | 0 (non-NA) cases | NA              |              5 |
| char\_with\_na        | iris | Sepal.Length ~ Petal.Width + Petal.Length | NA     | NA       | NA       | 0 (non-NA) cases | NA              |              6 |

You can also access the value returned by any one test by matching the
argument tested with its test name:

``` r
model <- fuzz_value(fuzz_results, subset = "int_multiple")
coefficients(model)
#>  (Intercept)  Petal.Width Petal.Length 
#>          0.8           NA          3.0
```

### Multiple-argument tests

Specify multiple-argument tests with `p_fuzz_function`, passing a named
list of arguments and tests to run on each. `p_fuzz_function` will test
every combination of argument and
variable.

``` r
fuzz_p <- p_fuzz_function(agrep, list(pattern = test_char(), x = test_char()))
#> Warning: `cross_n()` is deprecated; please use `cross()` instead.

#> Warning: `cross_n()` is deprecated; please use `cross()` instead.
#> Warning: at_depth() is deprecated, please use `modify_depth()` instead
length(fuzz_p)
#> [1] 64
knitr::kable(head(as.data.frame(fuzz_p)))
```

| pattern               | x           | output | messages | warnings                                                                   | errors                                         | result\_classes | results\_index |
| :-------------------- | :---------- | :----- | :------- | :------------------------------------------------------------------------- | :--------------------------------------------- | :-------------- | -------------: |
| char\_empty           | char\_empty | NA     | NA       | NA                                                                         | invalid ‘pattern’ argument                     | NA              |              1 |
| char\_single          | char\_empty | NA     | NA       | NA                                                                         | NA                                             | integer         |              2 |
| char\_single\_blank   | char\_empty | NA     | NA       | NA                                                                         | ‘pattern’ must be a non-empty character string | NA              |              3 |
| char\_multiple        | char\_empty | NA     | NA       | argument ‘pattern’ has length \> 1 and only the first element will be used | NA                                             | integer         |              4 |
| char\_multiple\_blank | char\_empty | NA     | NA       | argument ‘pattern’ has length \> 1 and only the first element will be used | NA                                             | integer         |              5 |
| char\_with\_na        | char\_empty | NA     | NA       | argument ‘pattern’ has length \> 1 and only the first element will be used | NA                                             | integer         |              6 |

-----

[Matthew Lincoln](http://matthewlincoln.net)
