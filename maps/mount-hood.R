# load necessary packages 
library(rayshader)
library(tidyverse)
library(raster)

# center point 37.840111, -89.593639

mat <- elev_matrix(lon = c(-89.586, -89.6),
                           lat = c(37.831, 37.847),
                           zoom = 14)

my_z <- 12

mat %>%
  sphere_shade(texture = "desert")  %>%
  plot_3d(mat, zscale = my_z)

#save_3dprint("crites-lakes-medium.stl", maxwidth = 200, unit = "mm")