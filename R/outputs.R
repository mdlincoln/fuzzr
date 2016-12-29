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
#'   \item{\code{warnings}}{Delimited warnnings, if applicable.}
#'   \item{\code{errors}}{Error returned, if applicable.}
#'   \item{\code{value_classes}}{Delimited classes of the object returned by the
#'    function, if applicable}
#'   \item{\code{results_index}}{Index of \code{x} from which the summary was
#'    produced.}
#'   }
#'
#' @export
as.data.frame.fuzz_results <- function(x, ..., delim = "; ") {
  df <- purrr::map_df(x, parse_fuzz_result_concat, delim = delim)
  df[["results_index"]] <- seq_along(x)
  df
}

#' Access individual fuzz test results
#'
#' @param fr \code{fuzz_results} object
#' @param index The test index (by position) to access. Same as the
#'   \code{results_index} in the data frame returned by
#'   \code{\link{as.data.frame.fuzz_results}}.
#' @name fuzz_results
NULL

#' @describeIn fuzz_results Access the object returned by the fuzz test
#' @export
fuzz_value <- function(fr, index) {
  assertthat::assert_that(inherits(fr, "fuzz_results"),
                          assertthat::is.count(index))
  fr[[index]][["test_result"]][["value"]]
}

#' @describeIn fuzz_results Access the call used for the fuzz test
#' @export
fuzz_call <- function(fr, index) {
  assertthat::assert_that(inherits(fr, "fuzz_results"),
                          assertthat::is.count(index))
  fr[[index]][["test_result"]][["call"]]
}

# Internal functions ----

compose_results <- function(fr) {
  fr <- structure(fr, class = "fuzz_results")
  return(fr)
}

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

  dfr[["result_classes"]] <- ifelse(
    is.null(fr[["test_result"]][["value"]]),
    NA_character_,
    paste(class(fr[["test_result"]][["value"]]), collapse = delim))

  dfr
}
