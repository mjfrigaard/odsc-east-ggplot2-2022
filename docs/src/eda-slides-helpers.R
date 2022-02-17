#=====================================================================#
# File name: eda-slides-helpers.R
# This is code to create: misc
# Authored by and feedback to: mjfrigaard
# Last updated: 2022-02-16
# MIT License
# Version: NA
# https://www.statology.org/ggplot2-legend-size/
#=====================================================================#


# packages ----------------------------------------------------------------
library(tidyverse)
library(Lahman)
library(reprex)
library(xaringan)
library(pagedown)
library(xaringanthemer)
library(vcdExtra)
library(ggrepel)
library(ggbeeswarm)
library(ggwaffle)
library(palmerpenguins)
library(fivethirtyeight)
library(ggmosaic)
library(treemapify)
library(ggdendro)


# datasets function -------------------------------------------------------
# fs::dir_ls(".", recurse = FALSE)
source("src/vcsExtra-datasets-fun.R")

# create movies_data ------------------------------------------------------
source("src/create-movie-data.R")
movies_data <- create_movie_data()
movies_data <- filter(movies_data, !is.na(budget)) %>%
  mutate(mpaa = factor(mpaa,
    levels = c("PG", "PG-13", "R")
  ))

# set theme ----
ggplot2::theme_set(theme(
  axis.text = element_text(size = 8),
  axis.text.x = element_text(size = 8),
  axis.text.y = element_text(size = 8),
  plot.title = element_text(size = 10),
  axis.title = element_text(size = 8),
  legend.text = element_text(size = 5),
  legend.title = element_text(size = 6),
  legend.position = "left",
  legend.key.size = unit(0.4, 'cm')
  ))



# penguins data -----------------------------------------------------------
penguins <- palmerpenguins::penguins


# layers ------------------------------------------------------------------
# initialize

labs_pengiuns <- ggplot2::labs(
              title = "Flipper vs. Bill Length", 
              subtitle = "source: palmerpenguins::penguins", 
              x = "flipper length (mm)", 
              y = "bill length (mm)")

ggplot(data = penguins) + 
  labs_pengiuns

# no geom
ggplot(data = penguins, 
       mapping = aes(x = flipper_length_mm, 
                     y = bill_length_mm))

# geom (global aesthetics)
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, 
                     y = bill_length_mm)) +
  geom_point()

#  multiple layers
ggplot(data = penguins, 
       mapping = aes(x = flipper_length_mm, 
                     y = bill_length_mm)) +
  geom_point() + 
  geom_smooth(
    mapping = aes(x = flipper_length_mm, 
                     y = bill_length_mm, 
                     color = species))

# local mappings
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, 
                           y = bill_length_mm)) + 
  geom_smooth(mapping = aes(x = flipper_length_mm, 
                           y = bill_length_mm)) 
# layer by layer
ggplot() +
  # point layer
  ggplot2::layer(
    mapping = aes(x = flipper_length_mm, 
                      y = bill_length_mm), 
    data = penguins,
    geom = "point", 
    stat = "identity",
    position = "identity") + 
  # smooth layer
    ggplot2::layer(
    mapping = aes(x = flipper_length_mm, 
                      y = bill_length_mm), 
    data = penguins,
    geom = "smooth", 
    stat = "smooth",
    position = "identity",
    params = list(se = TRUE))


# Amounts -----------------------------------------------------------------


## bars --------------------------------------------------------------------
movies_data %>%
    ggplot(aes(x = mpaa)) +
    geom_bar(aes(fill = mpaa))

## grouped bars --------------------------------

movies_data %>%
    ggplot(aes(x = mpaa,
               y = rating)) +
    geom_col(aes(fill = mpaa))

## stacked bars ----

penguins %>%
    filter(!is.na(sex)) %>%
    ggplot(
      aes(x = flipper_length_mm,
          fill = sex)) +
    geom_bar()


penguins %>%
  ggplot(aes(fill = sex,
             y = flipper_length_mm,
             x = island)) +
    geom_bar(position = "stack",
             stat = "identity")

# Distributions -----------------------------------------------------------


## histograms -------------------------------------------------------------

