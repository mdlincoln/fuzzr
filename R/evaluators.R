# Exported functions ----

#' Fuzz-test a function
#'
#' @param fun A function, either bare or quoted.
#' @param arg_name Quoted name of the argument to fuzz test.
#' @param ... Other non-dynamic values to pass to \code{fun}.
#' @param tests Which fuzz tests to run. Accepts a named list of inputs, defaulting to \code{\link{fuzz_all}}.
#'
#' @return A \code{fuzz_results} object.
#'
#' @seealso \code{\link{as.data.frame.fuzz_results}} and \code{\link{value_returned}} to access fuzz test results.
#'
#' @export
fuzz_function <- function(fun, arg_name, ..., tests = test_all()) {
  .dots = list(...)

  # Retrieve the actual function if given a character name
  if(is.character(fun)) {
    assertthat::assert_that(assertthat::is.string(fun))
    fun <- get(fun)
  }

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

# Custom tryCatch/withCallingHandlers function to catch messages, warnings, and
# errors along with any values returned by the expression. Returns a list of
# value, messages, warnings, and errors.
try_fuzz <- function(expr) {
  messages <- NULL
  warnings <- NULL
  errors <- NULL

  message_handler <- function(c) {
    messages <<- c(messages, conditionMessage(c))
    invokeRestart("muffleMessage")
  }

  warning_handler <- function(c) {
    warnings <<- c(warnings, conditionMessage(c))
    invokeRestart("muffleWarning")
  }

  error_handler <- function(c) {
    errors <<- c(errors, conditionMessage(c))
    return(NULL)
  }

  # Little trick: that first tryCatch() will return values from the expression
  # to the "value" index in this list, but will pass errors to error_handler
  # (which returns NULL "value", incidentally.) In the event of messages or
  # warnings, handling is passed up to withCallingHandlers, which passes them
  # down again to message_handler or warning_handler, respectively. Once the
  # expression is done evaluating, messages, warnings, and errors are assigned
  # to the list, which is returned as the final result of try_fuzz
  list(
    value = withCallingHandlers(
      tryCatch(expr, error = error_handler),
      message = message_handler,
      warning = warning_handler
      ),
    messages = messages,
    warnings = warnings,
    errors = errors
  )
}
