
# packages ---------------------------------------------------------------
library(tidyverse)
library(rmarkdown)
library(knitr)

# # render 01 - amounts -----------------------------------------------------
#  rmarkdown::render('ggp2-gallery-01-amounts.Rmd',  encoding = 'UTF-8')
# # remove cache
# unlink("ggp2-gallery-01-amounts_cache/", recursive = TRUE, force = TRUE)


# # render 02-distributions -------------------------------------------------
#  rmarkdown::render('ggp2-gallery-02-distributions.Rmd',  encoding = 'UTF-8')
# # remove cache
# unlink("ggp2-gallery-02-distributions_cache/", recursive = TRUE, force = TRUE)

# render 03-proportions -------------------------------------------------
 rmarkdown::render('ggp2-gallery-03-proportions.Rmd',  encoding = 'UTF-8')
# remove cache
# unlink("ggp2-gallery-03-proportions_cache/", recursive = TRUE, force = TRUE)

# # render ggp2-graph-gallery ---------------------------------------------
rmarkdown::render('ggp2-graph-gallery.Rmd',  encoding = 'UTF-8')
# remove cache
# unlink("ggp2-graph-gallery_cache/", recursive = TRUE, force = TRUE)



# PDF slides --------------------------------------------------------------
# html_slides <- list.files(".", pattern = ".html")
# pdf_slides <- str_replace(html_slides,
#   pattern = ".html",
#   replacement = ".pdf")
# pdf_slides <- paste0("pdfs/", pdf_slides)
# print_files <- tibble("pdfs" = pdf_slides,
#   "htmls" = html_slides)
# # print_files$pdfs[12]
# # print_files$htmls[12]
# pagedown::chrome_print(input = print_files$htmls[12], 
#                        output = print_files$pdfs[12], timeout = 120)