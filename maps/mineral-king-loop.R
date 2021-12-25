# load necessary packages
library(elevatr)
library(rayshader)
library(dplyr)
library(raster)

zoom <- 12
my_z <- 12

prj <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

# make a dataframe containing the geographical bounds
# of the selected terrain
geo_bounds <- data.frame(x = c(-118.573860, 
                               -118.424247, 
                               -118.511274, 
                               -118.676419),
                         y = c(36.367715,
                               36.436472,
                               36.604020,
                               36.585147))

# get elevation data
elevation <- elevatr::get_elev_raster(locations = geo_bounds,
                                      prj = prj,
                                      z = zoom,
                                      clip = "bbox")

# convert to matrix
mat <- rayshader::raster_to_matrix(elevation)
wat <- detect_water(mat, min_area = 500, zscale = my_z) 

# create plot
mat %>%
  sphere_shade(texture = "desert")  %>%
  add_water(wat, color = "desert") %>%
  plot_3d(mat, zscale = my_z)

# save as stl file
save_3dprint("mineral-king-loop.stl", maxwidth = 200, unit = "mm")

