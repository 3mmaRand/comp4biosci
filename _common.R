library(tidyverse)
library(patchwork)

knitr::opts_chunk$set(
  collapse = TRUE,
  fig.retina = 3,
  fig.width = 6,
  fig.height = 4)



# book notes --------------------------------------------------------------

# adapted from R for Data Science (2e) by Hadley Wickham, 
# Mine Çetinkaya-Rundel, and Garrett Grolemund.
# Orignal: https://github.com/hadley/r4ds/blob/main/_common.R


status <- function(type) {
  status <- switch(type,
                   polishing = "is a first draft but should be readable",
                   drafting = "is a dumping ground for ideas. Sections maybe missing, or contain a list of points to include",
                   complete = "is compete but needs final proof reading",
                   stop("Invalid `type`", call. = FALSE)
  )
  
  class <- switch(type,
                  polishing = "warning",
                  drafting = "important",
                  complete = "tip"
  )
  heading <- switch(type,
                  polishing = "First draft",
                  drafting = "Incomplete",
                  complete = "Just needs proof reading"

  )
  cat(paste0(
    "\n",
    "::: {.callout-", class, "} \n",
    "## ", heading, "\n",
    "You are reading a work in progress. ",
    "This page ", status, ".\n",
    ":::\n"
  ))
}

#  blue, pink, green triadic

pal1 <- c("#eef8fa", "#faeef8","#f8faee")
pal2 <- c("#9fd8e3", "#e39fd8", "#d8e39f")
pal3 <- c("#64c0d2", "#d264c0", "#c0d264")
pal4 <- c("#256c7a", "#7a256c", "#6c7a25")



# Create ggplot objects with no axis numbers
## Correlation Examples


# Function to remove axis numbers and ticks
theme_no_axis_numbers <- function() {
  theme(
    axis.text = element_blank(),  # Remove axis numbers
    axis.ticks = element_blank()  # Remove axis ticks
  )
}


