#=====================================================================#
# File name: graph-01.R
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

# View --------------------------------------------------------------------
View(penguins)

# glimpse -----------------------------------------------------------------
glimpse()

# str ---------------------------------------------------------------------
str()

# build labels ------------------------------------------------------------
labs_bill_vs_flippper <- ggplot2::labs(title = "", 
                                       subtitle = "", 
                                       x = "", 
                                       y = "")

# initialize plot ---------------------------------------------------------
ggplot(data = ) 
  

