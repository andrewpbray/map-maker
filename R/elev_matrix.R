library(elevatr)

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
                               clip = "bbox",
                               verbose = TRUE)
  
  # coerce the RasterLayer to a spatialdataframe
  elevation_spatial_df <- as(elevation, 'SpatialGridDataFrame')
  
  # ...and then coerce that to a dataframe
  elevation_df <- as.data.frame(elevation_spatial_df)
  
  # find the desired dimensions of the matrix
  nrow <- length(unique(elevation_df$s1))
  
  # make the matrix
  elevation_matrix <- matrix(elevation_df$layer,
                             nrow = nrow)
  # and return it!
  elevation_matrix
}
