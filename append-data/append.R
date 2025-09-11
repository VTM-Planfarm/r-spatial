library(sf)
library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
  stop("Usage: Rscript subset-rainfall.R <business_name> <code>") # nolint
}

base_path <- Sys.glob("append-data/base/*.shp")
sf_base <- st_read(base_path)

input_path <- Sys.glob("append-data/input/*.shp")
sf_input <- st_read(input_path)
sf_input <- st_transform(sf_input, 4326)

sf_base <- sf_base |>
  add_row(
    FID_1 = 0,
    code = args[2],
    Client = args[1],
    Business = args[1],
    geometry = sf_input$geometry
  )

st_write(sf_base, base_path, append = FALSE)
