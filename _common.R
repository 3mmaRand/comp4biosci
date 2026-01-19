suppressMessages(library(tidyverse))
suppressMessages(library(patchwork))

knitr::opts_chunk$set(
  collapse = TRUE,
  fig.retina = 3,
  fig.width = 6,
  fig.height = 4)

options(
  scipen = 999,
  digits = 4
)


# book notes --------------------------------------------------------------

# adapted from R for Data Science (2e) by Hadley Wickham, 
# Mine Çetinkaya-Rundel, and Garrett Grolemund.
# Orignal: https://github.com/hadley/r4ds/blob/main/_common.R


status <- function(type) {
  status <- switch(type,
                   polishing = "is a draft but is mainly complete should be readable",
                   drafting = "is a dumping ground for one or more ideas. Sections maybe missing, or in bullet form and code may not be explained",
                   complete = "is compete but suggestions for improvements are welcome. Follow the link to 'Make a suggestion' to suggest improvements",
                   stop("Invalid `type`", call. = FALSE)
  )
  
  class <- switch(type,
                  polishing = "note",
                  drafting = "important",
                  complete = "tip"
  )
  heading <- switch(type,
                  polishing = "Draft",
                  drafting = "Incomplete",
                  complete = "Complete"

  )
  cat(paste0(
    "\n",
    "::: {.callout-", class, "} \n",
    "## ", heading, "\n",
    "You are reading a live document. ",
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

# function for shading under a normal distribution curve

dnorm_limit <- function(x,
                        q    = 1.96,
                        mu   = 0,
                        sd   = 1,
                        area = c("lowertail", "uppertail", "twotails", "middle")) {
  area <- match.arg(area)
  y <- dnorm(x, mean = mu, sd = sd)
  
  # distance from mu
  d <- abs(q - mu)
  lower_bound <- mu - d
  upper_bound <- mu + d
  
  if (area == "lowertail") {
    # keep x <= q
    y[x >  q] <- NA
  } else if (area == "uppertail") {
    # keep x >= q
    y[x <  q] <- NA
  } else if (area == "twotails") {
    # keep x <= lower_bound OR x >= upper_bound
    y[x > lower_bound & x < upper_bound] <- NA
  } else if (area == "middle") {
    # keep lower_bound <= x <= upper_bound
    y[x < lower_bound | x > upper_bound] <- NA
  }
  
  y
}
