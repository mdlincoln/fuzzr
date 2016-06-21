# Exported functions ----

#' Summarize fuzz test results as a data frame
#'
#' @param x Object returned by \code{\link{fuzz_function}}.
#' @param ... Additional arguments to be passed to or from methods.
#' @param class_format How to format function return classes. \code{"concat"} (the
#'   default) collapses multiple class names into one comma-delimited character
#'   scalar, which can be easier to read on the console. \code{"nest"} creates a
#'   nested data frame, saving object classes in a list column using
#'   \code{\link[tidyr]{nest}}.
#'
#' @return A data frame with the following columns: \describe{
#'   \item{\code{fuzz_input}}{The name of the fuzz test performed.}
#'   \item{\code{class}}{The class of response. If a condition was returned, one
#'   of \code{message}, \code{warning}, or \code{error}; if a value was
#'   returned, the \code{\link{class}} of that value.}
#'   \item{\code{message}}{The
#'   condition message, if applicable.}
#'   }
#'
#' @export
as.data.frame.fuzz_results <- function(x, ..., sep = "; ", .id = "fuzz_input") {
  purrr::map_df(x, parse_fuzz_result, sep, .id = .id)
}

#' Access the object returned by the fuzz test
#'
#' @param fr fuzz_results object
#' @param index The test index (by position), or name, whose results to access. Same as the
#'   row number in the data frame returned by
#'   \code{\link{as.data.frame.fuzz_results}}.
#'
#' @export
value_returned <- function(fr, index) {
  assertthat::assert_that(assertthat::is.scalar(index))
  getElement(getElement(fr, index), "value")
}

# Internal functions ----

compose_results <- function(fr) {
  structure(fr, class = "fuzz_results")
}

parse_fuzz_result <- function(fr, sep) {
  fr$result_classes <- ifelse(is.null(fr$value), NA,
                              paste(class(fr$value), collapse = sep))

  fr <- purrr::map_at(fr, function(x) {
    if(is.null(x)) {
      return(as.character(NA))
    } else {
      paste(x, collapse = sep)
    }
  }, .at = c("messages", "warnings", "errors"))

  fr$value <- NULL
  as.data.frame(fr, stringsAsFactors = FALSE)
}
