#################################################################################
###############           MAIN FUNCTIONS AND METHODS           ##################
#################################################################################

library(ggplot2)


#' @title Binomial choose
#' @description Calculates the number of combinations in which k successes can occur in n trials
#' @param n Number of trials
#' @param k Number of successes
#' @return Number of possible ways you can n trials with k successes
#' @export
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(n = 5, k = 0)
bin_choose <- function(n, k) {
  if (any(k > n)) {
    stop("k cannot be greater than n")
  }
  return(factorial(n)/(factorial(k)*factorial(n-k)))
}


#' @title Binomial probability
#' @description Calculates the probability of k successes with the specified number of trials and success probability
#' @param success Number of successes of interest
#' @param trials Total number of trials used
#' @param prob Probability of success
#' @return Probability of k successes in n trials with sucess probability being p
#' @export
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
bin_probability <- function(success, trials, prob) {
  if (!check_trials(trials)) {
    stop("invalid trials value'")
  }
  if (!check_prob(prob)) {
    stop("invalid prob value")
  }
  if (!check_success(success, trials)) {
    stop("invalid success value")
  }
  return(bin_choose(trials, success) * (prob^success) * ((1-prob)^(trials-success)))
}


#' @title Binomial distribution
#' @description Calculates the probability dist of varying number of success with specified number of trials and success prob
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Two column data frame of classes c("bindis", "data.frame") specifying probability
#' @export
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)
#' bin_distribution(trials = 10, prob = 0.1)
bin_distribution <- function(trials, prob) {
  all_probs <- c()
  for (success in 0:trials) {
    all_probs[success + 1] <- bin_probability(success, trials, prob)
  }

  df <- data.frame(success = 0:trials, probability = all_probs)
  class(df) <- c("bindis", "data.frame")
  return(df)
}

#' @export
plot.bindis <- function(x,...) {
  plot <- ggplot(data = x, aes(x = x$success, y = x$probability)) +
            geom_bar(stat="identity") +
            xlab("Number of successes") +
            ylab("Probability") +
            ggtitle("Binomial Probability Distribution") +
            theme(plot.title = element_text(hjust = 0.5))
  return(plot)
}


#' @title Binomial cumulative
#' @description Calculates the cumulative probability for the binomial distribution
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Three column data frame with two classes c("bincum", "data.frame") specifying cumulative probabilities
#' @export
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)
#' bin_cumulative(trials = 10, prob = 0.1)
bin_cumulative <- function(trials, prob) {
  df <- bin_distribution(trials, prob)
  df$cumulative[1] <- df$probability[1]
  for (i in 1:trials) {
    df$cumulative[i+1] <- df$cumulative[i] + df$probability[i+1]
  }
  class(df) <- c("bincum", "data.frame")
  return(df)
}

#' @export
plot.bincum <- function(x,...) {
  plot <- ggplot(data = x, aes(x = x$success, y = x$cumulative)) +
            geom_line() +
            geom_point() +
            xlab("Number of successes") +
            ylab("Probability") +
            ggtitle("Binomial Cumulative Distribution") +
            theme(plot.title = element_text(hjust = 0.5))
  return(plot)
}


#' @title Binomial Variable
#' @description Creates a binomial variable with specified number of trials and success probability
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Binomial random variable object of class "binvar"
#' @export
#' @examples
#' bin_var <- bin_variable(trials = 5, prob = 0.5)
#' bin_var
bin_variable <- function(trials, prob) {
  if (!check_trials(trials)) {
    stop("invalid trials value")
  }
  if (!check_prob(prob)) {
    stop("invalid prob value")
  }

  lst <- list(trials = trials, prob = prob)
  class(lst) <- c("binvar", "list")
  return(lst)
}

#' @export
print.binvar <- function(x,...) {
  cat('"Binomial Variable"\n\n')
  cat('Parameters\n')
  cat(sprintf('- number of trials : %d', x$trials), "\n")
  cat(sprintf('- prob of success : %f', x$prob), "\n")
  invisible(x)
  # cat("\"Binomial Variable\"\n\n")
  # cat("Parameters\n")
  # cat("\t- number of trials : ", x$trials, "\n")
  # cat("\t- prob of success : ", x$prob, "\n")
  # sprintf("\"Binomial Variable\"\n\n")
  # sprintf("Parameters\n")
  # sprintf("- number of trials : %d\n", x$trials)
  # sprintf("- prob of success : %f\n", x$prob)
}

