test_that("snapshot tests from example", {
  fr <- fuzz_function_call(quote(identity(x = 1)))
  expect_snapshot(as.data.frame(fr))
  
  fr2 <- fuzz_function_call(quote(identical(x = TRUE, y = FALSE)))
  expect_snapshot(as.data.frame(fr2))
  
  fr3 <- fuzz_function_call(quote(dirname(".")))
  expect_snapshot(as.data.frame(fr3))
  
  fr4 <- fuzz_function_call(quote(dirname(path = ".")))
  expect_snapshot(as.data.frame(fr4))

  fr5 <- fuzz_function_call(dirname(path = "."))
  expect_identical(fr5, fr4)
})
