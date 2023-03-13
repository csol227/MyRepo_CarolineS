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

# Create a new column for the temperature range
numbats_temp <- numbats %>% 
  drop_na(tmin, tmax) %>% # Remove any rows that have missing temperature values
  mutate(temp_range = tmax - tmin, # Create a new column for the temperature range
         date = as.Date(eventDate)) # Convert the eventDate column to a date format and save it as a new column called date

# Create a ggplot object with line geometry and date scales
plot_full_data <- ggplot(numbats_temp, aes(x = date, y = temp_range)) + # Set the x-axis to the date column and the y-axis to the temperature range column
  geom_line(aes(color = "Temperature Range")) + # Draw a line plot with a blue color
  geom_line(aes(y = prcp, color = "Precipitation")) + # Set the x-axis to display only year labels and break at 1 year intervals
  scale_x_date(date_labels = "%Y", date_breaks = "1 year") +
  ylab("Temperature Range / Precipitation") + # Label the y-axis with the units of the temperature range column
  xlab("Date") +
  scale_color_manual(name = "", values = c("Temperature Range" = "steelblue", "Precipitation" = "darkgreen")) +
  theme_minimal() +
  ggtitle("Temperature Range and Precipitation in Australia")

# Create a second ggplot object with the same data, but with a limited x-axis range
plot_from_2015 <- ggplot(numbats_temp, aes(x = date, y = temp_range)) +
  geom_line(aes(color = "Temperature Range")) +
  geom_line(aes(y = prcp, color = "Precipitation")) +
  scale_x_date(date_labels = "%Y", date_breaks = "1 year") + # Set the x-axis to display only year labels and break at 1 year intervals
  ylab("Temperature Range / Precipitation") +
  xlab("Date") +
  scale_color_manual(name = "", values = c("Temperature Range" = "steelblue", "Precipitation" = "darkgreen")) +
  theme_minimal() +  # Apply the minimal theme to the plot
  ggtitle("Temperature Range and Precipitation in Australia (2015 - Present)") +
  coord_cartesian(xlim = as.Date(c("2015-01-01", Sys.Date()))) #uses real time data for x-axis

# Combine the two plots using cowplot
plot_grid(plot_full_data, plot_from_2015, ncol = 1, align = "v", axis = "tb") #plot the two individuals together














