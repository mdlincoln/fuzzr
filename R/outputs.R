# Exported functions ----

#' Summarize fuzz test results as a data frame
#'
#' @param fuzz_results object returned by \code{\link{fuzz_function}}.
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
summary.fuzz_results <- function(fuzz_results, class_format = c("concat", "nest")) {
  class_format <- match.arg(class_format)

  summary_handler <- switch(
    class_format,
    "concat" = concat_summary,
    "nest" = nest_summary)

  fdf <- attr(fuzz_results, "summary")
  summary_handler(fdf)
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

# Internal functions ----

# Concatenates multiple value classes into one character scalar
concat_summary <- function(fdf) {
  unique_tests <- unique(fdf$fuzz_input)
  g_dots <- list(~fuzz_input, ~message)
  s_dots <- list(~as.character(paste0(class, collapse = ", ")))
  summarized <- dplyr::ungroup(dplyr::summarize_(dplyr::group_by_(fdf, .dots = g_dots), .dots = stats::setNames(s_dots, "class")))
  test_order <- summarized[match(unique_tests, summarized$fuzz_input), ]
}

# Nests multiple classes as a list column in a data frame
nest_summary <- function(fdf) {
  tidyr::nest_(fdf, key_col = "class", nest_cols = "class")
}

# Compose and attach a summary dataframe of results
compose_results <- function(fuzz_results) {
  attr(fuzz_results, "summary") <- fuzz_as_data_frame(fuzz_results)
  structure(fuzz_results, class = "fuzz_results")
}

# Format fuzz testing results as a data frame
fuzz_as_data_frame <- function(fuzz_results, class_format) {
  purrr::map_df(fuzz_results, parse_fuzz_result, .id = "fuzz_input")
}

# Test if object is of the class fuzz-condition
is.condition <- function(x) inherits(x, c("fuzz-message", "fuzz-warning", "fuzz-error"))

parse_fuzz_result <- function(fuzz_result) {
  if(is.condition(fuzz_result)) {
    data.frame(
      class = pretty_class(class(fuzz_result)),
      message = fuzz_result$message,
    stringsAsFactors = FALSE)
  } else {
    data.frame(
      class = class(fuzz_result),
      message = as.character(NA),
    stringsAsFactors = FALSE)
  }
}

pretty_class <- function(m) {
  switch(m,
         "fuzz-message" = "message",
         "fuzz-warning" = "warning",
         "fuzz-error" = "error")
}
