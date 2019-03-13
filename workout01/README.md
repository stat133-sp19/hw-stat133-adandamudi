# GSW Shot Charts

The objective of this project is to analyze and visualize shot data of NBA players. I analyze the shot accuracies of the following five Golden State Warriors players: Stephen Curry, Kevin Durant, Draymond Green, Andre Iguodala, and Klay Thompson. To get a better sense of each player's shot accuracies from different locations on the court, I created a visualization of the shot data for each NBA player. By using a scatterplot to display all the shots that a particular player took and color coding each point to encode if the shot was successful or not, I created a set of 5 graphs to visualize shot accuracies of these 5 players.

### Getting Started

You can clone this Gitub repository or simply download the zip file if you wish to look at the contents of this project more thoroughly. 

### Prerequisites

To be able to run the R code that produces the visualizations and summaries, you will need to install R (and preferably RStudio) on your computer. You will also need to install the following R packages to ensure complete functionality of the code: "ggplot2", jpeg", "grid"

Assuming you have homebrew installed already, you could do the following to install R and RStudio:
```
brew install r
brew cask install rstudio
```
Once you have RStudio downloaded, you can type the following commands into the console of RStudio to download the ggplot2, jpeg, and grid packages.
```
install.packages("ggplot2")
install.packages("jpeg")
install.packages("grid")
```
After this, you should be able to run the R code and reproduce the visualizations.
