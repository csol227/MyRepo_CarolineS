# Tidy Tuesday Script week 17 data Marathon Winners
# Caroline Solis

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!


# Libraries ------------------------------------------------

library("tidyverse")
library("dplyr")
library("tidyr")
library("ggplot2")
library("here")

# Load Data ------------------------------------------------

tuesdata <- tidytuesdayR::tt_load('2023-04-25')
tuesdata <- tidytuesdayR::tt_load(2023, week = 17)

winners <- tuesdata$winners
london_marathon <- tuesdata$london_marathon

# Functions ------------------------------------------------

# Aggregate London Marathon data by year
london_agg <- london_marathon %>% #shows the total number of finishers in each year
  group_by(Year) %>%
  summarize(Total_Finishers = sum(Finishers)) 

# Create plot
ggplot() +
  # Add London Marathon data as a line
  geom_line(data = london_agg, aes(x = Year, y = Total_Finishers), color = "blue") +
  # Add Winners data as points
  geom_point(data = winners, aes(x = Year, y = Time), color = "red") +
  # Add plot titles and axis labels
  labs(title = "London Marathon Finishers and Winning Time",
       x = "Year",
       y = "Total Finishers / Winning Time") +
  theme_bw()