penguins %>%
    ggplot(
     aes(x = flipper_length_mm)) +
     geom_histogram()


## frequency polygons ------------------------------------------------------

penguins %>%
    ggplot(
      aes(x = flipper_length_mm)) +
    geom_freqpoly()



## dot plots ---------------------------------------------------------------

penguins %>%
    ggplot(
      aes(x = flipper_length_mm)) +
    geom_dotplot()

penguins %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x = flipper_length_mm,
             fill = factor(sex))) +
  geom_dotplot(stackgroups = TRUE,
               binwidth = 1,
               method = "histodot")

## density plots  ----------------------------------------------------------

penguins %>%
    ggplot(
      aes(x = flipper_length_mm)) +
  geom_density()



penguins %>%
    filter(!is.na(sex)) %>%
    ggplot(aes(x = flipper_length_mm, fill = sex)) +
  geom_density(alpha = 1/3)


## diverging_bar_drug_use ----------------------------------------
use <- drug_use %>%
  select(age, n, ends_with("_use")) %>%
  pivot_longer(-c(age, n), names_to = "drug", values_to = "use") %>%
  mutate(drug = str_sub(drug, start = 1, end = -5))
freq <- drug_use %>%
  select(age, n, ends_with("_freq")) %>%
  pivot_longer(-c(age, n), names_to = "drug", values_to = "freq") %>%
  mutate(drug = str_sub(drug, start = 1, end = -6))
diverging_bar_drug_use <- left_join(x = use, y = freq,
                                by = c("age", "n", "drug")) %>%
  arrange(age) %>%
  select(age, n, drug, percent_using = use, median_use = freq) %>%
  filter(!is.na(median_use) & drug %in% c("alcohol", "cocaine",
                                          "marijuana", "pain_releiver",
                                          "meth", "heroin")) %>%
  mutate(age = as.character(age),
    perc_using_wt = round((percent_using - mean(percent_using)) / sd(percent_using), 2),
    perc_using_cat = if_else(perc_using_wt < 0, "below", "above"),
    perc_using_cat = factor(perc_using_cat, levels = c("above", "below"))) %>%
  select(`% using (weighted mean)` = perc_using_wt,
         `Category` = perc_using_cat,
         Drug = drug)

# div_bar_drug_use <- slice_sample(diverging_bar_drug_use, n = 15, replace = FALSE)

div_bar_drug_use <- tibble::tribble(
 ~`X (using weighted mean)`, ~Category,           ~Drug,
                      -0.25,   "below",     "marijuana",
                      -0.22,   "below", "pain_releiver",
                      -0.58,   "below",        "heroin",
                      -0.62,   "below",       "cocaine",
                      -0.36,   "below", "pain_releiver",
                      -0.58,   "below",        "heroin",
                       -0.6,   "below",          "meth",
                      -0.52,   "below", "pain_releiver",
                      -0.31,   "below",     "marijuana",
                      -0.26,   "below", "pain_releiver",
                       2.71,   "above",       "alcohol",
                          0,   "above",     "marijuana",
                       2.95,   "above",       "alcohol",
                       0.83,   "above",     "marijuana",
                      -0.62,   "below",        "heroin")


div_bar_drug_use %>%
  ggplot(aes(x = Drug, y = `% using (weighted)`, label = Drug)) +
  geom_bar(aes(fill = `Category`),
           stat = "identity", width = .5)


## diverging_bar_candy -----------------------------------------------------
candy_names <- c("Kit Kat", "Snickers",
                 "Reese's pieces", "Milky Way",
                 "Peanut butter M&M's",
                 "Peanut M&Ms", "3 Musketeers",
                 "Starburst", "M&M's",
                 "Nestle Crunch",
                 "Milky Way Simply Caramel",
                 "Skittles original")

