suppressPackageStartupMessages(library(sf))
library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
  stop("Usage: Rscript append-data/append.R <business_name> <code>") # nolint
}

base_path <- Sys.glob("append-data/base/*.shp")
sf_base <- read_sf(base_path)

input_path <- Sys.glob("append-data/input/*.shp")
sf_input <- read_sf(input_path)
sf_input <- st_transform(sf_input, 4326)

if (nrow(filter(sf_base, code == as.numeric(args[2]))) > 0) {
  stop("Error: Code already exists in the base dataset.")
}

sf_base <- sf_base |>
  add_row(
    FID_1 = 0,
    code = as.numeric(args[2]),
    Client = args[1],
    Business = args[1],
    geometry = sf_input$geometry
  )

st_write(sf_base, base_path, append = FALSE)
