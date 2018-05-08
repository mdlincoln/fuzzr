# Exported functions ----

#' Fuzz-test a function
#'
#' Evaluate how a function responds to unexpected or non-standard inputs.
#'
#' \code{fuzz_function} provides a simple interface to fuzz test a single
#' argument of a function by passing the function, name of the argument, static
#' values of other required arguments, and a named list of test values.
#'
#' \code{p_fuzz_function} takes a nested list of arguments paired with lists of
#' tests to run on each argument, and will evaluate every combination of
#' argument and provided test.
#'
#' @note The user will be asked to confirm before proceeding if the combinations
#'   of potential tests exceeds 500,000.
#'
#' @param fun A function.
#' @param arg_name Quoted name of the argument to fuzz test.
#' @param ... Other non-dynamic arguments to pass to \code{fun}. These will be
#'   repeated for every one of the \code{tests}.
#' @param tests Which fuzz tests to run. Accepts a named list of inputs,
#'   defaulting to \code{\link{test_all}}.
#' @param check_args Check if \code{arg_name} and any arguments passed as
#'   \code{...} are accepted by \code{fun}. Set to \code{FALSE} if you need to
#'   pass arguments to a function that accepts arguments via \code{...}.
#' @param progress Show a progress bar while running tests?
#'
#' @return A \code{fuzz_results} object.
#'
#' @seealso \code{\link{fuzz_results}} and
#'   \code{\link{as.data.frame.fuzz_results}} to access fuzz test results.
#'
#' @export
#' @examples
#' # Evaluate the 'formula' argument of lm, passing additional required variables
#' fr <- fuzz_function(lm, "formula", data = iris)
#'
#' # When evaluating a function that takes ..., set check_args to FALSE
#' fr <- fuzz_function(paste, "x", check_args = FALSE)
fuzz_function <- function(fun, arg_name, ..., tests = test_all(), check_args = TRUE, progress = interactive()) {

  fuzz_asserts(fun, check_args, progress)
  attr(fun, "fun_name") <- deparse(substitute(fun))
  assertthat::assert_that(is_named_l(tests))

  # Collect the unevaluated names of variables passed to the original call,
  # keeping only those passed in as ... These will be used in the named list
  # passed to p_fuzz_function
  dots_call_names <- purrr::map_chr(as.list(match.call()), deparse)
  .dots = list(...)
  dots_call_names <- dots_call_names[names(.dots)]

  # Check that arg_name is a string, and the tests passed is a named list
  assertthat::assert_that(assertthat::is.string(arg_name), is_named_l(tests))

  # Check that arguments passed to fun actually exist in fun
  if (check_args)
    assertthat::assert_that(
      assertthat::has_args(fun, arg_name),
      assertthat::has_args(fun, names(.dots)))

  # Construct a list of arguments for p_fuzz_function, with tests assigned to
  # arg_name, and the values passed via ... saved as lists named after their
  # deparsed variable names.
  test_args <- c(
    purrr::set_names(list(tests), arg_name),
    purrr::map2(.dots, dots_call_names, function(x, y) purrr::set_names(list(x), y)))

  p_fuzz_function(fun, .l = test_args, check_args = check_args, progress = progress)
}

