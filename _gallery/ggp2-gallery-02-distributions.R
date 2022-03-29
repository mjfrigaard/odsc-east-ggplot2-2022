## ----meta, echo=FALSE----------------------------------------------------------------------------------
library(metathis)
meta() %>%
  meta_general(
    description = "ODSC: ggplot2 Graph Gallery",
    generator = "xaringan and remark.js"
  ) %>%
  meta_name("github-repo" = "mjfrigaard/odsc-ggplot2-2022/tree/gh-pages") %>%
  meta_social(
    title = "ODSC: Exploratory Data Visualization with ggplot2",
    url = "https://mjfrigaard.github.io/odsc-ggplot2-2022/",
    og_type = "website",
    og_author = "Martin Frigaard",
    twitter_card_type = "summary",
    twitter_creator = "@mjfrigaard"
  )


## ----setup, include=FALSE------------------------------------------------------------------------------
dateWritten <- format(as.Date('2021-09-21'), format = "%B %d %Y")
today <- format(Sys.Date(), format = "%B %d %Y")
library(knitr)
library(tidyverse)
library(fontawesome)
library(ggwaffle)
library(ggpubr)
library(ggrepel)
library(ggridges)
library(ggtern)
library(ggsunburst)
library(ggbeeswarm)
library(ggmosaic)
library(ggcorrplot)
library(openintro)
library(ggwaffle)
library(statebins)
options(
    htmltools.dir.version = FALSE,
    knitr.table.format = "html",
    knitr.kable.NA = ''
)
# fs::dir_create("slides-cache/")
knitr::opts_chunk$set(
    cache = TRUE,
    warning = FALSE,
    message = FALSE,
    fig.path = "images/",
    fig.width = 7.252,
    fig.height = 4,
    comment = " ",
    fig.retina = 3 # Better figure resolution
)
xaringanExtra::use_tile_view()
xaringanExtra::use_panelset()
xaringanExtra::use_clipboard()
xaringanExtra::use_share_again()
xaringanExtra::style_share_again(share_buttons = "all")
xaringanExtra::use_extra_styles(
  hover_code_line = TRUE,
  mute_unhighlighted_code = FALSE
)
# xaringan::inf_mr() ----


## ----funs, include=FALSE, warning=FALSE, message=FALSE-------------------------------------------------
# fs::dir_tree("../code")
source("../src/copy-slide-images.R")
source("../src/create-movie-data.R")
source("../src/vcsExtra-datasets-fun.R")
movies_data <- create_movie_data()
movies_data <- filter(movies_data, !is.na(budget)) %>%
  mutate(mpaa = factor(mpaa,
    levels = c("PG", "PG-13", "R")
  ))


## ----tribble-code, eval=FALSE--------------------------------------------------------------------------
## tribble(
##   ~`variable 1`, ~`variable 2`,
##             "a",            1,
##             "b",            2,
##             "c",            3)


## ----tribble-print, echo=FALSE-------------------------------------------------------------------------
rmarkdown::paged_table(
tribble(
  ~`variable 1`, ~`variable 2`,
            "a",            1,
            "b",            2,
            "c",            3)
    )


## ----package-datasets, message=FALSE, warning=FALSE----------------------------------------------------
library(palmerpenguins)
library(fivethirtyeight)
library(ggplot2movies)


## ----penguins------------------------------------------------------------------------------------------
palmerpenguins::penguins -> penguins


## ----paged_table-penguins, echo=FALSE------------------------------------------------------------------
rmarkdown::paged_table(penguins)


## ----fivethirtyeight, eval=FALSE-----------------------------------------------------------------------
## datasets("fivethirtyeight")


## ----paged_table-fivethirtyeight, echo=FALSE-----------------------------------------------------------
rmarkdown::paged_table(datasets("fivethirtyeight"))


## ----movies_data, eval=FALSE---------------------------------------------------------------------------
## movies_data


## ----paged_table-movies_data, echo=FALSE---------------------------------------------------------------
rmarkdown::paged_table(movies_data)


