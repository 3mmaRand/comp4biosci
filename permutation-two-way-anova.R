# # renv::install("permuco")
# library(permuco)

set.seed(123)  # Ensure reproducibility

# Define factor levels
fertilizer_levels <- c("Organic", "Chemical", "Control")
moisture_levels <- c("Low", "High")

# Generate a fully crossed design with 5 replicates per condition (2x3x5 = 30)
plant <- expand.grid(
  fertilizer = fertilizer_levels,
  moisture = moisture_levels,
  rep = 1:5  # 5 replicates per condition
)

# Simulate plant growth response variable
plant$growth <- round(rnorm(30, mean = 20, sd = 5) +
                             ifelse(plant$fertilizer == "Organic", 4, 0) +
                             ifelse(plant$moisture == "High", 2, 0), 1)

# Convert categorical variables to factors
plant$fertilizer <- as.factor(plant$fertilizer)
plant$moisture <- as.factor(plant$moisture)


# write to file with space as a delimiter using write_delim
write_delim(plant, "data-raw/plant_growth.txt")


#######################
library(tidyverse)
library(emmeans)

plant <- read_table("data-raw/plant_growth.txt")

anova_model <- lm(growth ~ fertilizer * moisture, data = plant)
anova(anova_model)

emmeans(anova_model, ~ fertilizer * moisture) |> pairs()

emmeans(anova_model, ~ fertilizer * moisture) |> plot()
