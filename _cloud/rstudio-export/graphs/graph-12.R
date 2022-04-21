#=====================================================================#
# File name: graph-12.R
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

# labs_body_mass_vs_bill_depth --------------------------------------------
labs_body_mass_vs_bill_depth <- ggplot2::labs(
  title = "Body mass and bill depth of Palmer penguins", 
  subtitle = "Size measurements for adult foraging penguins",
  x = "Body mass (mm)", 
  y = "Bill depth (mm)")


# set color to "firebrick" ------------------------------------------------
ggplot(data = penguins) + 
  geom_point(
    mapping = aes(x = body_mass_g, 
                  y = bill_depth_mm,
                  color = "firebrick")) + 
  labs_body_mass_vs_bill_depth