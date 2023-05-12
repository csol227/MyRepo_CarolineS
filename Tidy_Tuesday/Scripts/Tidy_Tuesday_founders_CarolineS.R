# Tidy Tuesday Script data founder crops
# Caroline Solis


# Libraries ------------------------------------------------
library(ggplot2)
library(here)

# Read Data ------------------------------------------------
# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

#tuesdata <- tidytuesdayR::tt_load('2023-04-18')
#tuesdata <- tidytuesdayR::tt_load(2023, week = 16)

founder_crops <- tuesdata$founder_crops


# Create the plot ------------------------

Distribution_plot <- ggplot(founder_crops, aes(x = category, fill = edibility)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("#66c2a5", "#fc8d62", "#8da0cb", "#e78ac3", "#a6d854", "#ffd92f", "#e5c494", "#b3b3b3", "#ffeda0")) +
  labs(x = "Founder Crop Category", y = "Count", fill = "Edibility") +
  theme_bw() +
  theme(panel.grid.major = element_line(color = "gray", size = 0.5),
        panel.grid.minor = element_blank(),
        axis.title = element_text(size = 12, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
        plot.title = element_text(size = 16, face = "bold"),
        panel.background = element_rect(fill = "white", color = "black"),
        plot.background = element_rect(fill = "white", color = NA, size = 0)) +
  ggtitle("Distribution of Founder Crops by Category and Edibility")


ggsave(here("Tidy_Tuesday","Output", "Distribution_plot.png"), plot = Distribution_plot)