diverging_bar_candy <- candy_rankings %>%
  tidyr::pivot_longer(
    cols = -c(competitorname, sugarpercent, pricepercent, winpercent),
     names_to = "characteristics", values_to = "present") %>%
  mutate(present = as.logical(present)) %>% arrange(competitorname) %>%
  filter(present == TRUE) %>% distinct() %>%
  select(-present) %>%
  mutate(sugar_price_diff = sugarpercent - pricepercent,
         sugar_price_cat = if_else(sugar_price_diff < 0, "below", "above"),
         sugar_price_cat = factor(sugar_price_cat,
                                  levels = c("above", "below"))) %>%
  arrange(desc(winpercent)) %>%
  filter(competitorname %in% candy_names) %>%
  select(name = competitorname,
         `sugar % - price %` = sugar_price_diff,
         Characteristics = characteristics,
         `Diff Category` = sugar_price_cat)

# div_bar_candy <- slice_sample(diverging_bar_candy, n = 20, replace = FALSE)

div_bar_candy <- tibble::tribble(
                     ~name, ~`sugar % - price %`, ~Characteristics, ~`Diff Category`,
                   "M&M's",         0.17399997,         "pluribus",        "above",
            "3 Musketeers",         0.09299999,           "nougat",        "above",
                 "Kit Kat",        -0.19799999, "crispedricewafer",        "below",
       "Skittles original",         0.72099998,           "fruity",        "above",
             "Peanut M&Ms",        -0.05800003,         "pluribus",        "below",
     "Peanut butter M&M's",         0.17399997,         "pluribus",        "above",
          "Reese's pieces",        -0.24500003,   "peanutyalmondy",        "below",
"Milky Way Simply Caramel",         0.10499996,        "chocolate",        "above",
          "Reese's pieces",        -0.24500003,        "chocolate",        "below",
            "3 Musketeers",         0.09299999,              "bar",        "above",
                "Snickers",        -0.10500002,           "nougat",        "below",
                "Snickers",        -0.10500002,        "chocolate",        "below",
               "Starburst",        -0.06900001,         "pluribus",        "below",
          "Reese's pieces",        -0.24500003,         "pluribus",        "below",
             "Peanut M&Ms",        -0.05800003,   "peanutyalmondy",        "below",
                 "Kit Kat",        -0.19799999,              "bar",        "below",
                "Snickers",        -0.10500002,              "bar",        "below",
               "Milky Way",        -0.04700005,           "nougat",        "below",
               "Starburst",        -0.06900001,           "fruity",        "below",
             "Peanut M&Ms",        -0.05800003,        "chocolate",        "below")

div_bar_candy %>%
  ggplot(aes(x = `sugar % - price %`,
            y =  reorder(name, `sugar % - price %`),
    label = Characteristics)) +
  geom_bar(aes(fill = `Diff Category`),
    stat = "identity",
           width = .5) + labs(y = " ")


## boxplot -----------------------------------------------------------------
# A box that stretches from the 25th percentile of the distribution to the 75th
# percentile, a distance known as the interquartile range (IQR). In the middle
# of the box is a line that displays the median, i.e. 50th percentile, of the
# distribution. These three lines give you a sense of the spread of the
# distribution and whether or not the distribution is symmetric about the
# median or skewed to one side.
#
# Visual points that display observations that fall more than 1.5 times the
# IQR from either edge of the box. These outlying points are unusual so are
# plotted individually.
#
# A line (or whisker) that extends from each end of the box and goes to the
# farthest non-outlier point in the distribution.

movies_data %>%
    ggplot(aes(x = ' ', y = length)) +
    geom_boxplot()

movies_data %>%
    ggplot(aes(x = length)) +
    geom_histogram(alpha = 1/3, fill = "orange") +
    coord_flip() +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank())

movies_data %>%
    ggplot(aes(x = length)) +
    # geom_histogram(alpha = 1/3, fill = "orange") +
    geom_freqpoly(color = "dodgerblue", size = 2, alpha = 1/2) +
    coord_flip() +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank())


movies_data %>%
    ggplot(aes(x = length, y = 1)) +
    # geom_histogram(alpha = 1/3, fill = "orange") +
    # geom_freqpoly(color = "dodgerblue", size = 2, alpha = 1/2) +
    geom_point(size = 4, color = "firebrick", alpha = 1/3) +
    coord_flip() +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank())




movies_data %>%
  ggplot(aes(x = 1, y = length)) +
  geom_point()

movies_data %>%
    ggplot(aes(x = mpaa,
               y = length)) +
  geom_boxplot() +
  theme(legend.position = "none")

