#' Available Themes
#'
#' A list of theme names for various city map styles.
#'
#' @format A character vector of theme names.
#' @export
.themes <- c(
  "pokyah.church",
  "prettymaps.default",
  "prettymaps.macao",
  "prettymaps.minimal",
  "prettymaps.tijuca",
  "prettymaps.oslo",
  "prettymaps.tokyo",
  "prettymaps.paris",
  "pokyah.purple",
  "pokyah.dark",
  "pokyah.light",
  "pokyah.greeny"
)

# Define a font mapping for each theme to avoid repetition
.theme_fonts <- list(
  "prettymaps.default" = list(family = "PermanentMarker-Regular", face = "plain", scale = 1),
  "prettymaps.macao" = list(family = "PermanentMarker-Regular", face = "plain", scale = 1),
  "prettymaps.minimal" = list(family = "PermanentMarker-Regular", face = "plain", scale = 1),
  "prettymaps.tijuca" = list(family = "PermanentMarker-Regular", face = "plain", scale = 1),
  "prettymaps.oslo" = list(family = "Libre Baskerville", face = "plain", scale = 1),
  "prettymaps.tokyo" = list(family = "Uncial", face = "plain", scale = 1),
  "prettymaps.paris" = list(family = "Ubuntu Mono", face = "plain", scale = 1),
  "pokyah.purple" = list(family = "Ubuntu Mono", face = "plain", scale = 1),
  "pokyah.dark" = list(family = "Ubuntu Mono", face = "plain", scale = 1),
  "pokyah.light" = list(family = "Ubuntu Mono", face = "plain", scale = 1),
  "pokyah.greeny" = list(family = "PermanentMarker-Regular", face = "plain", scale = 1),
  "pokyah.church" = list(family = "AbrilFatface-Regular", face = "plain", scale = 1)
)

#' Get Theme Options
#'
#' Returns options for a specified map theme, including color, font, and size settings.
#' Each theme provides unique color schemes and font choices tailored to different styles and cities.
#'
#' @param theme A character string representing the theme name. Must be one of the predefined theme names in `.themes`.
#'
#' @return A list with three elements:
#' \describe{
#'   \item{colors}{A list of colors for background, water, landuse, contours, streets, rails, buildings, text, and waterlines.}
#'   \item{font}{A list with font family, face, and scale for the text used in the theme.}
#'   \item{size}{A list with size parameters for borders and streets, detailing contour lines, water, streets, and rails width.}
#' }
#' @export
.themeOptions <- function(theme) {
  
  colors <- switch(theme,
                   # Prettymaps themes colors
                   "prettymaps.default" = list(
                     "background" = "#F4F4F4",
                     "water" = "#9ED0E6",
                     "landuse" = c("#A7C4A0", "#DDECDC", "#B5E3C6"),
                     "contours" = "#CCCCCC",
                     "streets" = "#FFFFFF",
                     "rails" = c("#B5B5B5", "#E0E0E0"),
                     "buildings" = c("#CCCCCC", "#E5E5E5"),
                     "text" = "#333333",
                     "waterlines" = "#99C4DE"
                   ),
                   "prettymaps.macao" = list(
                     "background" = "#ECE2D0",
                     "water" = "#B8D7E6",
                     "landuse" = c("#B4D4C3", "#E6E6A1", "#F8C8DC"),
                     "contours" = "#F3B3A5",
                     "streets" = "#E8D4C3",
                     "rails" = c("#C2C1C1", "#F5D3B1"),
                     "buildings" = c("#F0E3CA", "#EDD7B1", "#D9BC8C"),
                     "text" = "#4B4B4B",
                     "waterlines" = "#9FC0D4"
                   ),
                   # Additional themes
                   "pokyah.church" = list(
                     "background" = "#FFD700",
                     "water" = "#1F75FE",
                     "landuse" = c("#E32636", "#228B22", "#FF4500"),
                     "contours" = "#A020F0",
                     "streets" = "#FFFFFF",
                     "rails" = c("#8A2BE2", "#9932CC"),
                     "buildings" = c("#FF6347", "#FF69B4", "#FFA500"),
                     "text" = "#000000",
                     "waterlines" = "#00CED1"
                   ),
                   # Add other theme color specifications here as needed...
                   
                   # Default to empty if theme not matched
                   list()
  )
  
  # Get font settings from theme_fonts or default if not found
  font <- .theme_fonts[[theme]] %||% list(family = "Arial", face = "plain", scale = 1)
  
  size <- list()
  size[["borders"]] <- list(
    "contours" = 0.15,
    "water" = 0.4,
    "canal" = 0.5,
    "river" = 0.6
  )
  size[["streets"]] <- list(
    "path" = 0.2,
    "residential" = 0.3,
    "structure" = 0.35,
    "tertiary" = 0.4,
    "secondary" = 0.5,
    "primary" = 0.6,
    "motorway" = 0.8,
    "rails" = 0.65,
    "runway" = 3
  )
  
  themeOptions <- list(
    "colors" = colors,
    "font" = font,
    "size" = size
  )
  
  return(themeOptions)
}

# Helper function to handle null with default values
`%||%` <- function(x, y) if (!is.null(x)) x else y

#' List Available Themes
#'
#' Lists the names of all predefined themes available in the package for use in custom map styling.
#'
#' @return A character vector of theme names.
#' @export
list_themes <- function(){
  .themes
}

#' Unregister All Themes
#'
#' Unregisters all themes by iterating over each theme and removing it from the `rcityviews` cache, bypassing confirmation.
#'
#' @return A message indicating that all themes have been unregistered.
#' @export
manage_themes <- function(remove = FALSE){
  
  # define the theme registering function
  manage <- function(name){
    theme <- .themeOptions(name)
    if (isFALSE(remove)){
      if (is.null(rcityviews:::city_themes(name = name))){
        # Add the custom theme to the cache without prompting
        auto_yes_city_themes(name = name, theme = theme, force = TRUE, remove = remove)
      } else {
        message("Theme ", name, " already registered")
      }
    } else {
      if (!is.null(rcityviews:::city_themes(name = name))){
        # remove the custom theme from the cache without prompting
        auto_yes_city_themes(name = name, theme = theme, force = TRUE, remove = remove)
      } else {
        message("Theme ", name, " already unregistered")
      }
    }
  }
  
  lapply(.themes, manage)
}

# Wrapper function for city_themes that automatically selects "Yes"
auto_yes_city_themes <- function(name, theme = NULL, force = FALSE, remove = FALSE) {
  original_menu <- utils::menu
  mock_menu <- function(...) 1
  utils_ns <- asNamespace("utils")
  
  unlock_binding_success <- try(unlockBinding("menu", utils_ns), silent = TRUE)
  if (inherits(unlock_binding_success, "try-error")) {
    stop("Unable to unlock binding for 'menu' in the 'utils' namespace.", call. = FALSE)
  }
  
  assign("menu", mock_menu, envir = utils_ns)
  
  on.exit({
    assign("menu", original_menu, envir = utils_ns)
    lockBinding("menu", utils_ns)
  }, add = TRUE)
  
  result <- rcityviews::city_themes(name, theme, force, remove)
  return(result)
}
