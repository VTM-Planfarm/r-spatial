library(sf)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 3) {
  stop("Usage: Rscript subset-rainfall.R <input_path> <output_path> <rainfall_zone>") # nolint
}

# Read the input shapefile
input_path <- Sys.glob(paste0(args[1], "/*.shp"))
rainfalL_region <- st_read(input_path)

rainfalL_region <- filter(rainfalL_region, region_zon == args[3])

# Write the filtered data to a new shapefile
output_path <- args[2]
st_write(rainfalL_region, paste0(output_path, "/", args[3], ".shp"))