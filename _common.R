library(tidyverse)
library(patchwork)




# book notes --------------------------------------------------------------

# adapted from R for Data Science (2e) by Hadley Wickham, 
# Mine Çetinkaya-Rundel, and Garrett Grolemund.
# Orignal: https://github.com/hadley/r4ds/blob/main/_common.R
status <- function(type) {
  status <- switch(type,
                   polishing = "almost readable but is a first draft and may substantial edits",
                   drafting = "is a dumping ground for ideas and not really readable",
                   complete = "is largely complete and just needs final proof reading",
                   stop("Invalid `type`", call. = FALSE)
  )
 
class <- switch(type,
                  polishing = "important",
                  drafting = "important",
                  complete = "note"
  )
  
   
  cat(paste0(
    "\n",
    ":::: status\n",
    "::: callout-", class, " \n",
    "You are reading a work in progress. ",
    "This page ", status, ". ",
    ":::\n",
    "::::\n"
  ))
}