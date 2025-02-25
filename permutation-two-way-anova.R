# renv::install("permuco")
library(permuco)

set.seed(123)  # Ensure reproducibility

# Define factor levels
fertilizer_levels <- c("Organic", "Chemical", "Control")
moisture_levels <- c("Low", "Medium", "High")

# Generate a fully crossed design with 5 replicates per condition (3x3x5 = 45)
plant_data <- expand.grid(
  fertilizer = fertilizer_levels,
  moisture = moisture_levels,
  rep = 1:5  # 5 replicates per condition
)

# Simulate plant growth response variable
plant_data$growth <- round(rnorm(45, mean = 20, sd = 5) + 
                             ifelse(plant_data$fertilizer == "Organic", 4, 0) + 
                             ifelse(plant_data$moisture == "High", 2, 0), 1)

# Convert categorical variables to factors
# plant_data$fertilizer <- as.factor(plant_data$fertilizer)
# plant_data$moisture <- as.factor(plant_data$moisture)


# write to file with space as a delimiter using write_delim
write_delim(plant_data, "data-raw-plant_growth.txt")


anova_model <- lm(growth ~ fertilizer * moisture, data = plant_data)
anova(anova_model)

# Run permutation-based ANOVA with 5000 permutations
perm_anova <- aovperm(growth ~ fertilizer * moisture, 
                      data = plant_data, np = 5000)

# Show results
summary(perm_anova)

# Run post-hoc pairwise comparisons for fertilizer

emmeans(perm_anova, ~ fertilizer * moisture)


