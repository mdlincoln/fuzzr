context("fuzz_function returns a formatted data frame")

test_that("Returns a data.frame object", {
  expect_true(is.data.frame(fuzz_function(lm, "subset", data = iris, formula = Sepal.Length ~ Sepal.Width)))
})