#' @export
summary.binvar <- function(object,...) {
  summary <- list(trials = object$trials,
                  prob = object$prob,
                  mean = aux_mean(object$trials, object$prob),
                  variance = aux_variance(object$trials, object$prob),
                  mode = aux_mode(object$trials, object$prob),
                  skewness = aux_skewness(object$trials, object$prob),
                  kurtosis = aux_kurtosis(object$trials, object$prob)
              )
  class(summary) <- c("summary.binvar", "list")
  return(summary)
}

#' @export
print.summary.binvar <- function(x,...) {
  cat('"Summary Binomial"\n\n')
  cat('Parameters\n')
  cat(sprintf('- number of trials : %d', x$trials), "\n")
  cat(sprintf('- prob of success : %f', x$prob), "\n\n")
  cat('Measures\n')
  cat(sprintf('- mean : %f', x$mean), "\n")
  cat(sprintf('- variance : %f', x$variance), "\n")
  cat(sprintf('- mode : %f', x$mode), "\n")
  cat(sprintf('- skewness : %f', x$skewness), "\n")
  cat(sprintf('- kurtosis : %f', x$kurtosis), "\n")
  invisible(x)
  
  # cat("\t- mean\t: ", x$mean, " \n")
  # cat("\t- variance\t: ", x$variance, " \n")
  # cat("\t- mode\t: ", x$mode, " \n")
  # cat("\t- skewness\t: ", x$skewness, " \n")
  # cat("\t- kurtosis\t: ", x$kurtosis, " \n")

  # sprintf("\"Summary Binomial\"\n\n")
  # sprintf("Parameters\n")
  # sprintf("- number of trials : %d\n", x$trials)
  # sprintf("- prob of success : %f\n\n", x$prob)
  # sprintf("Measures\n")
  # sprintf("- mean\t: %d\n", x$mean)
  # sprintf("- variance\t: %d\n", x$variance)
  # sprintf("- mode\t: %d\n", x$mode)
  # sprintf("- skewness\t: %d\n", x$skewness)
  # sprintf("- kurtosis\t: %d\n", x$kurtosis)
}


#################################################################################
######################           MAIN FUNCTIONS            ######################
#################################################################################

#' @title Binomial Mean
#' @description Calculates the mean of a binomial distribution
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Mean of the binomial distribution with a specified number of trials and success probability
#' @export
#' @examples
#' bin_mean(10, 0.3)
#' bin_mean(100, 0.1)
bin_mean <- function(trials, prob) {
  if (!check_trials(trials)) {
    stop("invalid trials value")
  }
  if (!check_prob(prob)) {
    stop("invalid prob value")
  }
  return(aux_mean(trials, prob))
}

#' @title Binomial Variance
#' @description Calculates the variance of a binomial distribution
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Variance of the binomial distribution with a specified number of trials and success probability
#' @export
#' @examples
#' bin_variance(10, 0.3)
#' bin_variance(100, 0.1)
bin_variance <- function(trials, prob) {
  if (!check_trials(trials)) {
    stop("invalid trials value")
  }
  if (!check_prob(prob)) {
    stop("invalid prob value")
  }
  return(aux_variance(trials, prob))
}

#' @title Binomial Mode
#' @description Calculates the mode of a binomial distribution
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Mode of the binomial distribution with a specified number of trials and success probability
#' @export
#' @examples
#' bin_mode(10, 0.3)
#' bin_mode(100, 0.1)
bin_mode <- function(trials, prob) {
  if (!check_trials(trials)) {
    stop("invalid trials value")
  }
  if (!check_prob(prob)) {
    stop("invalid prob value")
  }
  return(aux_mode(trials, prob))
}

#' @title Binomial Skewness
#' @description Calculates the skewness of a binomial distribution
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Skewness of the binomial distribution with a specified number of trials and success probability
#' @export
#' @examples
#' bin_skewness(10, 0.3)
#' bin_skewness(100, 0.1)
bin_skewness <- function(trials, prob) {
  if (!check_trials(trials)) {
    stop("invalid trials value")
  }
  if (!check_prob(prob)) {
    stop("invalid prob value")
  }
  return(aux_skewness(trials, prob))
}

#' @title Binomial Kurtosis
#' @description Calculates the kurtosis of a binomial distribution
#' @param trials Number of trials
#' @param prob Probability of success
#' @return Kurtosis of the binomial distribution with a specified number of trials and success probability
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
#' bin_kurtosis(100, 0.1)
bin_kurtosis <- function(trials, prob) {
  if (!check_trials(trials)) {
    stop("invalid trials value")
  }
  if (!check_prob(prob)) {
    stop("invalid prob value")
  }
  return(aux_kurtosis(trials, prob))
}



