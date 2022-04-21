#=====================================================================#
# File name: solution-11.R
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

# labs_bodymass_vs_species ------------------------------------------------
labs_bodymass_vs_species <- ggplot2::labs(
  title = "Body mass by species of Palmer penguins", 
  subtitle = "Counts for adult foraging penguins",
  x = "Body Mass (grams)", 
  fill = "Species")

# set alpha to 1/2 -------------------------------------------------------
ggplot(data = penguins) + 
  geom_density(
    mapping = aes(x = body_mass_g, 
                  fill = species),
    alpha = 1/2) + 
  labs_bodymass_vs_species