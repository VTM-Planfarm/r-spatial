# Run first time only
# Install renv package if not already installed
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Initalise renv environment
renv::init()

# Download packages
renv::install(c("sf", "terra", "tidyverse"))