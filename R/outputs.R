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
  .id <- "test_combo"
  argnames <- names(x[[1]]$call$args)
  df <- purrr::map_df(x, function(x) parse_fuzz_result_concat(x, delim = delim), .id = .id)
  df$results_index <- 1:length(x)
  tidyr::separate_(df, col = .id, into = argnames, sep = attr(x, "test_delim"))
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
  getElement(fr[[index]], "value")
}

#' @describeIn fuzz_results Access the call used for the fuzz test
#' @export
fuzz_call <- function(fr, index) {
  assertthat::assert_that(inherits(fr, "fuzz_results"),
                          assertthat::is.count(index))
  getElement(fr[[index]], "call")
}

# Internal functions ----

compose_results <- function(fr, test_delim) {
  fr <- structure(fr, class = "fuzz_results")
  attr(fr, "test_delim") <- test_delim
  return(fr)
}

parse_fuzz_result_concat <- function(fr, delim) {
  fr$result_classes <- ifelse(is.null(fr$value), as.character(NA),
                              paste(class(fr$value), collapse = delim))

  fr <- purrr::map_at(fr, function(x) {
    if(is.null(x)) {
      return(as.character(NA))
    } else {
      paste(x, collapse = delim)
    }
  }, .at = c("output", "messages", "warnings", "errors"))

  fr$call <- NULL
  fr$value <- NULL
  as.data.frame(fr, stringsAsFactors = FALSE)
}
