library(tidyverse)
library(patchwork)

knitr::opts_chunk$set(
  collapse = TRUE,
  fig.retina = 3,
  fig.width = 5)



# book notes --------------------------------------------------------------

# adapted from R for Data Science (2e) by Hadley Wickham, 
# Mine Çetinkaya-Rundel, and Garrett Grolemund.
# Orignal: https://github.com/hadley/r4ds/blob/main/_common.R


status <- function(type) {
  status <- switch(type,
                   polishing = "is a first draft but should be readable",
                   drafting = "is a dumping ground for ideas and not really readable",
                   complete = "is compete but needs final proof reading",
                   stop("Invalid `type`", call. = FALSE)
  )
 
class <- switch(type,
                  polishing = "warning",
                  drafting = "important",
                  complete = "tip"
  )
  
   
  cat(paste0(
    "\n",
    "::: {.callout-", class, "} \n",
    "You are reading a work in progress. ",
    "This page ", status, ".\n",
    ":::\n"
  ))
}





  