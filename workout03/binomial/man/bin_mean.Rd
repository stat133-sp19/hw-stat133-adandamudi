% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/main_func.R
\name{bin_mean}
\alias{bin_mean}
\title{Binomial Mean}
\usage{
bin_mean(trials, prob)
}
\arguments{
\item{trials}{Number of trials}

\item{prob}{Probability of success}
}
\value{
Mean of the binomial distribution with a specified number of trials and success probability
}
\description{
Calculates the mean of a binomial distribution
}
\examples{
bin_mean(10, 0.3)
bin_mean(100, 0.1)
}
