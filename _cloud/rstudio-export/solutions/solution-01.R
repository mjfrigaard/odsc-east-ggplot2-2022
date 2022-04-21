#=====================================================================#
# File name: solution-01.R
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


# View --------------------------------------------------------------------
View(penguins)

# glimpse -----------------------------------------------------------------
glimpse(penguins)

# str ---------------------------------------------------------------------
str(penguins)


# build labels ------------------------------------------------------------
labs_bill_vs_flippper <- ggplot2::labs(
  title = "Bill and flipper length of Palmer penguins", 
  subtitle = "Size measurements for adult foraging penguins",
  x = "Bill length (mm)", 
  y = "Flipper length (mm)")


# initialize plot ---------------------------------------------------------
ggplot(data = penguins) 
