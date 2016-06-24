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

test_that("Built-in tests work properly", {
  expect_equivalent(as.data.frame(fuzz_function(agrep, "pattern", x = letters, tests = test_char()))$pattern, names(test_char()))
})

test_that("test_all contains every individual test_ function", {
  pkgnames <- as.character(lsf.str("package:fuzzr"))
  testnames <- setdiff(pkgnames[grep("test_", pkgnames)], "test_all")
  alltestnames <- purrr::simplify(purrr::map(testnames, function(x) names(get(x)())))
  expect_true(all(alltestnames %in% names(test_all())))
})
