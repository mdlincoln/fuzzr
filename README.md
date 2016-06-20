# fuzzr

fuzzr implements some simpel ["fuzz tests"]() for your R functions, passing in a wide array of inputs and returning a report (normally as a data.frame) on how your function reacts.

## Installation

``` r
devtools::install_github("mdlincoln/fuzzr")
```

## Usage

Evaluate a function argument, or arguments, by passing argument names along with the tests to run to `fuzz_function`:

``` r
fuzz_function(fun = lm, arg_names = c("subset", "method"), tests = fuzz_all())
```

`fuzz_function` returns a dataframe of results indicating whether a condition (message, warning, or error) was created by your function, along with the value returned by that function.

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
