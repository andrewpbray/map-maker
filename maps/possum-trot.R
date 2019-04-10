# load necessary packages 
library(rayshader)
library(tidyverse)
library(raster)

# center point 37.840111, -89.593639

mat <- elev_matrix(lon = c(-89.586, -89.603),
                   lat = c(37.831, 37.847),
                   zoom = 14)

my_z <- 2
ambmat <- ambient_shade(mat)

mat %>%
  sphere_shade(texture = "desert")  %>%
  add_shadow(ray_shade(mat, zscale=3, maxsearch = 300), 0.5) %>%
  add_shadow(ambmat,0.5) %>%
  plot_3d(mat, zscale = my_z)

save_3dprint("possum-trot.stl", maxwidth = 200, unit = "mm")