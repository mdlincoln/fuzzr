# Data types ----

#' Fuzz test inputs
#' @export
test_all <- function() {
  c(test_char(), test_int(), test_dbl(), test_fctr(), test_lgl(), test_date(),
    test_raw())
}

#' @describeIn test_all Character vectors
#' @export
test_char <- function() {
  list(
    char_empty = character(),
    char_single = c("a"),
    char_single_blank = "",
    char_multiple = c("a", "b", "c"),
    char_multiple_blank = c("a", "b", "c", ""),
    char_with_na = c("a", "b", NA)
  )
}

#' @describeIn test_all Integer vectors
#' @export
test_int <- function() {
  list(
    int_empty = integer(),
    int_single = 1L,
    int_multiple = 1:3,
    int_with_na = c(1:2, NA)
  )
}

#' @describeIn test_all Double vectors
#' @export
test_dbl <- function() {
  list(
    dbl_empty = double(),
    dbl_single = stats::runif(1),
    dbl_mutliple = stats::runif(3),
    dbl_with_na = c(stats::runif(2), NA)
  )
}

#' @describeIn test_all Logical vectors
#' @export
test_lgl <- function() {
  list(
    lgl_empty = logical(),
    lgl_single = TRUE,
    lgl_mutliple = c(TRUE, FALSE, FALSE),
    lgl_with_na = c(TRUE, NA, FALSE)
  )
}

#' @describeIn test_all Factor vectors
#' @export
test_fctr <- function() {
  list(
    fctr_empty = factor(),
    fctr_single = as.factor("a"),
    fctr_multiple = as.factor(c("a", "b", "c")),
    fctr_with_na = as.factor(c("a", "b", NA)),
    fctr_missing_levels = factor(c("a", "b", "c"), levels = letters[1:4])
  )
}

#' @describeIn test_all Date vectors
#' @export
test_date <- function() {
  list(
    date_single = as.Date("2001-01-01"),
    date_multiple = as.Date(c("2001-01-01", "1950-05-05")),
    date_with_na = as.Date(c("2001-01-01", NA, "1950-05-05"))
  )
}

#' @describeIn test_all Raw vectors
#' @export
test_raw <- function() {
  list(
    raw_empty = raw(),
    raw_char = charToRaw("b")
  )
}

