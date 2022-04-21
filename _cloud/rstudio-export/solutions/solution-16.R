#=====================================================================#
# File name: solution-16.R
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

# penguins_no_miss --------------------------------------------------------
penguins_no_miss <- drop_na(data = penguins)

# big_penguins ------------------------------------------------------------
big_penguins <- bind_rows(
  slice_max(.data = penguins, bill_length_mm, n = 1),
  slice_max(.data = penguins, bill_depth_mm, n = 1),
  slice_max(.data = penguins, flipper_length_mm, n = 1),
  slice_max(.data = penguins, body_mass_g, n = 1))

# create label and source  ------------------------------------------------------------
big_penguins <- mutate(.data = big_penguins, 
          label = case_when(
  bill_length_mm == 59.6 ~ paste0("long bill = ", bill_length_mm),
  bill_depth_mm == 21.5 ~ paste0("deep bill = ", bill_depth_mm),
  flipper_length_mm == 231 ~ paste0("big flipper = ", flipper_length_mm),
  body_mass_g == 6300 ~ paste0("big bird = ", body_mass_g)),
          source = case_when(
  bill_length_mm == 59.6 ~ "max bill length",
  bill_depth_mm == 21.5 ~ "max bill depth",
  flipper_length_mm == 231 ~ "max flipper length",
  body_mass_g == 6300 ~ "max body mass"))

# labs_bodymass_bill_depth_flipper_length --------------------------------------------
labs_bodymass_bill_depth_flipper_length <- labs(
  title = "Body mass, flipper length & bill depth", 
  subtitle = "Size measurements Palmer foraging penguins",
  x = "Bill depth (mm)", 
  y = "Flipper length (mm)", 
  size = "Body mass (g)")

# ggp_penguin_measures ------------------------------------------------
ggp_penguin_measures <- ggplot(data = penguins_no_miss) + 
  geom_point(
    mapping = aes(x = bill_depth_mm, 
                  y = flipper_length_mm, 
                  size = body_mass_g), 
    alpha = 1/3) + 
  geom_point(data = big_penguins,
             mapping = aes(x = bill_depth_mm, 
                           y = flipper_length_mm,
                           color = source,
                           size = body_mass_g),
             show.legend = FALSE) + 
  scale_size(range = c(1, 5)) 

ggp_penguin_measures + 
  ggrepel::geom_label_repel(
    data = big_penguins,
    mapping = aes(x = bill_depth_mm,
                  y = flipper_length_mm,
                  label = label), 
  # adjust size
              size = 2) +
  # facet by sex
  facet_wrap(. ~ sex) + 
  # labels
  labs_bodymass_bill_depth_flipper_length
