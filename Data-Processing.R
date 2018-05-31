# Get API credentials
spotifyKey <- "Your Own Key"
spotifySecret <- "Your Own ID"

# Request an access token in order to authorise my app to retrieve and manage Spotify data
library(Rspotify)
library(httr)
library(jsonlite)

spotifyEndpoint <- oauth_endpoint(NULL, "https://accounts.spotify.com/authorize", "https://accounts.spotify.com/api/token")
spotifyToken <- spotifyOAuth("Spotify Analysis", spotifyKey, spotifySecret)

# 'This Is' Playlist Series
library(readr)
playlistURI <- read.csv("this-is-playlist-URI.csv", header = T, sep = ";")

# Empty dataframe
PlaylistSongs <- data.frame(PlaylistID = character(), Musician = character(), tracks = character(),
                            id = character(), popularity = integer(), artist = character(),
                            artistId = character(), album = character(), albumId = character(),
                            stringsAsFactors=FALSE)

# Getting each playlist
for (i in 1:nrow(playlistURI)) {
  i <- cbind(PlaylistID = as.factor(playlistURI[i,2]),
             Musician = as.factor(playlistURI[i,1]),
             getPlaylistSongs("spotify",
                              playlistid = as.factor(playlistURI[i,2]),
                              token=spotifyToken))
  PlaylistSongs <- rbind(PlaylistSongs, i)
}

# Taylor Swift and Ariana Grande glimpse
library(knitr)
library(kableExtra)
library(dplyr)
options(knitr.table.format = "html")
options(width = 12)

kable(head(PlaylistSongs,86)) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"), font_size = 12) %>%
  scroll_box(width = "1000px", height = "750px")

# Extract audio Features for any specific ID stored as a vector.
getFeatures <- function (vector_id, token) 
{
  link <- httr::GET(paste0("https://api.spotify.com/v1/audio-features/?ids=", 
                           vector_id), httr::config(token = token))
  list <- httr::content(link)
  return(list)
}

# Extracts audio features for the track ID’s vector and returns them in a dataframe.
get_features <- function (x) 
{
  getFeatures2 <- getFeatures(vector_id = x, token = spotifyToken)
  features_output <- do.call(rbind, lapply(getFeatures2$audio_features, data.frame, stringsAsFactors=FALSE))
}

