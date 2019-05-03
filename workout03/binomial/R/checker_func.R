#################################################################################
#################          PRIVATE CHECKER FUNCTIONS           ##################
#################################################################################

# Checks that the probability is within a valid range (i.e. between 0 and 1 inclusive)
check_prob <- function(prob) {
  check_length_is_one(prob)
  if (prob >= 0 & prob <= 1) {
    return(TRUE)
  } else {
    stop("invalid prob value")
  }
}

# Checks that the number of trials is valid (i.e non-negative)
check_trials <- function(trials) {
  check_length_is_one(trials)
  if (trials >= 0) {
    return(TRUE)
  } else {
    stop("invalid trials value")
  }
}

# Checks that the number of successes is between 0 and the number of trials
check_success <- function(success, trials) {
  check_length_is_one(trials)
  if (any(success < 0)) {
    stop("invalid success value")
  } else if (any(success > trials)) {
    stop("success cannot be greater than trials")
  } else {
    return(TRUE)
  }
}

#################################################################################
####################             HELPER FUNCTIONS           #####################
#################################################################################

# Checks that the length of a variable is 1
check_length_is_one <- function(x) {
  if (length(x) != 1) {
    stop("input must be of length 1")
  }
}
