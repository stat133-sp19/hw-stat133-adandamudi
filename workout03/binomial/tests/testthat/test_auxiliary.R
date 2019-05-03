
context("Tests for summary measure functions")

test_that("aux_mean works with normal input", {
  expect_equal(aux_mean(10, 0.3), 3)
  expect_equal(aux_mean(100, 0.5), 50)
  expect_equal(aux_mean(1, 1), 1)
})

test_that("aux_variance works with normal input", {
  expect_equal(aux_variance(10, 0.3), 2.1)
  expect_equal(aux_variance(100, 0.5), 25)
  expect_equal(aux_variance(1, 1), 0)
})

test_that("aux_mode works with normal input", {
  expect_equal(aux_mode(10, 0.3), 3)
  expect_equal(aux_mode(100, 0.5), 50)
  expect_equal(aux_mode(1, 1), c(1, 2))
})

test_that("aux_skewness works with normal input", {
  expect_equal(aux_skewness(10, 0.3), 0.27602622373694)
  expect_equal(aux_skewness(100, 0.5), 0)
  expect_equal(aux_skewness(1, 1), -Inf)
})

test_that("aux_kurtosis works with normal input", {
  expect_equal(aux_kurtosis(10, 0.3), -0.1238095238)
  expect_equal(aux_kurtosis(100, 0.5), -0.02)
  expect_equal(aux_kurtosis(1, 1), Inf)
})

