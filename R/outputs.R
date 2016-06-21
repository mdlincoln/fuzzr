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
as.data.frame.fuzz_results <- function(x, ..., class_format = c("concat", "nest")) {
  class_format <- match.arg(class_format)

  summary_handler <- switch(
    class_format,
    "concat" = concat_summary,
    "nest" = nest_summary)

  fdf <- attr(x, "data.frame")
  summary_handler(fdf)
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
  getElement(fr, index)
}

# Internal functions ----

# Concatenates multiple values into one character scalar
concat_summary <- function(fdf) {
  unique_tests <- unique(fdf$fuzz_input)
  g_dots <- list(~fuzz_input, ~message)
  s_dots <- list(~as.character(paste0(class, collapse = ", ")))
  summarized <- dplyr::ungroup(dplyr::summarize_(dplyr::group_by_(fdf, .dots = g_dots), .dots = stats::setNames(s_dots, "class")))

  # Return a data frame sorted in the same order in which it was input
  summarized[match(unique_tests, summarized$fuzz_input), ]
}

# Nests multiple classes as a list column in a data frame
nest_summary <- function(fdf) {
  tidyr::nest_(fdf, key_col = "class", nest_cols = "class")
}

# Compose and attach a summary dataframe of results
compose_results <- function(fr) {
  attr(fr, "summary_results") <- map_fuzz_results(fr)
  structure(fr, class = "fuzz_results")
}

# Format fuzz testing results as a data frame
map_fuzz_results <- function(fr) {
  purrr::map_df(fr, parse_fuzz_result, .id = "fuzz_test")
}

parse_fuzz_result <- function(fr) {
  fr$result_classes <- ifelse(is.null(fr$result), NA,
                              paste(class(fr$result), collapse = "; "))
  fr <- purrr::map_at(fr, function(x) {
    cl <- paste(x, collapse = "; ")
    ifelse(nzchar(cl), cl, as.character(NA))
  }, .at = c("output", "messages", "warnings", "error"))

  fr$result <- NULL
  as.data.frame(fr, stringsAsFactors = FALSE)
}
