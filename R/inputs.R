# Data types ----

#' Fuzz test inputs
#' @export
fuzz_all <- function() {
  c(fuzz_char(), fuzz_int(), fuzz_dbl(), fuzz_fctr(), fuzz_log())
}

#' @describeIn fuzz_all Character vectors
#' @export
fuzz_char <- function() {
  list(
    char_single = c("a"),
    char_single_blank = "",
    char_multiple = c("a", "b", "c"),
    char_multiple_blank = c("a", "b", "c", ""),
    char_with_na = c("a", "b", NA)
  )
}

#' @describeIn fuzz_all Integer vectors
#' @export
fuzz_int <- function() {
  list(
    int_single = 1L,
    int_multiple = 1:3,
    int_with_na = c(1:2, NA)
  )
}

#' @describeIn fuzz_all Double vectors
#' @export
fuzz_dbl <- function() {
  list(
    dbl_single = stats::runif(1),
    dbl_mutliple = stats::runif(3),
    dbl_with_na = c(stats::runif(2), NA)
  )
}

#' @describeIn fuzz_all Logical vectors
#' @export
fuzz_log <- function() {
  list(
    log_single = TRUE,
    log_mutliple = c(TRUE, FALSE, FALSE),
    log_with_na = c(TRUE, NA, FALSE)
  )
}

#' @describeIn fuzz_all Factor vectors
#' @export
fuzz_fctr <- function() {
  list(
    fctr_single = as.factor("a"),
    fctr_multiple = as.factor(c("a", "b", "c")),
    fctr_with_na = as.factor(c("a", "b", NA)),
    fctr_missing_levels = factor(c("a", "b", "c"), levels = letters[1:4])
  )
}
