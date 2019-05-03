
context("Tests for binomial functions")

test_that("bin_choose works as expect with normal and abnormal inputs", {
  expect_equal(bin_choose(n = 5, k = 2), 10)
  expect_equal(bin_choose(n = 5, k = 0), 1)
  expect_equal(bin_choose(n = 5, k = 1:3), c(5, 10, 10))
  expect_error(bin_choose(n = 5, k = 6), "k cannot be greater than n")
})

test_that("bin_probability works as expect with normal and abnormal inputs", {
  expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
  expect_equal(bin_probability(success = 0:2, trials = 5, prob = 0.5), c(0.03125, 0.15625, 0.31250))
  expect_equal(bin_probability(success = 55, trials = 100, prob = 0.45), 0.01075277)
})

test_that("bin_distribution works as expect with normal and abnormal inputs", {
  actual_bindis <- bin_distribution(trials = 5, prob = 0.5)

  expect_equal(actual_bindis$probability[1], 0.03125)
  expect_equal(actual_bindis$probability[2], 0.15625)
  expect_equal(actual_bindis$probability[3], 0.31250)
  expect_equal(actual_bindis$probability[4], 0.31250)
  expect_equal(actual_bindis$probability[5], 0.15625)
  expect_equal(actual_bindis$probability[6], 0.03125)
  expect_is(actual_bindis, "bindis")
  expect_is(actual_bindis, "data.frame")
})

test_that("bin_cumulative works as expect with normal and abnormal inputs", {
  actual_bincum <- bin_cumulative(trials = 5, prob = 0.5)

  expect_equal(actual_bincum$probability[1], 0.03125)
  expect_equal(actual_bincum$probability[2], 0.15625)
  expect_equal(actual_bincum$probability[3], 0.31250)
  expect_equal(actual_bincum$probability[4], 0.31250)
  expect_equal(actual_bincum$probability[5], 0.15625)
  expect_equal(actual_bincum$probability[6], 0.03125)

  expect_equal(actual_bincum$cumulative[1], 0.03125)
  expect_equal(actual_bincum$cumulative[2], 0.18750)
  expect_equal(actual_bincum$cumulative[3], 0.50000)
  expect_equal(actual_bincum$cumulative[4], 0.81250)
  expect_equal(actual_bincum$cumulative[5], 0.96875)
  expect_equal(actual_bincum$cumulative[6], 1.00000)

  expect_is(actual_bincum, "bincum")
  expect_is(actual_bincum, "data.frame")
})
