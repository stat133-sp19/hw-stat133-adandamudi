
context("Tests for checker functions")

test_that("check_prob works with normal input", {
  probs <- c(0, 1, 0.5)

  expect_length(probs[1], 1)
  expect_length(probs[2], 1)
  expect_length(probs[3], 1)
  expect_true(check_prob(probs[1]))
  expect_true(check_prob(probs[2]))
  expect_true(check_prob(probs[3]))
})

test_that("check_prob results in error with an abnormal input", {
  invalid_probs <- c(-0.2, 1.2)

  expect_error(check_prob(invalid_probs[1]), "invalid prob value")
  expect_error(check_prob(invalid_probs[2]), "invalid prob value")
  expect_error(check_prob(invalid_probs), "input must be of length 1")
})

test_that("check_trials works with normal inputs", {
  trials <- c(0, 10)

  expect_length(trials[1], 1)
  expect_length(trials[2], 1)
  expect_true(check_trials(trials[1]))
  expect_true(check_trials(trials[2]))
})

test_that("check_trials results in error with an abnormal input", {
  invalid_trials <- c(-0.2, -1)

  expect_error(check_trials(invalid_trials[1]), "invalid trials value")
  expect_error(check_trials(invalid_trials[2]), "invalid trials value")
  expect_error(check_prob(invalid_trials), "input must be of length 1")
})

test_that("check_success works with normal inputs", {
  successes <- c(0, 1, 0, 10, c(0, 1, 5, 10))
  trials <- c(5, 5, 0, 10, 10)

  expect_length(trials[1], 1)
  expect_length(trials[2], 1)
  expect_length(trials[3], 1)
  expect_length(trials[4], 1)
  expect_length(trials[5], 1)
  expect_true(check_success(successes[1], trials[1]))
  expect_true(check_success(successes[2], trials[2]))
  expect_true(check_success(successes[3], trials[3]))
  expect_true(check_success(successes[4], trials[4]))
  expect_true(check_success(successes[5], trials[5]))
})

test_that("check_success results in an error with abnormal inputs", {
  expect_error(check_success(-1, 10), "invalid success value")
  expect_error(check_success(c(-1, 0, 1), 10), "invalid success value")
  expect_error(check_success(11, 10), "success cannot be greater than trials")
  expect_error(check_success(c(0, 1, 11), 10), "success cannot be greater than trials")
  expect_error(check_success(1, c(10, 11)), "input must be of length 1")
})

