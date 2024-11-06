theme_file <- "./data-raw/themes.json"
if (file.exists(theme_file)) {
  theme_data <- jsonlite::fromJSON(theme_file)
  themes <- names(theme_data$themes)  # Initialize .themes with the names of themes
} else {
  stop("Theme configuration file not found.")
}
# saving in ./data/*.rda
usethis::use_data(theme_data, themes, internal = FALSE, overwrite = TRUE)