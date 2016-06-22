context("fuzz_function rejects poor inputs")

test_that("Non-functions throw errors", {
  expect_error(fuzz_function(fun = "non-function"))
  expect_error(fuzz_funciton(fun = letters[1:3]))
  expect_error(fuzz_funciton(fun = 1))
})

test_that("Unmatched arguments throw errors", {
  expect_error(fuzz_function(lm, "none"), regexp = "does not have arguments none")
  expect_error(fuzz_function(lm, "data", none = "not an arg"), regexp = "does not have arguments none")
})

test_that("Invalid tests throw errors", {
  expect_error(fuzz_function(lm, "data", tests = "nonlist"))
})

test_that("Both bare and quoted function names work", {
  expect_equivalent(fuzz_function(lm, "subset", data = iris, formula = Sepal.Length ~ Sepal.Width), fuzz_function("lm", "subset", data = iris, formula = Sepal.Length ~ Sepal.Width))
})
