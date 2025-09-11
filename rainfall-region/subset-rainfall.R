library(sf)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 1) {
  stop("Usage: Rscript subset-rainfall.R <rainfall_zone>") # nolint
}

# Read the input shapefile
input_path <- Sys.glob("rainfall-region//input//*.shp")
rainfalL_region <- st_read(input_path)

rainfalL_region <- filter(rainfalL_region, region_zon == args[3])

# Write the filtered data to a new shapefile
output_path <- "rainfall-region//output"
st_write(rainfalL_region, paste0(output_path, "//", args[3], ".shp"))