#################################################################################
##############          PRIVATE AUXILIARY FUNCTIONS           ###################
#################################################################################

# Computes the mean of the binomial distribution with given probabilities
# for the specified number of total trials
aux_mean <- function(trials, prob) {
  return(trials * prob)
}

# Computes the variance of the binomial distribution with given probabilities
# for the specified number of total trials
aux_variance <- function(trials, prob) {
  return(trials * prob * (1-prob))
}

# Computes the mode of the binomial distribution with given probabilities
# for the specified number of total trials
aux_mode <- function(trials, prob) {
  val <- trials * prob + prob
  if (floor(val) == val) {
    return(c(val-1, val))
  } else {
    return(floor(val))
  }
}

# Computes the skewness of the binomial distribution with given probabilities
# for the specified number of total trials
aux_skewness <- function(trials, prob) {
  return((1-(2*prob))/(sqrt(trials * prob * (1-prob))))
}

# Computes the kurtosis of the binomial distribution with given probabilities
# for the specified number of total trials
aux_kurtosis <- function(trials, prob) {
  return((1-((6*prob) * (1-prob)))/(trials * prob * (1-prob)))
}
