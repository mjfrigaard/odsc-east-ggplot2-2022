#=====================================================================#
# File name: solution-09.R
# This is code to create: solutions for ODSC 2022
# Authored by and feedback to: @mjfrigaard
# Last updated: 2022-03-10
# MIT License
# Version: 1.0
#=====================================================================#

# packages ----------------------------------------------------------------
library(tidyverse)
library(palmerpenguins)
library(janitor)
library(patchwork)
library(janitor)
library(ggrepel)

# load data ---------------------------------------------------------------
penguins <- palmerpenguins::penguins

# build labels ------------------------------------------------------------
labs_sex_vs_species <- ggplot2::labs(
  title = "Body mass by species of Palmer penguins", 
  subtitle = "Counts for adult foraging penguins",
  x = "Sex", 
  fill = "Species")

# penguins_no_miss --------------------------------------------------------
penguins_no_miss <- drop_na(data = penguins)

# set position to "dodge" ------------------------------------------------
ggplot(data = penguins_no_miss) + 
  geom_bar(mapping = aes(x = sex, 
                         fill = species), 
           position = "dodge") + 
  labs_sex_vs_species

