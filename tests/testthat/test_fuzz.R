# test_all ----
context("All test_ functions are valid")

test_that("all test_ functions return a named list", {
  pkgnames <- as.character(lsf.str("package:fuzzr"))
  testnames <- setdiff(pkgnames[grep("test_", pkgnames)], "test_all")
  alltestnames <- purrr::simplify(purrr::map(testnames, function(x) names(get(x)())))
  purrr::walk(testnames, function(x) {
    expect_true(purrr::is_list(get(x)()))
    purrr::walk(x, function(y) is_named(y))
    })

  expect_true(all(alltestnames %in% names(test_all())))
})

# fuzz_function ----
context("fuzz_function rejects poor inputs")

test_that("Non-functions throw errors", {
  expect_error(fuzz_function(fun = "non-function"), regexp = "not a function")
  expect_error(fuzz_function(fun = letters[1:3]), regexp = "not a function")
  expect_error(fuzz_function(fun = 1), regexp = "not a function")
})

test_that("Unmatched arguments throw errors", {
  expect_error(fuzz_function(lm, "none"), regexp = "does not have arguments none")
  expect_error(fuzz_function(lm, "data", none = "not an arg"), regexp = "does not have arguments none")
})

test_that("Invalid tests throw errors", {
  expect_error(fuzz_function(lm, "data", tests = "nonlist"), regexp = "Not a named list")
  expect_error(fuzz_function(lm, "data", tests = list("nonlist")), regexp = "Not a named list")
  expect_error(fuzz_function(lm, "data", tests = list(foo = "baz", "nonlist")), regexp = "Not a named list")
})

# p_fuzz_function ----
context("p_fuzz_function rejects poor inputs")

test_that("Non-functions throw errors", {
  expect_error(p_fuzz_function(fun = "non-function", "x"), regexp = "not a function")
  expect_error(p_fuzz_function(fun = letters[1:3], "x"), regexp = "not a function")
  expect_error(p_fuzz_function(fun = 1, "x"), regexp = "not a function")
})

test_that("Invalid tests throw errors", {
  expect_error(p_fuzz_function(lm, .l = "data"), regexp = "not a list")
  expect_error(p_fuzz_function(lm, .l = list("data")), regexp = "Not a completely-named object")
  expect_error(p_fuzz_function(lm, .l = list(data = "y")), regexp = "not a list")
  expect_error(p_fuzz_function(lm, .l = list(data = list(y = iris), formula = Sepal.Width ~ .)), regexp = "not a list")
  expect_error(p_fuzz_function(lm, .l = list(data = list(y = iris), formula = list(Sepal.Width ~ .))), regexp = "Not a completely-named object")
  expect_s3_class(p_fuzz_function(lm, .l = list(data = list(y = iris))), "fuzz_results")
})

test_that("Over-large test suites raise a menu", {
  skip_if_not(!interactive())
  expect_error(p_fuzz_function(lm, .l = list(a = test_all(), b = test_all(), c = test_all(), d = test_all()), check_args = FALSE), regexp = "cannot be used non-interactively")
})

# fuzz_results ----
context("fuzz_function results can be parsed")

lm_fuzz <- fuzz_function(lm, "subset", data = iris, formula = Sepal.Length ~ Sepal.Width)
lm_df <- as.data.frame(lm_fuzz)

test_that("as.data.frame.fuzz_results", {
  expect_s3_class(lm_fuzz, "fuzz_results")
  expect_s3_class(lm_df, "data.frame")
})

agrep_fuzz <- fuzz_function(agrep, "pattern", x = letters, tests = test_char())
agrep_p_fuzz <- p_fuzz_function(agrep, list(pattern = test_char(), x = test_char()))

test_that("data frame has correct names", {
  expect_equivalent(as.data.frame(agrep_fuzz)$pattern, names(test_char()))
  expect_equivalent(names(as.data.frame(agrep_p_fuzz)), c("pattern", "x", "output", "messages", "warnings", "errors", "result_classes", "results_index"))
})

char_empty_index <- lm_df[lm_df$subset == "char_empty", ]$results_index
int_single_index <- lm_df[lm_df$subset == "int_single", ]$results_index

lm_1_val <- fuzz_value(lm_fuzz, char_empty_index)
lm_1_call <- fuzz_call(lm_fuzz, char_empty_index)
lm_single_val <- fuzz_value(lm_fuzz, int_single_index)
lm_single_call <- fuzz_call(lm_fuzz, int_single_index)

test_that("Values can be extracted from a fuzz_results object by index", {
  expect_null(lm_1_val)
  expect_equivalent(lm_1_call$fun, "lm")
  expect_equivalent(lm_1_call$args$subset, character(0))
  expect_s3_class(lm_single_val, "lm")
  expect_equivalent(lm_single_call$fun, "lm")
  expect_equivalent(lm_single_call$args$subset, 1L)
})

test_that("Values can be extracted from a fuzz_results object by regex", {
  lm_1_search_val <- fuzz_value(lm_fuzz, subset = "char_empty")
  lm_1_search_call <- fuzz_call(lm_fuzz, subset = "char_empty")
  lm_single_search_val <- fuzz_value(lm_fuzz, subset = "int_single")
  lm_single_search_call <- fuzz_call(lm_fuzz, subset = "int_single")
  expect_warning(lm_fail_search_val <- fuzz_value(lm_fuzz, subset = "aaa"))
  expect_warning(lm_fail_search_call <- fuzz_call(lm_fuzz, subset = "aaa"))
  agrep_multi_search_val <- fuzz_value(agrep_p_fuzz, x = "char_single", pattern = "char_single")
  agrep_multi_search_call <- fuzz_call(agrep_p_fuzz, x = "char_single", pattern = "char_single")
  expect_error(fuzz_call(agrep_p_fuzz, q = "char_single"))

  expect_null(lm_1_search_val)
  expect_s3_class(lm_single_search_val, "lm")
  expect_null(lm_fail_search_val)
  expect_equivalent(agrep_multi_search_val, 1L)
  expect_equivalent(agrep_multi_search_call$fun, "agrep")
})

test_that("Unmatchable fuzz_results argument search throws an error", {
  expect_error(fuzz_value(lm_fuzz, q = "char_empty"))
})

test_that("Supplied index overrides other named arguments", {
  lm_search_with_index <- fuzz_value(lm_fuzz, index = int_single_index, subset = "char_empty")
  expect_equivalent(lm_search_with_index, lm_single_val)
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
    if (x == 1) stop("Error at 1")
    return(r)
  }

  fmf <- fuzz_function(mf, "x")
  fdf <- as.data.frame(fmf)
  cdf <- as.data.frame(fmf, sep = "|")

  expect_true(is.character(fdf$x))
  expect_true(is.character(fdf$output))
  expect_true(is.character(fdf$messages))
  expect_true(is.character(fdf$warnings))
  expect_true(is.character(fdf$errors))
  expect_true(is.character(fdf$result_classes))
  expect_match(fdf[fdf$x == "int_single", ]$errors, "Error at 1")
  expect_match(fdf[fdf$x == "char_multiple", ]$warnings, "condition has length > 1")
  expect_match(fdf$messages[1], "|")
})
