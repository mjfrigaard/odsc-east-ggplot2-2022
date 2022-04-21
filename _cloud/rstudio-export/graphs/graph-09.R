#=====================================================================#
# File name: graph-09.R
# This is code to create: graphs for ODSC 2022
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
labs_bodymass_vs_island <- ggplot2::labs(
  title = "Distribution of body mass by island of Palmer penguins", 
  subtitle = "Counts for adult foraging penguins",
  x = "Body Mass (grams)", 
  fill = "Island")


# set position to "dodge" ------------------------------------------------
ggplot(data = penguins_no_miss) + 
  geom_bar(mapping = aes(x = sex, 
                         fill = species), 
           position = ) + 
  labs_sex_vs_species

