##############################################
# Title: All Shots Visualizations for 5 GSW Players
# Description: Creates a scatterplot visualization for each player about where each shot was taken and if it was successful 
# Input: All shots data file including statistics on 5 GSW players and NBA court image file 
# Output: Shots charts for each of the 5 GSW players, facetted shot chart including shots of all 5 GSW players
##############################################

library(ggplot2)
library(jpeg)
library(grid)

#Create raster object of court image
court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

#Read in the dataset from the previous part
shots_data <- read.csv("../data/shots-data.csv")
  
curry_shot_chart <- ggplot(data = shots_data[shots_data$name == "Stephen Curry", ]) + 
	annotation_custom(court_image, -250, 250, -50, 420) +
	geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
	ylim(-50, 420) + 
	ggtitle("Shot Chart: Stephen Curry (2016 season)") + 
	theme_minimal()

pdf(file = "../images/stephen-curry-shot-chart.pdf", width=6.5, height=5)
curry_shot_chart
dev.off()

durant_shot_chart <- ggplot(data = shots_data[shots_data$name == "Kevin Durant", ]) + 
	annotation_custom(court_image, -250, 250, -50, 420) +
	geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
	ylim(-50, 420) + 
	ggtitle("Shot Chart: Kevin Durant (2016 season)") + 
	theme_minimal()

pdf(file = "../images/kevin-durant-shot-chart.pdf", width=6.5, height=5)
durant_shot_chart
dev.off()

green_shot_chart <- ggplot(data = shots_data[shots_data$name == "Draymond Green", ]) + 
	annotation_custom(court_image, -250, 250, -50, 420) +
	geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
	ylim(-50, 420) + 
	ggtitle("Shot Chart: Draymond Green (2016 season)") + 
	theme_minimal()

pdf(file = "../images/draymond-green-shot-chart.pdf", width=6.5, height=5)
green_shot_chart
dev.off()

iguodala_shot_chart <- ggplot(data = shots_data[shots_data$name == "Andre Iguodala", ]) + 
	annotation_custom(court_image, -250, 250, -50, 420) +
	geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
	ylim(-50, 420) + 
	ggtitle("Shot Chart: Andre Iguodala (2016 season)") + 
	theme_minimal()

pdf(file = "../images/andre-iguodala-shot-chart.pdf", width=6.5, height=5)
iguodala_shot_chart
dev.off()

thompson_shot_chart <- ggplot(data = shots_data[shots_data$name == "Klay Thompson", ]) + 
	annotation_custom(court_image, -250, 250, -50, 420) +
	geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
	ylim(-50, 420) + 
	ggtitle("Shot Chart: Klay Thompson (2016 season)") + 
	theme_minimal()

pdf(file = "../images/klay-thompson-shot-chart.pdf", width=6.5, height=5)
thompson_shot_chart
dev.off()

#Create a facetted shot chart
gsw_shot_charts <- ggplot(data = shots_data, aes(x = x, y = y, color = shot_made_flag)) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) + 
  ggtitle("Shot Charts: GSW (2016 season)") + 
  facet_wrap(~name) + 
  theme_minimal()

pdf(file = "../images/gsw-shot-charts.pdf", width = 8, height = 7)
gsw_shot_charts
dev.off()

png(filename = "../images/gsw-shot-charts.png", width = 8, height = 7, units = "in", res = 200)
gsw_shot_charts
dev.off()


