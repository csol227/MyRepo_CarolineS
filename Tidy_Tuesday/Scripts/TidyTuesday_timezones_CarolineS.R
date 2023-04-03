# Tidy Tuesday Script week 13 data Timezones
# Caroline Solis

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

# Libraries ------------------------------------------------
#install.packages("magrittr")
#library("magritter")
library("tidyverse")
library("dplyr")
library("tidyr")
library("ggplot2")
library(maps)
library("here")


# Load Data ------------------------------------------------

tuesdata <- tidytuesdayR::tt_load('2023-03-28')
tuesdata <- tidytuesdayR::tt_load(2023, week = 13)

#transitions <- tuesdata$transitions
timezones <- tuesdata$timezones
timezone_countries <- tuesdata$timezone_countries
#countries <- tuesdata$countries

# Functions ------------------------------------------------

# Join datasets and merge by common column "zone"
timezone_map <- left_join(timezone_countries, timezones, by = "zone") %>%
  left_join(countries, by = "country_code")

# Filter out missing values
timezone_map <- drop_na(timezone_map)

# Create plot and set aesthetics
world_map <- map_data("world")

ggplot(timezone_map, aes(x = longitude, y = latitude, fill = place_name)) +
  geom_polygon() + # Add filled polygons with specified color scale
  scale_fill_viridis_d() +
  labs(x = "Longitude", y = "Latitude", fill = "Place Name", # Set axis and title labels
       title = "Number of Time Zones by Country",
       subtitle = "The darker the color, the more time zones a country has") +
  theme_bw() +
  theme(panel.grid.major = element_line(colour = "gray", size = 0.5), # Set plot theme
        panel.grid.minor = element_blank(),
        axis.title = element_text(size = 12, face = "bold"),
        plot.title = element_text(size = 16, face = "bold"),
        panel.background = element_rect(fill = "white", colour = "black"),
        plot.background = element_rect(fill = "white", colour = NA, size = 0)) +
  geom_polygon(data = world_map, aes(x = long, y = lat, group = group),
               fill = "transparent", color = "black", size = 0.2)

ggsave(here("Tidy_Tuesday", "Output", "TidyTuesday_timezones_CarolineS.png"), width = 7, height = 5)





