# Exported functions ----

#' Fuzz-test a function
#'
#' @param fun A function
#' @param arg_name Quoted name of the argument to fuzz test
#' @param ... Static values to pass to fun
#' @param tests Which fuzz tests to run. Accepts a named list of inputs, defaulting to \code{\link{fuzz_all}}.
#'
#' @return A data frame of fuzz test results.
#'
#' @export
fuzz_function <- function(fun, arg_name, ..., tests = fuzz_all()) {
  .dots = list(...)

  assertthat::assert_that(is.function(fun))
  assertthat::assert_that(assertthat::is.string(arg_name))
  assertthat::assert_that(is.list(tests))
  assertthat::assert_that(assertthat::has_args(fun, arg_name))
  assertthat::assert_that(assertthat::has_args(fun, names(.dots)))

  fuzz_results <- fuzz_fun_arg(fun = fun, arg = arg_name, .dots = .dots, tests = tests)

  compose_results(fuzz_results)
}

# Internal functions ----


# Map a series of tests along a function argument, returning a list of results
# (and/or conditions) named after the fuzz test.
fuzz_fun_arg <- function(fun, arg, .dots, tests = fuzz_all()) {
  purrr::map(tests, function(x) {
    fun_arg <- stats::setNames(list(x), arg)
    try_fuzz(do.call(fun, args = c(fun_arg, .dots)))
  })
}

# Custom tryCatch function to catch messages, warnings, and errors with messages
# along with original calls
try_fuzz <- function(expr) {
  tryCatch(testthat::evaluate_promise(expr),
           error = function(c) construct_error(c))
}

construct_error <- function(c) {
  list(
    result = NULL,
    output = NULL,
    warnings = NULL,
    messages = NULL,
    error = conditionMessage(c)
  )
}