# heatmap_births_2000_2014 -------------------------
heatmap_births_2000_2014 <- fivethirtyeight::US_births_2000_2014 %>%
    mutate(year = factor(year),
           weekday = as.character(day_of_week),
           weekday = factor(weekday))

heatmap_births_2000_2014 %>%
    ggplot(aes(weekday, year, fill = births)) +
    geom_raster() +
    scale_fill_distiller(palette = "RdPu")


# penguins_waffle_data ----------------------------------------------------
# https://github.com/hrbrmstr/waffle
penguins_waffle <- mutate(penguins, island = as.character(island))
penguins_waffle_data <- ggwaffle::waffle_iron(penguins_waffle,
                                     aes_d(group = island))

penguins_waffle_data %>%
  ggplot(aes(x, y, fill = group)) +
  ggwaffle::geom_waffle() +
  theme_waffle() + labs(x = " ", y = " ")

penguins_waffle_data %>%
  ggplot(aes(x, y, fill = group)) +
  ggwaffle::geom_waffle() +
    theme(rect = element_blank(),
          axis.ticks = element_blank(),
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 14),
          legend.position = "right",
          legend.key.size = unit(0.4, 'cm')
          ) +
    labs(x = " ", y = " ")


# flying_mosaic -----------------------------------------------------------
flying_mosaic <- fivethirtyeight::flying %>%
    select(recline_frequency, recline_rude) %>%
    filter(!is.na(recline_frequency) & !is.na(recline_rude)) %>%
    mutate(
        # character
        recline_rude = as.character(recline_rude),
        # factor
        recline_rude = factor(recline_rude),
        # character
        recline_often = as.character(recline_frequency),
        # factor
        recline_often = factor(recline_often))


flying_mosaic %>% ggplot() +
    geom_mosaic(aes(x = product(recline_rude),
    fill = recline_often)) +
    theme(rect = element_blank(),
          axis.ticks = element_blank())

# treemap_candy -----------------------------------------------------------
treemap_candy <- candy_rankings %>%
  tidyr::pivot_longer(
    cols = -c(competitorname, sugarpercent, pricepercent, winpercent),
     names_to = "characteristics", values_to = "present") %>%
  mutate(present = as.logical(present)) %>% arrange(competitorname) %>%
  filter(present == TRUE) %>%
  select(-present, -characteristics) %>%
  group_by(competitorname) %>%
  slice_max(winpercent, n = 1) %>%
  ungroup() %>%
  distinct() %>%
  transmute(name = competitorname,
            win_percent = winpercent,
            `sugar %` = round(sugarpercent, 1),
            `price %` = round(pricepercent, 1)) %>%
    slice_sample(n = 20, replace = FALSE)

treemap_candy %>%
  ggplot(aes(area = `sugar %`, fill = `price %`, label = name)) +
  geom_treemap() + geom_treemap_text(min.size = 3, colour = "white",
  place = "centre", grow = TRUE)

# TO-DO SUNBURST PLOTS -------------------------
# + https://towardsdatascience.com/visualize-nested-data-with-sunburst-plots-in-r-a65710388379
# + https://github.com/didacs/ggsunburst
# devtools::install_github("didacs/ggsunburst")
# library(ggsunburst)


# dumbbell_plot_police_deaths ---------------------------------------------
dumbbell_plot_police_deaths <- fivethirtyeight::police_deaths %>%
    group_by(state, year) %>%
    summarize(deaths = n()) %>%
    ungroup() %>%
    filter(year == 1997 | year == 2007) %>%
    arrange(desc(deaths))
death_states <- c("TX", "NY", "CA", "FL", "LA", "IN",
            "IL", "AZ", "NC", "MS", "SC", "AR")
dumbbell_plot_police_deaths <- dumbbell_plot_police_deaths %>%
    count(state, sort = TRUE) %>%
    filter(n == 2) %>%
    inner_join(x = ., y = dumbbell_plot_police_deaths, by = "state") %>%
    arrange(desc(state)) %>%
    filter(state %in% death_states) %>%
    mutate(paired = rep(1:(n()/2), each = 2),
            year = factor(year)) %>%
    select(`Police Deaths` = deaths,
           State = state,
           Year = year,
           paired)

