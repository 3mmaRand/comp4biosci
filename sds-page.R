library(tidyverse)
library(imager)

# import gel
gel <- load.image("data-image/26C-10-Coomassie-Blue.jpg")

# import molecular weights
mw <- read_table("data-image/standard-mw.txt")

plot(gel)

# crop
gel_cropped <- crop.borders(gel, nx = 300, ny = 150)

plot(gel_cropped)

gel_top <- 180
gel_bottom <- 990

# add a line to plot 
abline(h = gel_top, col = "red")
abline(h = gel_bottom, col = "red")

# vertical guides just to help with locator
abline(v = 220, col = "red")
abline(v = 510, col = "red")

gel_length <- gel_bottom - gel_top

# Number of bands in your marker lane
# click from the top or gel to the bottom 
# i.e., high MW to low
marker_positions <- locator(n = 9)  

pos_patB <- locator(n = 1)
dist_to_patB <- pos_patB$y - 180
patB_Rf = (gel_length - dist_to_patB) / gel_length


# add marker positions to the mw data frame
mw <- mw |> 
  mutate(x = marker_positions$x,
         y = marker_positions$y,
         dist_to_band = y - 180,
         Rf = (gel_length - dist_to_band) / gel_length,
         log_kda = log(kda)) 


ggplot(data = mw, aes(x = Rf, y = log_kda)) +
  geom_point(size = 4) +
  geom_smooth(method = "lm", 
              se = FALSE,
              colour = "gray30") +
  theme_classic()

# fit a linear model
mod <- lm(log_kda ~ Rf, data = mw)

patB_log_kda <- predict(mod, newdata = data.frame(Rf = patB_Rf)) 


ggplot(data = mw, aes(x = Rf, y = log_kda)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", 
              se = FALSE,
              colour = "gray30") +
  annotate("segment", x = patB_Rf, xend = patB_Rf, 
           y = 0, yend = patB_log_kda,
           linetype = "dashed", 
           colour = "red") +
  annotate("segment", x = 0, xend = patB_Rf, 
           y = patB_log_kda, yend = patB_log_kda,
           linetype = "dashed", 
           colour = "red") +
  scale_x_continuous(expand = c(0, 0),
                     limits = c(0, 1)) +
  scale_y_continuous(expand = c(0, 0),
                     limits = c(0, 6)) +
  theme_classic()



patB_kda <- exp(patB_log_kda) 


# check results are the same.
# option one
# > mw_positions
# # A tibble: 9 × 2
# kda dist_to_band
# <dbl>        <dbl>
#   1   250          138
# 2   130          213
# 3   100          270
# 4    70          309
# 5    55          356
# 6    35          435
# 7    25          478
# 8    15          563
# 9    10          623

# gel_length <- 810
# pos_patB <- 394

# mw_positions
# # A tibble: 9 × 4
# kda     dist_to_band    Rf log_kda
#   <dbl>        <dbl> <dbl>   <dbl>
# 1   250          138 0.830    5.52
# 2   130          213 0.737    4.87
# 3   100          270 0.667    4.61
# 4    70          309 0.619    4.25
# 5    55          356 0.560    4.01
# 6    35          435 0.463    3.56
# 7    25          478 0.410    3.22
# 8    15          563 0.305    2.71
# 9    10          623 0.231    2.30
# Coefficients:
  # (Intercept)           Rf  
# 1.091        5.231  


# patB_Rf
# [1] 0.5135802

# > patB_kda
# 1 
# 43.69469 








































