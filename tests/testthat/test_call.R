context("fuzz_function rejects poor inputs")

test_that("Non-functions throw errors", {
  expect_error(fuzz_function(fun = "non-function"))
})

test_that("Unmatched arguments throw errors", {
  expect_error(fuzz_function(lm, "none"), regexp = "does not have arguments none")
  expect_error(fuzz_function(lm, "data", none = "not an arg"), regexp = "does not have arguments none")
})

test_that("Invalid tests throw errors", {
  expect_error(fuzz_function(lm, "data", tests = "nonlist"))
})