dumbbell_plot_police_deaths %>%
  ggplot(aes(x = `Police Deaths`, y = State, group = paired)) +
  geom_line(size = 0.1) + geom_point(aes(color = Year), size = 0.2)

# ggdendro ---------------------------------------

deaths_year <- fivethirtyeight::police_deaths %>%
    filter(year == 2015) %>%
    group_by(state, year) %>%
    summarize(deaths = n()) %>%
    ungroup()
killings_year <- fivethirtyeight::police_killings %>%
    group_by(state, year) %>%
    summarize(killings = n()) %>%
    ungroup()

police_death_killing_year <- inner_join(deaths_year, killings_year,
           by = c("state", "year"))

hclust_police <- police_death_killing_year %>%
    column_to_rownames(var = 'state') %>%
    select(deaths, killings)

police_hcmodel <- hclust(dist(hclust_police), method = "average")
dhc_police <- as.dendrogram(police_hcmodel)
rect_police_data <- dendro_data(dhc_police, type = "rectangle")

ggplot(ggdendro::segment(rect_police_data)) +
geom_segment(aes(x = x, y = y, xend = xend, yend = yend), size = 0.2) +
geom_text(data = ggdendro::label(rect_police_data), aes(x = x, y = y,
          label = label, hjust = -0.1), size = 1.8) + coord_flip() +
          scale_y_reverse(expand = c(0.2, 0)) +
          labs(x = " ", y = " ")


# scatter-plot -------------------------------------------------
scatter_movie_data <- movies_data %>%
    mutate(budget_mil = budget / 1000000,
           budget_mil = paste0(budget_mil, " mil"),
           budget_mil = factor(budget_mil)) %>%
    select(title, year, rating, length,
           budget, budget_mil, mpaa, genres)
# glimpse(scatter_movie_data)
scatter_movie_data %>%
    ggplot(aes(x = length, y = rating)) +
    geom_point(size = 0.3)

scatter_movie_data %>%
    ggplot(aes(x = length, y = rating)) +
    geom_point(aes(color = mpaa), size = 0.3, alpha = 1/3)

bubble_movie_data <- movies_data %>%
    mutate(`budget (million)` = budget / 1000000,
           budget_mil_fct = paste0(`budget (million)`, " mil"),
           budget_mil_fct = factor(budget_mil_fct)) %>%
    select(title, year, rating, length, `budget (million)`,
           budget, budget_mil_fct, mpaa, genres)

bubble_movie_data %>% ggplot(aes(x = length, y = rating)) +
  geom_point(aes(color = mpaa, size = `budget (million)`),
               alpha = 1/3) + theme(
                      legend.position = "left",
                      axis.text = element_text(size = 8),
                      axis.text.x = element_text(size = 8),
                      axis.text.y = element_text(size = 8),
                      plot.title = element_text(size = 10),
                      axis.title = element_text(size = 9),
                      legend.text = element_text(size = 7),
                      legend.title = element_text(size = 8),
                      legend.key.size = unit(0.9, 'cm')
                   )


# slopegraphs  ---------------------------------------------------

slopegraph_data <- structure(list(Date = structure(c(1L, 1L, 1L, 1L, 1L, 2L,
                                          2L, 2L, 2L, 2L),
                        .Label = c("11-May-18", "18-May-18"),
                        class = "factor"),
        Party = structure(c(5L, 3L, 2L, 1L, 4L, 5L, 3L, 2L, 1L, 4L),
                         .Label = c("Green", "Liberal",
                                    "NDP", "Others", "PC"),
                         class = "factor"),
        Pct = c(42.3, 28.4, 22.1, 5.4, 1.8, 41.9, 29.3,
                22.3, 5, 1.4)),
  class = "data.frame",
  row.names = c(NA, -10L))

str(slopegraph_data)

