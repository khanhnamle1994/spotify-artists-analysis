In this project, I attempted to answer the questions **"What makes a song popular on Spotify?"**.

I worked with 2 datasets downloaded from Kaggle:
* [Spotify's Worldwide Daily Song Ranking](https://www.kaggle.com/edumucelli/spotifys-worldwide-daily-song-ranking) (loaded in *daily-rankings.csv*)
* [Top Spotify Tracks of 2017](https://www.kaggle.com/nadintamer/top-tracks-of-2017) (loaded in *Spotify-Audio-Features.csv*)

The 1st dataset contains the daily ranking of the 200 most listened songs in 53 countries from 2017 and 2018 by Spotify users. It contains more than 2 million rows, which comprises 6629 artists, 18598 songs for a total count of one hundred five billion streams count. The data spans from 1st January 2017 to 9th January 2018 and will be kept up-to-date on following versions. It has been collected from [Spotify's regional chart data](https://spotifycharts.com/regional).

The 2nd dataset contains the audio features for Spotify's 100 top tracks of 2017. The audio features for each song were extracted using the Spotify Web API and the spotipy Python library. Credit goes to Spotify for calculating the audio feature values.
