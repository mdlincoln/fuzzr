context("fuzz_function results can be parsed")

lm_fuzz <- fuzz_function(lm, "subset", data = iris, formula = Sepal.Length ~ Sepal.Width)

test_that("fuzz_function returns a data.frame object", {
  expect_s3_class(lm_fuzz, "fuzz_results")
  expect_s3_class(as.data.frame(lm_fuzz), "data.frame")
})

test_that("Values can be extracted from a fuzz_results object", {
  expect_null(value_returned(lm_fuzz, 1))
  expect_null(value_returned(lm_fuzz, "char_single"))
  expect_s3_class(value_returned(lm_fuzz, "int_single"), "lm")
})

test_that("Multi-class returns can be handled appropriately", {
  mf <- function(x) {
    r <- x
    class(r) <- c("a", "b", "c")
    print("output 1")
    warning("warn 1")
    message("mess 1")
    print("output 2")
    warning("warn 2")
    message("mess 2")
    if(x == 1) stop("Error at 1")
    return(r)
  }

  fmf <- fuzz_function(mf, "x")
  fdf <- as.data.frame(fmf)
  cdf <- as.data.frame(fmf, sep = "|")

  expect_true(is.character(fdf$fuzz_input))
  expect_true(is.character(fdf$output))
  expect_true(is.character(fdf$messages))
  expect_true(is.character(fdf$warnings))
  expect_true(is.character(fdf$errors))
  expect_true(is.character(fdf$result_classes))
  expect_match(fdf[fdf$fuzz_input == "int_single", ]$errors, "Error at 1")
  expect_match(fdf[fdf$fuzz_input == "char_multiple", ]$warnings, "condition has length > 1")
  expect_match(fdf$messages[1], "|")
})