august_senate_polls_slopegraph <- fivethirtyeight::august_senate_polls %>%
    filter(cycle == 2014 | cycle == 2016) %>%
    mutate(dem_diff = dem_poll - dem_result) %>%
    group_by(state, cycle) %>%
    summarize(dem_diff_sum = sum(dem_diff)) %>%
    ungroup() %>%
    filter(state %in% c("NH","IA")) %>%
    mutate(cycle = factor(cycle, levels = c("2014", "2016")),
        state = factor(state, levels = c("IA", "NH"))) %>%
    select(Year = cycle,
       State = state,
       `Dem Support Diff (Pct)` = dem_diff_sum)

str(august_senate_polls_slopegraph)

august_senate_polls_slopegraph %>%
    ggplot(aes(x = Year,
               y = `Dem Support Diff (Pct)`,
               group = State)) +
    geom_line(aes(color = State), size = 2, alpha = 1,
              show.legend = FALSE) +
    geom_point(aes(color = State), size = 4, alpha = 1)


# Density Contours --------------------------------------------------------
ggplot(penguins, aes(x = flipper_length_mm, y = bill_length_mm)) +
 geom_point() +
 xlim(170, 240) +
 ylim(20, 60) +
 geom_density_2d()



# ggcorrplot --------------------------------------------------------------
library(ggcorrplot)
college_recent_grads <- fivethirtyeight::college_recent_grads
num <- select(college_recent_grads, employed_fulltime,
             employed_parttime, unemployment_rate,
             college_jobs, non_college_jobs, low_wage_jobs)
corr <- round(cor(num), 1)
corr_mat <- cor_pmat(corr)

ggcorrplot(corr_mat, method = "circle")


# line-graph-data ---------------------------------------------------------
august_senate_polls_line_data <- august_senate_polls %>%
  group_by(state, cycle) %>%
  summarize(
       rep_result_mean = mean(rep_result),
       dem_result_mean = mean(dem_result),
       result_diff = rep_result_mean - dem_result_mean) %>%
  ungroup() %>%
  filter(state %in% c("NH","IA")) %>%
  select(`Rep - Dem (Pct Diff)` = result_diff,
         State = state,
         Year = cycle)

august_senate_polls_line_data %>%
  ggplot(aes(x = Year, y = `Rep - Dem (Pct Diff)`, color = State)) +
  geom_line(aes(group = State))



# Error Bars --------------------------------------------------------------

df <- data.frame(
  trt = factor(c(1, 1, 2, 2)),
  resp = c(1, 5, 3, 4),
  group = factor(c(1, 2, 1, 2)),
  upper = c(1.1, 5.3, 3.3, 4.2),
  lower = c(0.8, 4.6, 2.4, 3.6)
)

p <- ggplot(df, aes(trt, resp, colour = group))
p + geom_crossbar(aes(ymin = lower, ymax = upper), width = 0.2)



august_senate_polls_crossbar_data <- august_senate_polls %>%
  group_by(state, cycle) %>%
  summarize(
       rep_result_mean = mean(rep_result),
       error_mean = mean(error),
       rep_upper = rep_result_mean + error_mean,
       rep_lower = rep_result_mean - error_mean) %>%
  ungroup() %>%
  filter(state == "NH") %>%
  mutate(election_cycle = as.factor(cycle)) %>%
  select(`Rep Result (Pct)` = rep_result_mean,
         State = state,
         Date = cycle,
         `Election Cycle` = election_cycle,
         rep_upper,
         rep_lower)


august_senate_polls_crossbar_data %>%
  ggplot(aes(x = Date,
             y = `Rep Result (Pct)`)) +
  geom_line(aes(group = State)) +
  geom_crossbar(
    aes(ymin = rep_lower,
        color = `Election Cycle`,
        ymax = rep_upper),
                width = 0.2)

august_senate_polls_errorbar_data <- august_senate_polls %>%
  group_by(state, cycle) %>%
  summarize(
       rep_result_mean = mean(rep_result),
       error_mean = mean(error),
       rep_upper = rep_result_mean + error_mean,
       rep_lower = rep_result_mean - error_mean) %>%
  ungroup() %>%
  filter(state == "IA") %>%
  mutate(election_cycle = as.factor(cycle)) %>%
  select(`Rep Result (Pct)` = rep_result_mean,
         State = state,
         Date = cycle,
         `Election Cycle` = election_cycle,
         rep_upper,
         rep_lower)


