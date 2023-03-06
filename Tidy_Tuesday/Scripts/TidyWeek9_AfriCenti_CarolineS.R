# Tidy Tuesday Script March 5th, 2023
# Caroline Solis

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!



# Libraries ------------------------------------------------
#install.packages("tidytuesdayR")
#install.packages("tidytext")
#install.packages("wordcloud")
library("tidyverse")
library("dplyr")
library("ggplot2")


# Load Data ------------------------------------------------
tuesdata <- tidytuesdayR::tt_load('2023-02-28') # Load the Tidy Tuesday dataset for week 9 of 2023
tuesdata <- tidytuesdayR::tt_load(2023, week = 9)

afrisenti <- tuesdata$afrisenti
languages <- tuesdata$languages
language_scripts <- tuesdata$language_scripts
language_countries <- tuesdata$language_countries
country_regions <- tuesdata$country_regions


afrisenti <- tuesdata$afrisenti # Extract the afrisenti dataset

# Functions ------------------------------------------------

# Summarize tweet counts by language and sentiment
afrisenti_summary <- afrisenti %>%
  group_by(language_iso_code, label) %>% #grouped by lang and label
  summarise(count = n()) %>% #summarise total count
  ungroup()

# Create stacked bar plot
ggplot(afrisenti_summary, aes(x = language_iso_code, y = count, fill = label)) + #x is lang and y is count. Categorized by label
  geom_col() +
  scale_fill_manual(values = c("#377EB8", "#E41A1C", "tan"), # color scheme
                    labels = c("Positive", "Negative", "Neutral")) + # for legend
  xlab("Language ISO Code") + # x and y labels
  ylab("Tweet Count") +
  ggtitle("Sentiment of Tweets in Different African Languages") #plot title


