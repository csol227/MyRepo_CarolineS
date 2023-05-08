# Tidy Tuesday Script data Childcare
# Caroline Solis


# Libraries ------------------------------------------------

library(ggplot2)
library(tidyverse)
library(ggtext)
library(here)

# Read Data ------------------------------------------------

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2023-05-09')
tuesdata <- tidytuesdayR::tt_load(2023, week = 19)

childcare_costs <- tuesdata$childcare_costs
counties <- tuesdata$counties


# Data Wrangling ------------------------------------------------

# Merge the childcare_costs and counties datasets by FIPS code
merged_data <- left_join(counties, childcare_costs, by = "county_fips_code")

# Change the names of the columns to make them easier to follow
merged_data$fips <- merged_data$county_fips_code
merged_data$state_abbr <- merged_data$state_abbreviation

# Calculate the median prices by state and type of care
median_prices <- merged_data %>% 
  group_by(state_abbr) %>% 
  summarise(
    mc_infant = median(mc_infant, na.rm = TRUE), 
    mc_toddler = median(mc_toddler, na.rm = TRUE), 
    mc_preschool = median(mc_preschool, na.rm = TRUE), 
    mcsa = median(mcsa, na.rm = TRUE), 
    mfcc_infant = median(mfcc_infant, na.rm = TRUE),
    mfcc_toddler = median(mfcc_toddler, na.rm = TRUE),
    mfcc_preschool = median(mfcc_preschool, na.rm = TRUE),
    mfccsa = median(mfccsa, na.rm = TRUE),
    mhi_2018 = median(mhi_2018, na.rm = TRUE)
  )

# Create a bar chart --------------------------------------

#create plot where x= the median income based by state and the y = the median income
Income_by_State <- ggplot(median_prices, aes(x = reorder(state_abbr, mhi_2018), y = mhi_2018)) +
  geom_bar(stat = "identity", fill = "#009E73") +
  labs(
    title = "Median Household Income by State", 
    x = "State",
    y = "Median Household Income (2018 dollars)"
  ) +
  theme_minimal() +
  theme( #using theme to set the text parameters of the plot
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 20, face = "bold"),
    panel.grid.major.y = element_line(color = "lightgray", linetype = "dashed"),
    panel.grid.minor.y = element_line("lightgrey"),
    plot.background = element_rect(fill = "white"),
  ) +
  geom_text( #geom_text to organize the prices showing after each bar
    aes(label = paste0("$", format(mhi_2018, big.mark = ","))),
    hjust = 0,
    size = 4,
    color = "#383838",
    fontface = "bold",
    nudge_y = 3000
  ) +
  coord_flip() + # so we can have the states on the y axis
  scale_y_continuous(labels = scales::dollar_format(scale = 0.001, suffix = "K"), 
                     limits = c(0, 90000), 
                     breaks = seq(0, 90000, 10000)) #so we can break the x-axis by 10 thousands

# save plot in output folder using here function
ggsave(here("Output", "Income_by_State.png"), plot = Income_by_State, width = 11, height = 10)
