# Exported functions ----

#' Summarize fuzz test results as a data frame
#'
#' @param fuzz_results object returned by \code{\link{fuzz_function}}.
#'
#' @return A data frame with the following columns: \describe{
#' \item{\code{fuzz_input}}{The name of the fuzz test performed.}
#' \item{\code{type}}{The type of response. If a condition was returned, one of
#'    \code{message}, \code{warning}, or \code{error}; if a value was returned,
#'    the \code{\link{class}} of that value.}
#' \item{\code{message}}{The condition message, if applicable.}
#' }
#'
#' @export
summary.fuzz_results <- function(fuzz_results) {
  attr(fuzz_results, "summary")
}

#' Access the object returned by the fuzz test
#'
#' @param fuzz_results fuzz_results object
#' @param index The test index (by position), or name, whose results to access. Same as the
#'   row number in the data frame returned by
#'   \code{\link{summary.fuzz_results}}.
#'
#' @export
value_returned <- function(fuzz_results, index) {
  assertthat::assert_that(assertthat::is.scalar(index))
  getElement(fuzz_results, index)
}

#' Is the object of class fuzz_results?
#'
#' @param x
#'
#' @return Logical value
#'
#' @export
is.fuzz_results <- function(x) {
  inherits(x, "fuzz_results")
}

# Internal functions ----


# Compose and attach a summary dataframe of results
compose_results <- function(fuzz_results) {
  attr(fuzz_results, "summary") <- fuzz_as_data_frame(fuzz_results)
  structure(fuzz_results, class = "fuzz_results")
}

# Format fuzz testing results as a data frame
fuzz_as_data_frame <- function(fuzz_results) {
  purrr::map_df(fuzz_results, parse_fuzz_result, .id = "fuzz_input")
}

# Test if object is of the class fuzz-condition
is.condition <- function(x) inherits(x, c("fuzz-message", "fuzz-warning", "fuzz-error"))

parse_fuzz_result <- function(fuzz_result) {
  if(is.condition(fuzz_result)) {
    data.frame(
      type = pretty_type(class(fuzz_result)),
      message = fuzz_result$message,
    stringsAsFactors = FALSE)
  } else {
    data.frame(
      type = paste0(class(fuzz_result), collapse = "; "),
      message = NA,
    stringsAsFactors = FALSE)
  }
}

pretty_type <- function(m) {
  switch(m,
         "fuzz-message" = "message",
         "fuzz-warning" = "warning",
         "fuzz-error" = "error")
}
