context("fuzz_function results can be parsed")

lm_fuzz <- fuzz_function(lm, "subset", data = iris, formula = Sepal.Length ~ Sepal.Width)

test_that("fuzz_function returns a data.frame object", {
  expect_s3_class(lm_fuzz, "fuzz_results")
  expect_s3_class(as.data.frame(lm_fuzz), "data.frame")
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

  fmf <- fuzz_function(mf, "x")
  fmf_c <- as.data.frame(fmf, class_format = "concat")
  fmf_n <- as.data.frame(fmf, class_format = "nest")

  expect_error(as.data.frame(fmf, class_format = "invalid"))
  expect_equivalent(fmf_c$fuzz_input, fmf_n$fuzz_input)
  expect_true(is.character(fmf_c$fuzz_input))
  expect_true(is.character(fmf_n$fuzz_input))
  expect_true(is.character(fmf_c$class))
  expect_true(is.list(fmf_n$class))
})