# Create a vector with track IDs for each musician
TaylorSwift_vc <- paste(as.character(PlaylistSongs$id[1:38]), sep="", collapse=",")
ArianaGrande_vc <- paste(as.character(PlaylistSongs$id[39:86]), sep="", collapse=",")
KendrickLamar_vc <- paste(as.character(PlaylistSongs$id[87:124]), sep="", collapse=",")
ShawnMendes_vc <- paste(as.character(PlaylistSongs$id[125:177]), sep="", collapse=",")
Maroon5_vc <- paste(as.character(PlaylistSongs$id[178:226]), sep="", collapse=",")
PostMalone_vc <- paste(as.character(PlaylistSongs$id[227:261]), sep="", collapse=",")
Kygo_vc <- paste(as.character(PlaylistSongs$id[262:299]), sep="", collapse=",")
TheChainsmokers_vc <- paste(as.character(PlaylistSongs$id[300:333]), sep="", collapse=",")
Adele_vc <- paste(as.character(PlaylistSongs$id[334:358]), sep="", collapse=",")
Drake_vc <- paste(as.character(PlaylistSongs$id[359:408]), sep="", collapse=",")
JustinBieber_vc <- paste(as.character(PlaylistSongs$id[409:457]), sep="", collapse=",")
Coldplay_vc <- paste(as.character(PlaylistSongs$id[458:494]), sep="",collapse=",")
KanyeWest_vc <- paste(as.character(PlaylistSongs$id[495:545]), sep="", collapse=",")
BrunoMars_vc <- paste(as.character(PlaylistSongs$id[546:584]), sep="", collapse=",")
EdSheeran_vc <- paste(as.character(PlaylistSongs$id[585:624]), sep="", collapse=",")
Eminem_vc <- paste(as.character(PlaylistSongs$id[625:679]), sep="", collapse=",")
Beyonce_vc <- paste(as.character(PlaylistSongs$id[680:711]), sep="", collapse=",")
Avicii_vc <- paste(as.character(PlaylistSongs$id[712:770]), sep="", collapse=",")
Marshmello_vc <- paste(as.character(PlaylistSongs$id[771:808]), sep="", collapse=",")
CalvinHarris_vc <- paste(as.character(PlaylistSongs$id[809:846]), sep="", collapse=",")
JustinTimberlake_vc <- paste(as.character(PlaylistSongs$id[847:912]), sep="", collapse=",")
FrankSinatra_vc <- paste(as.character(PlaylistSongs$id[913:962]), sep="", collapse=",")
CharliePuth_vc <- paste(as.character(PlaylistSongs$id[963:993]), sep="", collapse=",")
MichaelBuble_vc <- paste(as.character(PlaylistSongs$id[994:1035]), sep="", collapse=",")
MartinGarrix_vc <- paste(as.character(PlaylistSongs$id[1036:1084]), sep="", collapse=",")
EnriqueIglesias_vc <- paste(as.character(PlaylistSongs$id[1085:1125]), sep="", collapse=",")
JohnMayer_vc <- paste(as.character(PlaylistSongs$id[1126:1184]), sep="", collapse=",")
Future_vc <- paste(as.character(PlaylistSongs$id[1185:1224]), sep="", collapse=",")
EltonJohn_vc <- paste(as.character(PlaylistSongs$id[1225:1265]), sep="", collapse=",")
FiftyCent_vc <- paste(as.character(PlaylistSongs$id[1266:1315]), sep="", collapse=",")
Lorde_vc <- paste(as.character(PlaylistSongs$id[1316:1346]), sep="", collapse=",")
LilWayne_vc <- paste(as.character(PlaylistSongs$id[1347:1396]), sep="", collapse=",")
WizKhalifa_vc <- paste(as.character(PlaylistSongs$id[1397:1446]), sep="", collapse=",")
FifthHarmony_vc <- paste(as.character(PlaylistSongs$id[1447:1479]), sep="", collapse=",")
LanaDelRay_vc <- paste(as.character(PlaylistSongs$id[1480:1524]), sep="",collapse=",")
NorahJones_vc <- paste(as.character(PlaylistSongs$id[1525:1562]), sep="", collapse=",")
JamesArthur_vc <- paste(as.character(PlaylistSongs$id[1563:1581]), sep="", collapse=",")
OneRepublic_vc <- paste(as.character(PlaylistSongs$id[1582:1614]), sep="", collapse=",")
TheScript_vc <- paste(as.character(PlaylistSongs$id[1615:1658]), sep="", collapse=",")
StevieWonder_vc <- paste(as.character(PlaylistSongs$id[1659:1708]), sep="", collapse=",")
JasonMraz_vc <- paste(as.character(PlaylistSongs$id[1709:1758]), sep="", collapse=",")
JohnLegend_vc <- paste(as.character(PlaylistSongs$id[1759:1795]), sep="", collapse=",")
Pentatonix_vc <- paste(as.character(PlaylistSongs$id[1796:1834]), sep="", collapse=",")
AliciaKeys_vc <- paste(as.character(PlaylistSongs$id[1835:1884]), sep="", collapse=",")
Usher_vc <- paste(as.character(PlaylistSongs$id[1885:1934]), sep="", collapse=",")
SnoopDogg_vc <- paste(as.character(PlaylistSongs$id[1935:1984]), sep="", collapse=",")
Macklemore_vc <- paste(as.character(PlaylistSongs$id[1985:2007]), sep="",collapse=",")
ZaraLarsson_vc <- paste(as.character(PlaylistSongs$id[2008:2043]), sep="", collapse=",")
JayZ_vc <- paste(as.character(PlaylistSongs$id[2044:2093]), sep="", collapse=",")
Rihanna_vc <- paste(as.character(PlaylistSongs$id[2094:2129]), sep="", collapse=",")

