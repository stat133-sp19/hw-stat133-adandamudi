##############################################
# Title: All Shots of 5 NBA Players
# Description: Combines the shots data of 5 GSW players into a single table 
# Input: Each player's shots data, read in from a CSV
# Output: Summary statistics of each player's shot data; combined shots data of the 5 GSW players outputted as a CSV
##############################################

#Read in all the datasets
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)

#Add a column name that contains the name of the corresponding player
curry$name <- "Stephen Curry"
durant$name <- "Kevin Durant"
green$name <- "Draymond Green"
iguodala$name <- "Andre Iguodala"
thompson$name <- "Klay Thompson"

#Change shot_made_flag to be more descriptive
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"

#Add the minute that each shot was taken
curry$minute <- curry$period * 12 - curry$minutes_remaining
durant$minute <- durant$period * 12 - durant$minutes_remaining
green$minute <- green$period * 12 - green$minutes_remaining
iguodala$minute <- iguodala$period * 12 - iguodala$minutes_remaining
thompson$minute <- thompson$period * 12 - thompson$minutes_remaining

#Save summary of each data frame
sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()

sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file = '../output/draymond-green-summary.txt')
summary(green)
sink()

sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

sink(file = '../output/klay-thompson-summary.txt')
summary(thompson)
sink()

#Combine into a single data frame
shots_data <- rbind(curry, durant, green, iguodala, thompson)

#Export the csv to the data folder using a relative path
write.csv(shots_data, file = '../data/shots-data.csv')

#Save summary of the combined data frame
sink(file = '../output/shots-data-summary.txt')
summary(shots_data)
sink()





