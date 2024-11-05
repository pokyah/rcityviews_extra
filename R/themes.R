#' Available Themes
#'
#' A list of theme names for various city map styles.
#'
#' @format A character vector of theme names.
#' @export
.themes = c(
  "prettymaps.default",
  "prettymaps.macao",
  "prettymaps.minimal",
  "prettymaps.tijuca",
  "prettymaps.oslo",
  "prettymaps.tokyo",
  "prettymaps.paris")

#' Get Theme Options
#'
#' This function returns a list of options for a specified map theme, including color, font, and size settings.
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
                   # Prettymaps themes
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
                   "prettymaps.minimal" = list(
                     "background" = "#F8F8F8",
                     "water" = "#E0E0E0",
                     "landuse" = "#F0F0F0",
                     "contours" = "#C0C0C0",
                     "streets" = "#A0A0A0",
                     "rails" = c("#B0B0B0", "#D0D0D0"),
                     "buildings" = c("#D0D0D0", "#B0B0B0", "#808080"),
                     "text" = "#2F2F2F",
                     "waterlines" = "#A9A9A9"
                   ),
                   "prettymaps.tijuca" = list(
                     "background" = "#1E1F26",
                     "water" = "#2E5C77",
                     "landuse" = c("#517875", "#A3BF80", "#D4D4A8"),
                     "contours" = "#3C3C3C",
                     "streets" = "#F5E9DA",
                     "rails" = c("#F1F1F1", "#333333"),
                     "buildings" = c("#3A3A3A", "#6C6C6C", "#9E9E9E"),
                     "text" = "#FFFFFF",
                     "waterlines" = "#336E87"
                   ),
                   "prettymaps.oslo" = list(
                     "background" = "#EBF4FA",
                     "water" = "#C0D6DF",
                     "landuse" = c("#9BC2B3", "#B4E197", "#F9F871"),
                     "contours" = "#A3A3A3",
                     "streets" = "#D9D9D9",
                     "rails" = c("#BFBFBF", "#DADADA"),
                     "buildings" = c("#898989", "#B3B3B3", "#D6D6D6"),
                     "text" = "#505050",
                     "waterlines" = "#AACCE1"
                   ),
                   "prettymaps.tokyo" = list(
                     "background" = "#FAF3F2",
                     "water" = "#A8D3E6",
                     "landuse" = c("#BCE2E8", "#FFE4CC", "#F7CACD"),
                     "contours" = "#E7E7E7",
                     "streets" = "#FFFFFF",
                     "rails" = c("#DFDFDF", "#EFEFEF"),
                     "buildings" = c("#FFCEB4", "#F28D89", "#BBE3D5"),
                     "text" = "#333333",
                     "waterlines" = "#90C7DA"
                   ),
                   "prettymaps.paris" = list(
                     "background" = "#F5F3F1",
                     "water" = "#B4D0DE",
                     "landuse" = c("#E8D3D0", "#C2AFAE", "#BE97AD"),
                     "contours" = "#D3D3D3",
                     "streets" = "#FAFAFA",
                     "rails" = c("#D6D6D6", "#E9E9E9"),
                     "buildings" = c("#E0C6BF", "#CEB0A5", "#B89F91"),
                     "text" = "#494949",
                     "waterlines" = "#ACC8DA"
                   ),
                   # mythemes
                   "purple" = list(
                     "background" = "#522258",
                     "water" = "#D95F59",
                     "landuse" = c("#522258", "#522258", "#522258"),
                     "contours" = "#522258",
                     "streets" = "#8C3061",
                     "rails" = c("#8C3061", "#522258"),
                     "buildings" = c("#522258", "#522258", "#522258"),
                     "text" = "#D95F59",
                     "waterlines" = "#D95F59"
                   ),
                   "dark" = list(
                     "background" = "#0A1931",
                     "water" = "#185ADB",
                     "landuse" = c("#0A1931", "#0A1931", "#0A1931"),
                     "contours" = "#FFC947",
                     "streets" = "#FFC947",
                     "rails" = c("#FFC947", "#0A1931"),
                     "buildings" = c("#FEDDBE", "#FEDDBE", "#FEDDBE"),
                     "text" = "#FFC947",
                     "waterlines" = "#185ADB"
                   ),
                   "light" = list(
                     "background" = "#ffffff",
                     "water" = "#cedce9",
                     "landuse" = c("#ffffff", "#ffffff", "#ffffff"),
                     "contours" = "#ffffff",
                     "streets" = "#4b4b4b",
                     "rails" = c("#4b4b4b", "#ffffff"),
                     "buildings" = c("#ffffff", "#ffffff", "#ffffff"),
                     "text" = "#4b4b4b",
                     "waterlines" = "#cedce9"
                   ),
                   "greeny" = list(
                     "background" = "#006769",
                     "water" = "#006769",
                     "landuse" = c("#40A578", "#9DDE8B", "#E6FF94"),
                     "contours" = "#006769",
                     "streets" = "#9DDE8B",
                     "rails" = c("#9DDE8B", "#0A1931"),
                     "buildings" = c("#E6FF94", "#E6FF94", "#E6FF94"),
                     "text" = "#9DDE8B",
                     "waterlines" = "#006769"
                   ),
                   "church" = list(
                     "background" = "#000000",    # Bright gold, reminiscent of sunlight through glass
                     "water" = "#1F75FE",         # Vivid blue for strong water reflections
                     "landuse" = c("#E32636",     # Crimson red for dramatic contrasts
                                   "#228B22",     # Forest green for lush land areas
                                   "#FF4500"),    # Orange red for a striking variation
                     "contours" = "#A020F0",      # Deep purple for distinct contours
                     "streets" = "#FFFFFF",       # Keeping streets white for contrast against bright background
                     "rails" = c("#8A2BE2", "#9932CC"),  # Two shades of deep violet for rail elements
                     "buildings" = c("#FF6347",   # Tomato red for a vivid building color
                                     "#FF69B4",   # Hot pink for bold accents
                                     "#FFA500"),  # Orange for additional vibrancy in structures
                     "text" = "#FFD700",          # Black text for strong readability over vivid colors
                     "waterlines" = "#00CED1"     # Bright turquoise for waterline details
                   )
  )
  
  font <- switch(theme,
                 # Fonts for prettymaps themes
                 "default" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "macao" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "minimal" = list(
                   "family" = "Caveat",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "tijuca" = list(
                   "family" = "Libre Baskerville",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "oslo" = list(
                   "family" = "Libre Baskerville",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "tokyo" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "paris" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "dark" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "light" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "greeny" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 "church" = list(
                   "family" = "Ubuntu Mono",
                   "face" = "plain",
                   "scale" = 1
                 ),
                 # Default font settings if theme not found
                 list(
                   "family" = "Arial",
                   "face" = "plain",
                   "scale" = 1
                 )
  )
  
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

# Wrapper function for city_themes that automatically selects "Yes"
auto_yes_city_themes <- function(name, theme = NULL, force = FALSE, remove = FALSE) {
  testthat::with_mocked_bindings(
    "utils::menu" = function(...) 1,
    city_themes(name, theme, force, remove)
  )
}




#' Unregister All Themes
#'
#' Unregisters all themes from `rcityviews_extra` by iterating over each theme
#' and removing it from the `rcityviews` cache, bypassing the confirmation prompt.
#'
#' @details This function removes all themes in `.themes` from the `rcityviews` cache, automatically selecting "Yes"
#' for each removal confirmation. It provides an efficient way to reset theme registrations.
#'
#' @return A message indicating that all themes have been unregistered.
#' @export
manage_themes = function(remove = F){
  
  # define the theme registering function
  manage = function(name){
    theme = .themeOptions(name)
    if(!is.null(rcityviews:::city_themes(name = name))){
      # Add the custom theme to the cache without prompting
      auto_yes_city_themes(name = name, theme = theme, force = T, remove = remove)
    }else{
      message("Theme ", name, " already unregistered")
    }

  }
  
  themes <- .themes
  lapply(themes, manage)

}

#' List Available Themes
#'
#' Lists the names of all predefined themes available in the package for use in custom map styling.
#'
#' @return A character vector of theme names.
#' @export
list_themes = function(){
  .themes
}