august_senate_polls_errorbar_data %>%
  ggplot(aes(x = Date,
             y = `Rep Result (Pct)`)) +
  geom_point(aes(group = State,
                 color = `Election Cycle`)) +
  geom_errorbar(
    aes(ymin = rep_lower,
        ymax = rep_upper,
        color = `Election Cycle`),
                width = 0.2)



# error bars (stacked cols) -----------------------------------------------

dodge <- position_dodge(width = 0.75)
movies_errorbar_data <- movies_data %>%
  group_by(mpaa, year) %>%
  summarize(
    avg_rating = mean(rating, na.rm = TRUE),
    sd_rating = sd(rating, na.rm = TRUE),
    upper = avg_rating + sd_rating,
    lower = avg_rating - sd_rating) %>%
  ungroup() %>%
  filter(year > 2002) %>%
  select(`Avg Rating` = avg_rating,
         Year = year,
         mpaa, upper, lower)

movies_errorbar_data %>%
    ggplot(aes(x = Year, y = `Avg Rating`, fill = mpaa)) +
    geom_col(position = dodge) +
    geom_errorbar(aes(ymin = lower, ymax = upper),
                  position = dodge, width = 0.25)



# confidence bands --------------------------------------------------------
police_deaths_conf_bands <- police_deaths %>%
  group_by(year) %>%
  summarize(deaths = sum(n())) %>%
  ungroup()

stderr <- function(x, na.rm=FALSE) {
  if (na.rm) x <- na.omit(x)
  sqrt(var(x)/length(x))
}
se <- stderr(police_deaths_conf_bands$deaths)
sd <- sd(police_deaths_conf_bands$deaths)

police_deaths_conf_bands %>%
  ggplot(aes(x = year, y = deaths)) +
  geom_ribbon(aes(ymin = deaths - se,
                  ymax = deaths + se,
                  ),
              fill = "grey70") +
  geom_line(aes(y = deaths))

police_deaths_conf_bands %>%
  ggplot(aes(x = year, y = deaths)) +
  geom_ribbon(aes(ymin = deaths - sd,
                  ymax = deaths + sd,
                  ),
              fill = "grey70") +
  geom_line(aes(y = deaths))


# Cartogram ---------------------------------------------------------------
library(cartogram)
library(tmap)
library(maptools)
#> Loading required package: sp
#> Checking rgeos availability: TRUE

data(wrld_simpl)
# keep only the Norway
norway <- wrld_simpl[wrld_simpl$NAME == "Norway", ]
# project the map
norway <- spTransform(norway, CRS("+init=epsg:3395"))
# construct cartogram
norway_cont <- cartogram_cont(x = norway, weight = "POP2005")
tm_shape(norway_cont) +
  tm_polygons("POP2005", style = "jenks") +
  tm_layout(frame = FALSE, legend.position = c("right", "bottom"))

# Choropleth --------------------------------------------------------------


# Cartogram Heatmap -------------------------------------------------------
library(openintro)
library(statebins)
police_killings_carto_heat <- police_killings %>%
  group_by(state) %>%
  summarize(killings = sum(n())) %>%
  ungroup() %>%
  rename(state_abbr = state) %>%
  mutate(state = usdata::abbr2state(state_abbr)) %>%
  filter(!is.na(state))

police_deaths_carto_heat <- police_deaths %>%
  group_by(state) %>%
  summarize(deaths = sum(n())) %>%
  ungroup() %>%
  rename(state_abbr = state) %>%
  mutate(state = usdata::abbr2state(state_abbr)) %>%
  filter(!is.na(state))

statebins::statebins(police_killings_carto_heat,
                     value_col = "killings",
                     name = "Police Killings",
                     round = TRUE,
          radius = grid::unit(16, "pt"),
          palette = "Reds", direction = 1) +
  theme_statebins(legend_position = "right")

statebins::statebins(police_deaths_carto_heat,
                     value_col = "deaths",
                     name = "Police Deaths",
                     round = FALSE,
          radius = grid::unit(16, "pt"),
          palette = "Reds", direction = 2) +
  theme_statebins(legend_position = "right")

