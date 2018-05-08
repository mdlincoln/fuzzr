# Data types ----

#' Fuzz test inputs
#'
#' Each \code{test_all} returns a named list that concatenates all the available
#' tests specified below.
#'
#' @export
test_all <- function() {
  c(test_char(), test_int(), test_dbl(), test_fctr(), test_lgl(), test_date(),
    test_raw(), test_df(), test_null())
}

#' @describeIn test_all Character vectors \itemize{
#'  \item \code{char_empty}: \code{character(0)}
#'  \item \code{char_single}: \code{"a"}
#'  \item \code{char_single_blank}: \code{""}
#'  \item \code{char_multiple}: \code{c("a", "b", "c")}
#'  \item \code{char_multiple_blank}: \code{c("a", "b", "c", "")}
#'  \item \code{char_with_na}: \code{c("a", "b", NA)}
#'  \item \code{char_single_na}: \code{NA_character_}
#'  \item \code{char_all_na}: \code{c(NA_character_, NA_character_, NA_character_)}
#' }
#' @export
test_char <- function() {
  list(
    char_empty = character(),
    char_single = letters[1],
    char_single_blank = "",
    char_multiple = letters[1:3],
    char_multiple_blank = c(letters[1:3], ""),
    char_with_na = c(letters[1:2], NA),
    char_single_na = NA_character_,
    char_all_na = rep(NA_character_, 3)
  )
}

#' @describeIn test_all Integer vectors \itemize{
#'  \item \code{int_empty}: \code{integer(0)}
#'  \item \code{int_single}: \code{1L}
#'  \item \code{int_multiple}: \code{1:3}
#'  \item \code{int_with_na}: \code{c(1L, 2L, NA)}
#'  \item \code{int_single_na}: \code{NA_integer_}
#'  \item \code{int_all_na}: \code{c(NA_integer_, NA_integer_, NA_integer_)}
#' }
#' @export
test_int <- function() {
  list(
    int_empty = integer(),
    int_single = 1L,
    int_multiple = 1L:3L,
    int_with_na = c(1L:2L, NA),
    int_single_na = NA_integer_,
    int_all_na = rep(NA_integer_, 3)
  )
}

#' @describeIn test_all Double vectors \itemize{
#'  \item \code{dbl_empty}: \code{numeric(0)}
#'  \item \code{dbl_single}: \code{1.5}
#'  \item \code{dbl_mutliple}: \code{c(1.5, 2.5, 3.5)}
#'  \item \code{dbl_with_na}: \code{c(1.5, 2.5, NA)}
#'  \item \code{dbl_single_na}: \code{NA_real_}
#'  \item \code{dbl_all_na}: \code{c(NA_real_, NA_real_, NA_real_)}
#' }
#' @export
test_dbl <- function() {
  list(
    dbl_empty = double(),
    dbl_single = 1.5,
    dbl_mutliple = 1:3 + 0.5,
    dbl_with_na = c(1:2 + 0.5, NA),
    dbl_single_na = NA_real_,
    dbl_all_na = rep(NA_real_, 3)
  )
}

#' @describeIn test_all Logical vectors \itemize{
#'  \item \code{lgl_empty}: \code{logical(0)}
#'  \item \code{lgl_single}: \code{TRUE}
#'  \item \code{lgl_mutliple}: \code{c(TRUE, FALSE, FALSE)}
#'  \item \code{lgl_with_na}: \code{c(TRUE, NA, FALSE)}
#'  \item \code{lgl_single_na}: \code{NA}
#'  \item \code{lgl_all_na}: \code{c(NA, NA, NA)}
#' }
#' @export
test_lgl <- function() {
  list(
    lgl_empty = logical(),
    lgl_single = TRUE,
    lgl_mutliple = c(TRUE, FALSE, FALSE),
    lgl_with_na = c(TRUE, NA, FALSE),
    lgl_single_na = NA,
    lgl_all_na = rep(NA, 3)
  )
}

