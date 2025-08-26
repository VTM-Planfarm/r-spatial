library(sf)
library(tibble)

base_path <- Sys.glob("append-data/base/*.shp")
sf_base <- st_read(base_path)
sf_base$code <- as.character(sf_base$code)

input_path <- Sys.glob("append-data/input/*.shp")
sf_input <- st_read(input_path)
sf_input <- st_transform(sf_input, 4326)

sf_base <- sf_base |>
  add_row(
    FID_1 = 0,
    code = "6?9Ur1o4`",
    Client = "Dring",
    Business = "Dring",
    geometry = sf_input$geometry
  )

st_write(sf_base, base_path, append = FALSE)
