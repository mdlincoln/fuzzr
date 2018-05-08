# Exported functions ----

#' Summarize fuzz test results as a data frame
#'
#' @param x Object returned by \code{\link{fuzz_function}}.
#' @param ... Additional arguments to be passed to or from methods.
#' @param delim The delimiter to use for fields like \code{messages} or
#'    \code{warnings} in which there may be multiple results.
#'
#' @return A data frame with the following columns: \describe{
#'   \item{\code{fuzz_input}}{The name of the fuzz test performed.}
#'   \item{\code{output}}{Delimited outputs to the command line from the process, if applicable.}
#'   \item{\code{messages}}{Delimited messages, if applicable.}
#'   \item{\code{warnings}}{Delimited warnings, if applicable.}
#'   \item{\code{errors}}{Error returned, if applicable.}
#'   \item{\code{value_classes}}{Delimited classes of the object returned by the
#'    function, if applicable}
#'   \item{\code{results_index}}{Index of \code{x} from which the summary was
#'    produced.}
#'   }
#'
#' @export
as.data.frame.fuzz_results <- function(x, ..., delim = "; ") {
  ldf <- purrr::map(x, parse_fuzz_result_concat, delim = delim)
  df <- do.call("rbind", ldf)
  df[["results_index"]] <- seq_along(x)
  df
}

#' Access individual fuzz test results
#'
#' @param fr \code{fuzz_results} object
#' @param index The test index (by position) to access. Same as the
#'   \code{results_index} in the data frame returned by
#'   \code{\link{as.data.frame.fuzz_results}}.
#' @param ... Additional arguments must be named regex patterns that will be used to match against test names. The names of the patterns must match the function argument name(s) whose test names you wish to match.
#' @name fuzz_results
NULL

#' @describeIn fuzz_results Access the object returned by the fuzz test
#' @export
fuzz_value <- function(fr, index = NULL, ...) {
  res <- search_results(fr, index, ...)
  res[["test_result"]][["value"]]
}

#' @describeIn fuzz_results Access the call used for the fuzz test
#' @export
fuzz_call <- function(fr, index = NULL, ...) {
  res <- search_results(fr, index, ...)
  res[["test_result"]][["call"]]
}

# Internal functions ----

# For each result, create a one-row data frame of test names, outputs, messages,
# warnings, errors, and result classes.
parse_fuzz_result_concat <- function(fr, delim) {

  dfr <- as.data.frame(fr[["test_name"]], stringsAsFactors = FALSE)

  elem_collapse <- function(elem) {
    if (is.null(elem)) {
      return(NA_character_)
    } else {
      paste(elem, collapse = delim)
    }
  }

  dfr[["output"]] <- elem_collapse(fr[["test_result"]][["output"]])
  dfr[["messages"]] <- elem_collapse(fr[["test_result"]][["messages"]])
  dfr[["warnings"]] <- elem_collapse(fr[["test_result"]][["warnings"]])
  dfr[["errors"]] <- elem_collapse(fr[["test_result"]][["errors"]])

  # If no object was returned by the function under given test conditions,
  # record value as NA in the data frame
  dfr[["result_classes"]] <- ifelse(
    is.null(fr[["test_result"]][["value"]]),
    NA_character_,
    paste(class(fr[["test_result"]][["value"]]), collapse = delim))

  dfr
}

# Find elements of the search results list
search_results <- function(fr, index, ...) {
  assertthat::assert_that(inherits(fr, "fuzz_results"))

  # value supplied to index takes priority
  if (!is.null(index)) {
    assertthat::assert_that(assertthat::is.count(index) && index <= length(fr))
    res <- fr[[index]]
  } else {

    # if no index, then check based on test name
    .dots <- list(...)
    purrr::walk(.dots, function(p) assertthat::assert_that(assertthat::is.string(p)))

    assertthat::assert_that(all(names(.dots) %in% names(fr[[1]][["test_name"]])))

    res <- purrr::detect(fr, function(el) {
      all(purrr::map2_lgl(.dots, names(.dots), function(p, n) grepl(p, x = el[["test_name"]][[n]])))
    })
    if (length(res) == 0)
      warning("Zero matches found.")
  }
  res
}