## ----penguins-geom_histogram-code, eval=FALSE----------------------------------------------------------
## penguins


## ----penguins-geom_histogram-paged, echo=FALSE---------------------------------------------------------
rmarkdown::paged_table(penguins)




## ----plot-geom_histogram, ref.label='geom_histogram', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----


## ----geom_freqpoly-penguins-code, eval=FALSE-----------------------------------------------------------
## penguins


## ----geom_freqpoly-penguins-paged, echo=FALSE----------------------------------------------------------
rmarkdown::paged_table(penguins)




## ----plot-geom_freqpoly, ref.label='geom_freqpoly', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----





## ----plot-geom_freqpoly_group, ref.label='geom_freqpoly_group', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----


## ----geom_dotplot-code, eval=FALSE---------------------------------------------------------------------
## penguins


## ----geom_dotplot-paged, echo=FALSE--------------------------------------------------------------------
rmarkdown::paged_table(penguins)





## ----plot-geom_dotplot, ref.label='geom_dotplot', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----


## ----geom_dotplot-stackgroups-code, eval=FALSE---------------------------------------------------------
## penguins_histodot <- filter(penguins, !is.na(sex))


## ----geom_dotplot-stackgroups-paged, echo=FALSE--------------------------------------------------------

rmarkdown::paged_table(penguins_histodot)


## ----labs_histodot-------------------------------------------------------------------------------------



## ----plot-geom_dotplot-stackgroups, ref.label='penguins_histodot_stackgroups', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----


## ----ggbeeswarm-penguins-code, eval=FALSE--------------------------------------------------------------
## penguins


## ----ggbeeswarm-penguins-paged, echo=FALSE-------------------------------------------------------------
rmarkdown::paged_table(movies_data)





## ----plot-geom_beeswarm, ref.label='geom_beeswarm', echo=FALSE, fig.align='center', out.width='85%', out.height='85%'----


## ----geom_density-code, eval=FALSE---------------------------------------------------------------------
## penguins


## ----geom_density-paged, echo=FALSE--------------------------------------------------------------------
rmarkdown::paged_table(penguins)





## ----plot-geom_density, ref.label='geom_density', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----





## ----plot-geom_density-alpha, ref.label='geom_density-alpha', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----


## ----geom_density_ridges-penguins-code, eval=FALSE-----------------------------------------------------
## penguins


## ----geom_density_ridges-penguins-paged, echo=FALSE----------------------------------------------------
rmarkdown::paged_table(penguins)





## ----plot-geom_density_ridges, ref.label='geom_density_ridges', echo=FALSE, fig.align='center', out.width='85%', out.height='85%'----


## ----geom_boxplot-code, eval=FALSE---------------------------------------------------------------------
## movies_data


## ----geom_boxplot-paged, echo=FALSE--------------------------------------------------------------------
rmarkdown::paged_table(movies_data)





## ----plot-geom_boxplot, ref.label='geom_boxplot', echo=FALSE, fig.align='center', out.width='90%', out.height='90%'----


## ----skim-length-output, echo=FALSE--------------------------------------------------------------------
lgnth_skim <- skimr::skim(movies_data$length)
LengthBoxStats <- select(lgnth_skim,
     `25th` = numeric.p25, Median = numeric.p50,
     `75th` = numeric.p75, Histogram = numeric.hist) %>%
     mutate(IQR = IQR(movies_data$length, na.rm = TRUE)) %>%
     select(`25th`, Median, `75th`, IQR, Histogram)
rmarkdown::paged_table(LengthBoxStats)


## ----boxplot-diagram, echo=FALSE, fig.align='center', out.width='100%', out.height='100%'--------------
knitr::include_graphics(path = "images/boxplot-diagram.png")


## ----ggp_box-ggp_freqp, fig.align='center', out.width='68%', out.height='68%', echo=FALSE, fig.width=8, fig.height=4, eval=FALSE----



## ----boxplot-comparisons, echo=FALSE, fig.align='center', out.width='70%', out.height='70%'------------
knitr::include_graphics(path = "images/boxplot-comparisons.png")

