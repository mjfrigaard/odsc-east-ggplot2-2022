library(pagedown)


pagedown::chrome_print(input = "docs/eda-slides-01.html", "eda-slides-01.pdf", 
                       timeout = 10000)

pagedown::chrome_print(input = "docs/eda-slides-02.html", "eda-slides-02.pdf", 
                       timeout = 10000)