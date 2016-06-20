# Exported functions ----

#' Format fuzz testing results as a data frame
#'
#' @export
fuzz_as_data_frame <- function(fuzz_results) {
  purrr::map_df(fuzz_results, parse_fuzz_result, .id = "fuzz_input")
}

# Internal functions ----

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
      type = class(fuzz_result),
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
