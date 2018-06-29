# Spotify Artists Analysis

The purpose of this project is to analyze how different or how similar is the music that different artists on Spotify produce. The focus will be placed on disentangling the musical taste of 50 different artists from a wide range of genres. Throughout the process, I also identify different clusters of artists that share a similar musical style.

For the study, I will access the [Spotify Web API](https://beta.developer.spotify.com/web-api/), which provides data from the Spotify music catalog and can be accesed via standard HTTPS requests to an API endpoint. The Spotify API provides, among other things, track information for each song, including audio statistics such as *danceability*, *instrumentalness* or *temp*. I will focus on retrieving this audio feature information from 50 different 'This Is' Playlists of 50 different artists . Each feature measures an aspect of a song. Detailed information on how each feature is calculated can be found in the Spotify API Website.

An accompanied Medium blog post has been written up and can be viewed here: [Spotify's "This Is" Playlists: The Ultimate Song Analysis for 50 Mainstream Artists](https://medium.freecodecamp.org/spotifys-this-is-playlists-the-ultimate-song-analysis-for-50-mainstream-artists-491882081819)

![spotify-image](spotify-image.jpg)

## Documents

Here are the different files in the project:

* [This Is Playlist URI](https://github.com/khanhnamle1994/spotify-artists-analysis/blob/master/this-is-playlist-URI.csv): The initial .csv file with artists and playlist URI I prepared for this project.
* [Spotify Artists Analysis](https://github.com/khanhnamle1994/spotify-artists-analysis/blob/master/Spotify-Artists-Analysis.Rmd): The complete R Markdown that details my whole process throughout this project.
* [Data Processing](https://github.com/khanhnamle1994/spotify-artists-analysis/blob/master/Data-Processing.R): The R code I did for getting the data.
* [Data Visualization](https://github.com/khanhnamle1994/spotify-artists-analysis/blob/master/Data-Visualization.R): The R code I did for visualizing the data.

## Requirements

* [RStudio](https://www.rstudio.com/) (get the latest version)

## Libraries

Here are the R packages I used for the project:

* [Rspotify](https://github.com/tiagomendesdantas/Rspotify)
* [httr](https://cran.r-project.org/web/packages/httr/index.html)
* [jsonlite](https://cran.r-project.org/web/packages/jsonlite/index.html)
* [readr](https://cran.r-project.org/web/packages/readr/index.html)
* [knitr](https://cran.r-project.org/web/packages/knitr/index.html)
* [kableExtra](https://cran.r-project.org/web/packages/kableExtra/index.html)
* [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html)
* [gdata](https://cran.r-project.org/web/packages/gdata/index.html)
* [radarchart](https://cran.r-project.org/web/packages/radarchart/index.html)
* [tidyr](https://cran.r-project.org/web/packages/tidyr/index.html)
* [ggfortify](https://cran.r-project.org/web/packages/ggfortify/index.html)
* [ggthemes](https://cran.r-project.org/web/packages/ggthemes/index.html)
* [stringr](https://cran.r-project.org/web/packages/stringr/index.html)
* [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)

## License

MIT. See the LICENSE file for the copyright notice.
