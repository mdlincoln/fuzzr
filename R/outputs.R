# Exported functions ----

#' Summarize fuzz test results as a data frame
#'
#' @param x Object returned by \code{\link{fuzz_function}}.
#' @param ... Additional arguments to be passed to or from methods.
#' @param delim The delimiter to use in fields like \code{messages} or
#'    \code{warnings} where there may be multiple results.
#' @param .id Quoted column name for the name of the fuzz input used for each
#'    test.
#'
#' @return A data frame with the following columns: \describe{
#'   \item{\code{fuzz_input}}{The name of the fuzz test performed.}
#'   \item{\code{output}}{Delimited outputs to the command line from the process, if applicable.}
#'   \item{\code{messages}}{Delimited messages, if applicable.}
#'   \item{\code{warnings}}{Delimited warnnings, if applicable.}
#'   \item{\code{errors}}{Error returned, if applicable.}
#'   \item{\code{value_classes}}{Delimited classes of the object returned by the
#'    function, if applicable}
#'   }
#'
#' @export
as.data.frame.fuzz_results <- function(x, ..., delim = "; ", .id = "fuzz_input") {
  purrr::map_df(x, parse_fuzz_result_concat, delim, .id = .id)
}

#' Access the object returned by the fuzz test
#'
#' @param fr fuzz_results object
#' @param index The test index (by position), or name, whose results to access.
#'   Same as the row number in the data frame returned by
#'   \code{\link{as.data.frame.fuzz_results}}.
#'
#' @export
fuzz_value <- function(fr, index) {
  assertthat::assert_that(inherits(fr, "fuzz_results"))
  assertthat::assert_that(assertthat::is.scalar(index))
  getElement(getElement(fr, index), "value")
}

#' @describeIn fuzz_value Access the call used for the fuzz test
#' @export
fuzz_call <- function(fr, index) {
  assertthat::assert_that(inherits(fr, "fuzz_results"))
  assertthat::assert_that(assertthat::is.scalar(index))
  getElement(getElement(fr, index), "call")
}

# Internal functions ----

compose_results <- function(fr) {
  structure(fr, class = "fuzz_results")
}

parse_fuzz_result_concat <- function(fr, sep) {
  fr$result_classes <- ifelse(is.null(fr$value), as.character(NA),
                              paste(class(fr$value), collapse = sep))

  fr <- purrr::map_at(fr, function(x) {
    if(is.null(x)) {
      return(as.character(NA))
    } else {
      paste(x, collapse = sep)
    }
  }, .at = c("output", "messages", "warnings", "errors"))

  fr$call <- NULL
  fr$value <- NULL
  as.data.frame(fr, stringsAsFactors = FALSE)
}