#' @describeIn test_all Factor vectors \itemize{
#'  \item \code{fctr_empty}: \code{structure(integer(0), .Label = character(0), class = "factor")}
#'  \item \code{fctr_single}: \code{structure(1L, .Label = "a", class = "factor")}
#'  \item \code{fctr_multiple}: \code{structure(1:3, .Label = c("a", "b", "c"), class = "factor")}
#'  \item \code{fctr_with_na}: \code{structure(c(1L, 2L, NA), .Label = c("a", "b"), class = "factor")}
#'  \item \code{fctr_missing_levels}: \code{structure(1:3, .Label = c("a", "b", "c", "d"), class = "factor")}
#'  \item \code{fctr_single_na}: \code{structure(NA_integer_, .Label = character(0), class = "factor")}
#'  \item \code{fctr_all_na}: \code{structure(c(NA_integer_, NA_integer_, NA_integer_), .Label = character(0), class = "factor")}
#' }
#' @export
test_fctr <- function() {
  list(
    fctr_empty = factor(),
    fctr_single = as.factor("a"),
    fctr_multiple = as.factor(c("a", "b", "c")),
    fctr_with_na = as.factor(c("a", "b", NA)),
    fctr_missing_levels = factor(c("a", "b", "c"), levels = letters[1:4]),
    fctr_single_na = factor(NA),
    fctr_all_na = factor(rep(NA, 3))
  )
}

#' @describeIn test_all Date vectors \itemize{
#'  \item \code{date_single}: \code{as.Date("2001-01-01")}
#'  \item \code{date_multiple}: \code{as.Date(c("2001-01-01", "1950-05-05"))}
#'  \item \code{date_with_na}: \code{as.Date(c("2001-01-01", NA, "1950-05-05"))}
#'  \item \code{date_single_na}: \code{as.Date(NA_integer_, origin = "1971-01-01")}
#'  \item \code{date_all_na}: \code{as.Date(rep(NA_integer_, 3), origin = "1971-01-01")}
#' }
#' @export
test_date <- function() {
  list(
    date_single = as.Date("2001-01-01"),
    date_multiple = as.Date(c("2001-01-01", "1950-05-05")),
    date_with_na = as.Date(c("2001-01-01", NA, "1950-05-05")),
    date_single_na = as.Date(NA_integer_, origin = "1971-01-01"),
    date_all_na = as.Date(rep(NA_integer_, 3), origin = "1971-01-01")
  )
}

#' @describeIn test_all Raw vectors \itemize{
#'  \item \code{raw_empty}: \code{raw(0)}
#'  \item \code{raw_char}: \code{as.raw(0x62)},
#'  \item \code{raw_na}: \code{charToRaw(NA_character_)}
#' }
#' @export
test_raw <- function() {
  list(
    raw_empty = raw(),
    raw_char = charToRaw("b"),
    raw_na = charToRaw(NA_character_)
  )
}

#' @describeIn test_all Data frames \itemize{
#'   \item \code{df_complete}: \code{datasets::iris}
#'   \item \code{df_empty}: \code{data.frame(NULL)}
#'   \item \code{df_one_row}: \code{datasets::iris[1, ]}
#'   \item \code{df_one_col}: \code{datasets::iris[ ,1]}
#'   \item \code{df_with_na}: \code{iris} with several NAs added to each column.
#' }
#' @export
test_df <- function() {
  iris_na <- datasets::iris
  iris_na[c(1, 10, 100), 1] <- NA
  iris_na[c(5, 15, 150), 3] <- NA
  iris_na[c(7, 27, 75), 5] <- NA

  list(
    df_complete = datasets::iris,
    df_empty = data.frame(NULL),
    df_one_row = datasets::iris[1, ],
    df_one_col = datasets::iris[ ,1],
    df_with_na = iris_na
  )
}

#' @describeIn test_all Null value \itemize{
#'  \item \code{null_value}: \code{NULL}
#' }
#' @export
test_null <- function() {
  list(
    null_value = NULL
  )
}

# Development utility function ----

# This is a non-exported, non-checked function (hence it's being commented out)
# to be used to quickly generate the \itemize{...} sections of documentation for
# vector-based tests. NOTE do not use the verbatim results if they are too
# lengthy.

# doc_test <- function(test) {
#   tnames <- names(test)
#   tval <- purrr::map_chr(test, deparse)
#   clipr::write_clip(
#     c("\\itemize{",
#     paste0("#'  \\item \\code{", tnames, "}: \\code{", tval, "}", collapse = "\n"),
#     "#' }"))
# }
