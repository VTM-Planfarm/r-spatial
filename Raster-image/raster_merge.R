library(sf, quietly = TRUE)
library(terra, quietly = TRUE)

tif_files <- list.files("Raster-image/tif-input", full.names = TRUE,
                        pattern = "*.tif$", recursive = TRUE)

rasters <- lapply(tif_files, rast)

merged_raster <- do.call(merge, rasters)

forest_block_path <- Sys.glob("Raster-image/forest-block/*.geojson")

sf_forest_block <- st_read(forest_block_path)

sf_forest_block <- st_transform(sf_forest_block, 4326)

masked_raster <- mask(merged_raster, sf_forest_block, inverse = TRUE)

raster_polygon <- as.polygons(masked_raster)

writeRaster(masked_raster, "Raster-image/output/merged_interpolation.tif",
            overwrite = TRUE)
            