context("fuzz_function results can be parsed")

lm_fuzz <- fuzz_function(lm, "subset", data = iris, formula = Sepal.Length ~ Sepal.Width)

test_that("fuzz_function returns a data.frame object", {
  expect_s3_class(lm_fuzz, "fuzz_results")
  expect_s3_class(summary(lm_fuzz), "data.frame")
})

test_that("Values can be extracted from a fuzz_results object", {
  expect_s3_class(value_returned(lm_fuzz, 1), "fuzz-error")
  expect_s3_class(value_returned(lm_fuzz, "char_single"), "fuzz-error")
  expect_s3_class(value_returned(lm_fuzz, 6), "lm")
  expect_s3_class(value_returned(lm_fuzz, "int_single"), "lm")
})

test_that("Multi-class returns can be handled appropriately", {
  mf <- function(x) {
    r <- x
    class(r) <- c("a", "b", "c")
    return(r)
  }

  target_class <- "a; b; c"

  expect_equivalent(head(summary(fuzz_function(mf, "x"))$type, n = 1L), target_class)
})
