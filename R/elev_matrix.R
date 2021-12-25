library(elevatr)
library(dplyr)
library(rayshader)

elev_matrix <- function(lat, lon, zoom) {
  
  # this string tells elevatr what type of projection we want to use
  prj <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
  
  # calculate the maximum and minimum latitudes and longitudes
  max_lat <- lat[2]
  min_lat <- lat[1]
  max_lon <- lon[2]
  min_lon <- lon[1]
  
  # make a dataframe containing the geographical bounds
  # of the selected terrain
  geo_bounds <- data.frame(x = c(max_lon, 
                                 max_lon, 
                                 min_lon, 
                                 min_lon),
                           y = c(max_lat,
                                 min_lat,
                                 max_lat,
                                 min_lat))
  
  elevation <- elevatr::get_elev_raster(locations = geo_bounds,
                               prj = prj,
                               z = zoom,
                               clip = "bbox")
  
  # coerce the RasterLayer to a  matrix
  s <- raster_to_matrix(elevation)
  s
}
