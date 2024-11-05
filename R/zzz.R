# Copyright (C) 2024 Thomas Goossens

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

.onLoad <- function(libname, pkgname) {
  
  #wrapper that say yes to cityviews::citythem function
  city_themes_auto_yes <- function(name, theme = NULL, force = FALSE, remove = FALSE) {
    # Define a mock 'menu' function that always returns 1 (Yes)
    mock_menu <- function(choices, title, ...) {
      return(1)  # Automatically select "Yes"
    }
    
    # Stub the 'utils::menu' function within 'city_themes' to use 'mock_menu'
    mockery::stub(rcityviews:::city_themes, 'utils::menu', mock_menu)
    
    # Ensure that the stub is removed after execution to avoid side effects
    # on.exit({
    #   mockery::unstub(city_themes)
    # }, add = TRUE)
    
    # Call the original 'city_themes' function with provided arguments
    rcityviews:::city_themes(name, theme = theme, force = force, remove = remove)
  }
  
  
  # define the theme registering function
  register = function(name){
    theme = .themeOptions(name)
    
    # Add the custom theme to the cache without prompting
    city_themes_auto_yes(name = name, theme = theme, force = T)
  }
  
  themes <- .themes
  lapply(themes, register)
  
  
  # # Retreive the theme from the persistent cache (e.g., in a future R session)
  # city_themes(name = "blackyellow")
  # # Remove the theme from the persistent cache
  # city_themes(name = "blackyellow", remove = TRUE)
}

