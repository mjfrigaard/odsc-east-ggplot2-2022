#=====================================================================#
# File name: graph-13.R
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

# penguins_no_miss --------------------------------------------------------
penguins_no_miss <- drop_na(data = penguins)

# big_penguins ------------------------------------------------------------
big_penguins <- bind_rows(
  slice_max(.data = penguins, bill_length_mm, n = 1),
  slice_max(.data = penguins, flipper_length_mm, n = 1),
  slice_max(.data = penguins, body_mass_g, n = 1))

# create label and source  ------------------------------------------------------------
big_penguins <- mutate(.data = big_penguins, 
        label = case_when(
    bill_length_mm == 59.6 ~ paste0("big bill = ", bill_length_mm),
    flipper_length_mm == 231 ~ paste0("big flipper = ", flipper_length_mm),
    body_mass_g == 6300 ~ paste0("big bird = ", body_mass_g)),
        source = case_when(
    bill_length_mm == 59.6 ~ "max bill length",
    flipper_length_mm == 231 ~ "max flipper length",
    body_mass_g == 6300 ~ "max body mass"))

# labs_bodymass_bill_flipper_length --------------------------------------------
labs_bodymass_bill_flipper_length <- labs(
  title = "Body mass, flipper and bill length", 
  subtitle = "Size measurements Palmer foraging penguins",
  x = "Bill length (mm)", 
  y = "Flipper length (mm)",
  size = "Body mass (g)")

# Add layer 1 ------------------------------------------------
ggplot(data = penguins) + 
  # layer 1
  geom_point(
    mapping = aes(x = , 
                  y = , 
                  size = ),
    alpha = ) +
  # labs
  labs_bodymass_bill_flipper_length