#' @rdname fuzz_function
#' @param .l A named list of tests.
#' @export
#' @examples
#'
#' # Pass tests to multiple arguments via a named list
#' test_args <- list(
#'    data = test_df(),
#'    subset = test_all(),
#'    # Specify custom tests with a new named list
#'    formula = list(all_vars = Sepal.Length ~ ., one_var = mpg ~ .))
#' fr <- p_fuzz_function(lm, test_args)
p_fuzz_function <- function(fun, .l, check_args = TRUE, progress = interactive()) {

  fuzz_asserts(fun, check_args, progress)
  if (is.null(attr(fun, "fun_name"))) {
    fun_name <- deparse(substitute(fun))
  } else {
    fun_name <- attr(fun, "fun_name")
  }

  if (check_args)
    assertthat::assert_that(assertthat::has_args(fun, names(.l)))

  # Ensure .l is a named list of named lists
  is_named_ll(.l)

  # Replace any NULL test values with .null alias.
  .l <- purrr::map(.l, function(li) {
    purrr::map(li, function(lli) {
      if (is.null(lli)) {
        .null
      } else {
        lli
      }
    })
  })

  # Warn if combination of tests is potentially massive
  num_tests <- purrr::reduce(purrr::map_int(.l, length), `*`)
  if (num_tests >= 500000) {
    m <- utils::menu(choices = c("Yes", "No"), title = paste("The supplied tests have", num_tests, "combinations, which may be prohibitively large to calculate. Attempt to proceed?"))
    if (m != 1)
      return(NULL)
  }

  # Generate the list of tests to be done
  test_list <- named_cross_n(.l)

  # After crossing, restore NULL test values
  test_list <- purrr::modify_depth(test_list, 3, function(x) {
      if (inherits(x, what = "fuzz-null")) {
        NULL
      } else {
        x
      }
    })

  # Create a progress bar, if called for
  if (progress) {
    pb <- progress::progress_bar$new(
      format = " running tests [:bar] :percent eta: :eta",
      total = length(test_list), clear = FALSE, width = 60)
    pb$tick(0)
  }

  # For each test combination...
  fr <- purrr::map(
    test_list, function(x) {
      if (exists("pb")) pb$tick()

      # Extract values for testing
      arglist <- purrr::map(x, getElement, name = "test_value")

      # Extract names of tests
      testnames <- purrr::map(x, getElement, name = "test_name")

      # Create a result list with both the results of try_fuzz, as well as a
      # named list pairing argument names with the test names supplied to them
      # for this particular round
      res <- list(test_result = try_fuzz(fun = fun, fun_name = fun_name,
                                         all_args = arglist))
      res[["test_name"]] <- testnames
      res
    })

  structure(fr, class = "fuzz_results")
}

# Internal functions ----

# Pass NULL as a test value
#
# Because it is difficult to work with NULLs in lists as required by most of
# the fuzzr package, this function works as an alias to pass NULL values to
# function arguments for testing.
.null <- structure(list(), class = "fuzz-null")

# This set of assertions need to be checked for both functions
fuzz_asserts <- function(fun, check_args, progress) {
  assertthat::assert_that(
    is.function(fun), assertthat::is.flag(check_args),
    assertthat::is.flag(progress))
}

# Is a list named, and is each of its elements also a named list?
is_named_ll <- function(l) {
  assertthat::assert_that(is.list(l), is_named(l))
  purrr::walk(l, function(x) assertthat::assert_that(is.list(x), is_named(x)))
}

# Is every element of a list named?
is_named_l <- function(l) {
  is.list(l) & is_named(l)
}

assertthat::on_failure(is_named_l) <- function(call, env) {
  "Not a named list."
}

# Check that object has no blank names
is_named <- function(x) {
  nm <- names(x)
  !is.null(nm) & all("" != nm)
}

assertthat::on_failure(is_named) <- function(call, env) {
  "Not a completely-named object."
}

# Cross a list of named lists
named_cross_n <- function(ll) {

  # Cross the values of the list...
  crossed_values <- purrr::cross(ll)
  # ... and then cross the names
  crossed_names <- purrr::cross(purrr::map(ll, names))

  # Then map through both values and names in order to
  purrr::map2(crossed_values, crossed_names, function(x, y) {
    purrr::map2(x, y, function(m, n) {
      list(
        test_name = n,
        test_value = m
      )
    })
  })
}

# Custom tryCatch/withCallingHandlers function to catch messages, warnings, and
# errors along with any values returned by the expression. Returns a list of
# value, messages, warnings, and errors.
try_fuzz <- function(fun, fun_name, all_args) {

  call <- list(fun = fun_name, args = all_args)
  messages <- NULL
  output <- NULL
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

  output <- utils::capture.output({
    value <- withCallingHandlers(
      tryCatch(do.call(fun, args = all_args), error = error_handler),
      message = message_handler,
      warning = warning_handler
    )}, type = "output")

  if (length(output) == 0) {
    output <- NULL
  }

  list(
    call = call,
    value = value,
    output = output,
    messages = messages,
    warnings = warnings,
    errors = errors
  )
}
