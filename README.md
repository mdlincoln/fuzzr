# fuzzr

[![Project Status: Concept - Minimal or no implementation has been done yet.](http://www.repostatus.org/badges/latest/concept.svg)](http://www.repostatus.org/#concept)

fuzzr implements some simple ["fuzz tests"](https://en.wikipedia.org/wiki/Fuzz_testing) for your R functions, passing in a wide array of inputs and returning a report (normally as a data.frame) on how your function reacts.

## Installation

``` r
devtools::install_github("mdlincoln/fuzzr")
```

## Usage

Evaluate a function argument by supplying it's quoted name along with the tests to run to `fuzz_function`, along with any other required static values:

``` r
fuzz_function(fun = lm, arg_name = "subset", data = iris, formula = Sepal.Lengh ~ Petal.Width + Petal.Length, tests = fuzz_all())
```

`fuzz_function` returns a data frame of results indicating whether a condition (message, warning, or error) was created by your function, along with the value returned by that function.

### Tests

Tests are set by passing functions that return named lists of input values.
These values will be passed as function arguments.
Several default suites are provided with this package, such as `fuzz_char`, however you may implement your own by passing a function that returns a similarly-formatted list.

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

---
[Matthew Lincoln](http://matthewlincoln.net)
