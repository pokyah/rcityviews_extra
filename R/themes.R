#' Get Theme Options
#'
#' Retrieves options for a specified map theme, including color, font, and size settings.
#' Applies `default_size` if no size data is found for the theme.
#'
#' @param theme A character string representing the theme name.
#' @return A list with `colors`, `font`, and `size` settings for the theme.
#' @export
.themeOptions <- function(theme) {
  theme_info <- theme_data$themes[[theme]]
  
  if (is.null(theme_info)) {
    warning("Theme not found. Using default settings.")
    theme_settings <- list(
      colors = list(),
      font = theme_data$default_font,
      size = theme_data$default_size
    )
  } else {
    
    theme_settings <- list(
      colors = theme_info$colors,
      font = theme_info$font %||% theme_data$default_font,
      size = merge_lists(theme_data$default_size, theme_info$size)
    )
  }
  
  return(theme_settings)
}

# Helper function to handle null with default values
`%||%` <- function(x, y) if (!is.null(x)) x else y

# Helper function to merge lists, using defaults where needed
merge_lists <- function(default, custom) {
  if (is.null(custom)) return(default)
  merged <- default
  for (key in names(custom)) {
    if (is.list(custom[[key]])) {
      merged[[key]] <- merge_lists(default[[key]], custom[[key]])
    } else {
      merged[[key]] <- custom[[key]]
    }
  }
  return(merged)
}

#' Unregister or Register Themes
#'
#' Registers or unregisters themes from `rcityviews`, depending on the `remove` parameter.
#' @param remove Logical; if TRUE, unregister themes. If FALSE, register them.
#' @export
manage_themes <- function(remove = FALSE) {
  
  manage <- function(name) {
    theme <- .themeOptions(name)
    if (!remove) {
      if (is.null(rcityviews:::city_themes(name = name))) {
        invisible(auto_yes_city_themes(name = name, theme = theme, force = TRUE, remove = FALSE))
      } else {
        message("Theme ", name, " already registered.")
      }
    } else {
      if (!is.null(rcityviews:::city_themes(name = name))) {
        invisible(auto_yes_city_themes(name = name, theme = theme, force = TRUE, remove = TRUE))
      } else {
        message("Theme ", name, " already unregistered.")
      }
    }
  }
  
  # Apply the manage function to each theme in .themes and suppress output
  invisible(lapply(themes, manage))
  
  # Optional: Final confirmation message
  message("Theme management completed.")
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
}
