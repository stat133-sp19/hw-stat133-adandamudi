# Savings Simulations

The objective of this project is to create an application to help visualize a variety of saving and investing scenarios. Given an initial investing amount and annual contribution amount as well as prospective return and growth rates, this app allows you to valuate your savings for a specified number of years, displaying your savings after each year. With this application, you can see how the different saving modalities compare with each other i.e. compare your savings for x number of years with a no contribution, fixed contribution, and growing contribution saving modality. I used a line graph to display the savings amount after each year for each of these modalities. You can choose to view all the lines on the same graph by setting "Facet?" to "No". If you wish to have a separate graph for each of the modalities, be sure to set "Facet?" to "Yes".

### Getting Started

You can clone this Gitub repository or simply download the zip file if you wish to look at the contents of this project more thoroughly. 

### Prerequisites

To be able to run the R code that launches the shiny application, you will need to install R (and preferably RStudio) on your computer. You will also need to install the following R packages to ensure complete functionality of the code: "shiny", "ggplot2"

Assuming you have homebrew installed already, you could do the following to install R and RStudio:
```
brew install r
brew cask install rstudio
```
Once you have RStudio downloaded, you can type the following commands into the console of RStudio to download the shiny and ggplot2 packages.
```
install.packages("shiny")
install.packages("ggplot2")
```
After this, you should be able to run the R code in RStudio that launches the shiny application by clicking the "Run App" button at the top right side of the code panel.  Once you launch the app, you can set the values of initial amount, annual contribution, return rate, growth rate, and years to values of your choice. Remember to set "Facet?" to "Yes" if you want separate line graphs for each of the three different savings modalities.
