# Binomial Distribution Package

The package `binomial` is a simple R package that allows you to calculate the probability distribution of a binomial variable. Because the binomial distribution has so many real-world applications, this package provides you with the ability to easily create a binomial random variable and perform a variety of calculations. With this binomial random variable, you have the ability to compute significant values of this random variables such as the expected value, variance, mode, skewness, and kurtosis. This package also enables you to look at the probability distribution and cumulative distribution values and visualize them.

Here are the functions provided by this package that you may find helpful: <br>
`bin_choose()` <br>
`bin_variable()` <br>
`bin_probability()` <br>
`bin_distribution()` <br>
`bin_cumulative()` <br>
`bin_mean()` <br>
`bin_variance()` <br>
`bin_mode()` <br>
`bin_skewness()` <br>
`bin_kurtosis()` <br>

### Motivation

This package was created to learn the basic components of R package creation.

### Getting Started

You can clone this Gitub repository or simply download the zip file if you wish to look at the contents of this project more thoroughly. Once you have downloaded the files, you should manually install this package, after which you can load this package with `library(binomial)` and use the provided functions.

Manual installation of this package can be done as follows: 

You first need to make sure you have installed the package `devtools` as you will be using this package to download `binomial`.

```r
install.packages("devtools")
```

After this, you are ready to install the package `binomial`.

```r
# Install "cointoss" (without vignettes) 
devtools::install_github("stat133-sp19/hw-stat133-adandamudi/workout03/binomial")

# Install "cointoss" (with vignettes)
devtools::install_github("stat133-sp19/hw-stat133-adandamudi/workout03/binomial", build_vignettes = TRUE)
```

### Prerequisites

To be able to run the R code that produces the visualizations and summaries, you will need to install R (and preferably RStudio) on your computer. You will also need to install the following R packages to ensure complete functionality of the code: "ggplot2"

Assuming you have homebrew installed already, you could do the following to install R and RStudio:
```
brew install r
brew cask install rstudio
```
Once you have RStudio downloaded, you can type the following commands into the console of RStudio to download the ggplot2, jpeg, and grid packages.
```
install.packages("ggplot2")
```
After this, you should be able to run the R code and reproduce the visualizations.

### Usage

```r
library(binomial)

#Make a binomial random variable
bin_var <- bin_variable(trials = 5, p = 0.5)
bin_var 
#> "Binomial Variable" 
#>  
#> Parameters 
#>  - number of trials :  5   
#>  - prob of success :  0.5 

# Look at the summary of a binomial random variable 
bin_rv_sum <- summary(bin_var) 
bin_rv_sum 
#> "Summary Binomial" 
#>
#> Parameters 
#>  - number of trials :  5  
#>  - prob of success :  0.5 
#>  
#> Measures 
#> - mean   :  2.5 
#>  - variance  :  1.25   
#>  - mode  :  2 3   
#>  - skewness  :  0  
#>  - kurtosis  :  -0.4 

# Calculates the probability of getting a certain number of successes in the total trials
bin_probability(success = 0:5, trials = 5, prob = 0.5)
#> [1] 0.03125 0.15625 0.31250 0.31250 0.15625 0.03125

# Calculates the probability of all possible number of successes with the specified number of trials and probability of success 
bin_dis <- bin_distribution(trials = 5, prob = 0.5) 
bin_dis 
#>   success probability 
#> 1       0     0.03125 
#> 2       1     0.15625 
#> 3       2     0.31250 
#> 4       3     0.31250 
#> 5       4     0.15625 
#> 6       5     0.03125 

# Calculates the cumulative probability of all possible number of successes with the specified number of trials and probability of success 
bin_cum <- bin_cumulative(trials = 5, prob = 0.5) 
bin_cum
#>   success probability cumulative 
#> 1       0     0.03125    0.03125 
#> 2       1     0.15625    0.18750 
#> 3       2     0.31250    0.50000 
#> 4       3     0.31250    0.81250
#> 5       4     0.15625    0.96875
#> 6       5     0.03125    1.00000 

# Calculates the mean of the binomial variable with the specified number of trials and success probability
bin_mean(trials = 5, prob = 0.5)
#> [1] 2.5 

# Calculates the variance of the binomial variable with the specified number of trials and success probability
bin_variance(trials = 5, prob = 0.5)
#> [1] 1.25

# Calculates the mode of the binomial variable with the specified number of trials and success probability
bin_mode(trials = 5, prob = 0.5) 
#> [1] 2 3 

# Calculates the skewness of the binomial variable with the specified number of trials and success probability 
bin_skewness(trials = 5, prob = 0.5) 
#> [1] 0 

# Calculates the kurtosis of the binomial variable with the specified number of trials and success probability 
bin_kurtosis(trials = 5, prob = 0.5)
#> [1] -0.4
```

