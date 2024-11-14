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
  font_dir <- system.file("fonts", package = "rcityviewsExtra")  # Find the fonts directory
  
  sysfonts::font_add_google("Caveat")
  sysfonts::font_add_google("Imbue")
  sysfonts::font_add_google("Damion")
  sysfonts::font_add_google("Oswald")
  sysfonts::font_add_google("Rampart One")
  sysfonts::font_add_google("Fredericka the Great")
  sysfonts::font_add_google("Dancing Script")
  sysfonts::font_add_google("Walter Turncoat")
  sysfonts::font_add_google("Ubuntu")

  if (font_dir != "") {
    # List all .ttf files in the font directory
    ttf_files <- list.files(font_dir, pattern = "\\.ttf$", full.names = TRUE)
    
    # Loop over each .ttf file and add it as a font
    for (ttf_file in ttf_files) {
      font_name <- basename(tools::file_path_sans_ext(basename(ttf_file)))  # Get font name from file name without extension
      sysfonts::font_add(family = font_name, regular = ttf_file)
    }
    
    showtext::showtext_auto()  # Enable showtext for font rendering in plots
  }
}


