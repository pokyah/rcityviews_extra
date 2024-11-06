#' Custom City View with Aspect Ratio and Orientation
#'
#' A wrapper function around `cityview()` that allows users to specify an aspect ratio based on common paper formats, orientation (portrait or landscape), and a custom rectangular border shape.
#'
#' @param name Character. The name of the city to be plotted.
#' @param country Character. The country where the city is located.
#' @param border Character. The border shape for the map. Options include `"square"` (default) and `"rectangle"`.
#' @param paper_format Character. The paper format to determine the aspect ratio. Supported formats include `"A4"`, `"A3"`, `"Letter"`, `"Legal"`, and `"Square"`.
#' @param orientation Character. The orientation of the paper format. Options are `"portrait"` (default) and `"landscape"`.
#' @param ... Additional arguments passed to `cityview()` from the `rcityviews` package.
#'
#' @return A ggplot object representing the map with the specified aspect ratio, orientation, and border.
#'
#' @details
#' This function modifies the aspect ratio of the map output based on the selected `paper_format` and `orientation`, keeping the plotted shapes centered. The `"rectangle"` border option produces a rectangular bounding box around the city, which can be oriented as either horizontal or vertical based on the `orientation` parameter.
#'
#' Supported paper formats and their aspect ratios:
#' - `"A4"`: 1 / sqrt(2)
#' - `"A3"`: 1 / sqrt(2)
#' - `"Letter"`: 1 / 1.294
#' - `"Legal"`: 1 / 1.647
#' - `"Square"`: 1
#'
#' @examples
#' # Plot a city view with A4 landscape orientation and rectangle border
#' map <- cityview_with_aspect_ratio(
#'   name = "Paris",
#'   country = "France",
#'   border = "rectangle",
#'   paper_format = "A4",
#'   orientation = "landscape",
#'   theme = "default"
#' )
#' print(map)
#'
#' @import ggplot2
#' @importFrom rcityviews cityview new_city
#' @export
cityview_with_aspect_ratio <- function(name, country, border = "square", paper_format = "A4", orientation = "portrait", ...) {
  # Define aspect ratios for standard paper formats
  paper_ratios <- list(
    "A4" = 1 / 1.414,
    "A3" = 1 / 1.414,
    "Letter" = 1 / 1.294,
    "Legal" = 1 / 1.647,
    "Square" = 1
  )
  
  # Validate paper format and orientation
  if (!paper_format %in% names(paper_ratios)) {
    stop("Unsupported paper format. Choose from: ", paste(names(paper_ratios), collapse = ", "))
  }
  if (!orientation %in% c("portrait", "landscape")) {
    stop("Unsupported orientation. Choose 'portrait' or 'landscape'.")
  }
  
  # Set the aspect ratio based on format and orientation
  aspect_ratio <- paper_ratios[[paper_format]]
  if (orientation == "landscape") {
    aspect_ratio <- 1 / aspect_ratio  # Invert ratio for landscape orientation
  }
  
  # Retrieve city coordinates
  city_data <- rcityviews::new_city(name = name, country = country)
  city_center <- c(long = city_data$long, lat = city_data$lat)
  
  # Adjust bounding box for rectangle border if specified
  bbox_offset <- 0.02  # Adjust this based on zoom level or desired bounding area
  if (border == "rectangle") {
    if (aspect_ratio > 1) {
      # Horizontal rectangle
      bbox <- c(
        xmin = city_center["long"] - bbox_offset * aspect_ratio,
        ymin = city_center["lat"] - bbox_offset,
        xmax = city_center["long"] + bbox_offset * aspect_ratio,
        ymax = city_center["lat"] + bbox_offset
      )
    } else {
      # Vertical rectangle
      bbox <- c(
        xmin = city_center["long"] - bbox_offset,
        ymin = city_center["lat"] - bbox_offset / aspect_ratio,
        xmax = city_center["long"] + bbox_offset,
        ymax = city_center["lat"] + bbox_offset / aspect_ratio
      )
    }
  } else {
    # Use a square or other default bounding box around the city center
    bbox <- c(
      xmin = city_center["long"] - bbox_offset,
      ymin = city_center["lat"] - bbox_offset,
      xmax = city_center["long"] + bbox_offset,
      ymax = city_center["lat"] + bbox_offset
    )
  }
  
  # Call the original cityview function with the custom bbox and border
  map_output <- rcityviews::cityview(name = name, country = country, border = border, bbox = bbox, ...)
  
  # Apply the aspect ratio to the ggplot object in map_output, centering as needed
  map_output <- map_output + ggplot2::coord_sf(expand = FALSE, ratio = aspect_ratio)
  
  return(map_output)
}