# Obtain the audio features for each musician
TaylorSwift <- get_features(TaylorSwift_vc)
ArianaGrande <- get_features(ArianaGrande_vc)
KendrickLamar <- get_features(KendrickLamar_vc)
ShawnMendes <- get_features(ShawnMendes_vc)
Maroon5 <- get_features(Maroon5_vc)
PostMalone <- get_features(PostMalone_vc)
Kygo <- get_features(Kygo_vc)
TheChainsmokers <- get_features(TheChainsmokers_vc)
Adele <- get_features(Adele_vc)
Drake <- get_features(Drake_vc)
JustinBieber <- get_features(JustinBieber_vc)
Coldplay <- get_features(Coldplay_vc)
KanyeWest <- get_features(KanyeWest_vc)
BrunoMars <- get_features(BrunoMars_vc)
EdSheeran <- get_features(EdSheeran_vc)
Eminem <- get_features(Eminem_vc)
Beyonce <- get_features(Beyonce_vc)
Avicii <- get_features(Avicii_vc)
Marshmello <- get_features(Marshmello_vc)
CalvinHarris <- get_features(CalvinHarris_vc)
JustinTimberlake <- get_features(JustinTimberlake_vc)
FrankSinatra <- get_features(FrankSinatra_vc)
CharliePuth <- get_features(CharliePuth_vc)
MichaelBuble <- get_features(MichaelBuble_vc)
MartinGarrix <- get_features(MartinGarrix_vc)
EnriqueIglesias <- get_features(EnriqueIglesias_vc)
JohnMayer <- get_features(JohnMayer_vc)
Future <- get_features(Future_vc)
EltonJohn <- get_features(EltonJohn_vc)
FiftyCent <- get_features(FiftyCent_vc)
Lorde <- get_features(Lorde_vc)
LilWayne <- get_features(LilWayne_vc)
WizKhalifa <- get_features(WizKhalifa_vc)
FifthHarmony <- get_features(FifthHarmony_vc)
LanaDelRay <- get_features(LanaDelRay_vc)
NorahJones <- get_features(NorahJones_vc)
JamesArthur <- get_features(JamesArthur_vc)
OneRepublic <- get_features(OneRepublic_vc)
TheScript <- get_features(TheScript_vc)
StevieWonder <- get_features(StevieWonder_vc)
JasonMraz <- get_features(JasonMraz_vc)
JohnLegend <- get_features(JohnLegend_vc)
Pentatonix <- get_features(Pentatonix_vc)
AliciaKeys <- get_features(AliciaKeys_vc)
Usher <- get_features(Usher_vc)
SnoopDogg <- get_features(SnoopDogg_vc)
Macklemore <- get_features(Macklemore_vc)
ZaraLarsson <- get_features(ZaraLarsson_vc)
JayZ <- get_features(JayZ_vc)
Rihanna <- get_features(Rihanna_vc)

# Merge each musician´s audio features dataframe into a new one
library(gdata)
all_features <- combine(TaylorSwift,ArianaGrande,KendrickLamar,ShawnMendes,Maroon5,PostMalone,Kygo,TheChainsmokers,Adele,Drake,
                        JustinBieber,Coldplay,KanyeWest,BrunoMars,EdSheeran,Eminem,Beyonce,Avicii,Marshmello,CalvinHarris,
                        JustinTimberlake,FrankSinatra,CharliePuth,MichaelBuble,MartinGarrix,EnriqueIglesias,JohnMayer,Future,EltonJohn,FiftyCent,
                        Lorde,LilWayne,WizKhalifa,FifthHarmony,LanaDelRay,NorahJones,JamesArthur,OneRepublic,TheScript,StevieWonder,
                        JasonMraz,JohnLegend,Pentatonix,AliciaKeys,Usher,SnoopDogg,Macklemore,ZaraLarsson,JayZ,Rihanna)

# Audio features for each musician as the mean of the tracks in their respective playlists
mean_features <- aggregate(all_features[, c(1:11,17)], list(all_features$source), mean)
names(mean_features) <- c("Musician", "danceability", "energy", "key", "loudness", "mode", "speechiness", 
                          "acousticness", "instrumentalness", "liveness", "valence", "tempo", "duration_ms")