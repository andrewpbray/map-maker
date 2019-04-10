# load necessary packages 
library(rayshader)
library(tidyverse)
library(raster)

crites_matrix <- elev_matrix(lon = c(-118.6040925244618, -118.39410948729221),
                             lat = c(36.334570897741614, 36.44868792601194),
                             zoom = 12)

my_z <- 12
wat <- detect_water(crites_matrix, min_area = 500, zscale = my_z)

crites_matrix %>%
  sphere_shade(texture = "desert")  %>%
  add_water(wat, color = "desert") %>%
  plot_3d(crites_matrix, zscale = my_z)

#save_3dprint("crites-lakes-medium.stl", maxwidth = 200, unit = "mm")