# Tidy Tuesday Script March 12th, 2023
# Caroline Solis


# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!


# Libraries ------------------------------------------------
library(tidyverse)
library(lubridate)
library(cowplot)

# Load Data ------------------------------------------------

tuesdata <- tidytuesdayR::tt_load('2023-03-07')
tuesdata <- tidytuesdayR::tt_load(2023, week = 10)

numbats <- tuesdata$numbats


# Functions ------------------------------------------------


# Calculate counts of transitions between each timezone
transition_counts <- transitions %>%
  count(begin, end) %>%
  arrange(desc(n)) %>%
  filter(n > 100)  # only show transitions with more than 100 occurrences

# Create ggplot object
ggplot(transition_counts, aes(x = begin, y = end, fill = n)) +
  geom_tile() +  # use tile geometry for heatmap
  scale_fill_gradient(low = "white", high = "steelblue") +  # set color gradient
  theme_minimal() +  # set theme to minimal
  labs(title = "Transitions between Timezones", x = "From", y = "To", fill = "Count")  # set title and axis labels












