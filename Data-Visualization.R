# Radar Chart

# Normalize Values to be from 0 to 1
mean_features_norm <- cbind(mean_features[1], apply(mean_features[-1],2, function(x){(x-min(x)) / diff(range(x))}))

# First Batch of Musicians
library(radarchart)
library(tidyr)
sample1 <- mean_features[mean_features$Musician %in% c("TaylorSwift", "ArianaGrande", "KendrickLamar", "ShawnMendes", "Maroon5", "PostMalone", "Kygo", "TheChainsmokers", "Adele", "Drake"),]

mean_features_norm_1 <- cbind(sample1[1], apply(sample1[-1],2, function(x){(x-min(x)) / diff(range(x))})) 

radarDF_1 <- gather(mean_features_norm_1, key=Attribute, value=Score, -Musician) %>%
  spread(key=Musician, value=Score)

chartJSRadar(scores = radarDF_1, scaleStartValue = -1, maxScale =1, showToolTipLabel = TRUE)

# Second Batch of Musicians
sample2 <- mean_features[mean_features$Musician %in% c("JustinBieber", "Coldplay", "KanyeWest", "BrunoMars", "EdSheeran", "Eminem", "Beyonce", "Avicii", "Marshmello", "CalvinHarris"),]

mean_features_norm_2 <- cbind(sample2[1], apply(sample2[-1],2,function(x){(x-min(x)) / diff(range(x))})) 

radarDF_2 <- gather(mean_features_norm_2, key=Attribute, value=Score, -Musician) %>%
  spread(key=Musician, value=Score)

chartJSRadar(scores = radarDF_2, scaleStartValue = -1, maxScale = 1, showToolTipLabel = TRUE)

# Third Batch of Musicians
sample3 <- mean_features[mean_features$Musician %in% c("JustinTimberlake", "FrankSinatra", "CharliePuth", "MichaelBuble", "MartinGarrix", "EnriqueIglesias", "JohnMayer", "Future", "EltonJohn", "FiftyCent"),]

mean_features_norm_3 <- cbind(sample3[1], apply(sample3[-1],2,function(x){(x-min(x)) / diff(range(x))})) 

radarDF_3 <- gather(mean_features_norm_3, key=Attribute, value=Score, -Musician) %>%
  spread(key=Musician, value=Score)

chartJSRadar(scores = radarDF_3, scaleStartValue = -1, maxScale = 1, showToolTipLabel = TRUE)

# Fourth Batch of Musicians
sample4 <- mean_features[mean_features$Musician %in% c("Lorde", "LilWayne", "WizKhalifa", "FifthHarmony", "LanaDelRay", "NorahJones", "JamesArthur", "OneRepublic", "TheScript", "StevieWonder"),]

mean_features_norm_4 <- cbind(sample4[1], apply(sample4[-1],2,function(x){(x-min(x)) / diff(range(x))})) 

radarDF_4 <- gather(mean_features_norm_4, key=Attribute, value=Score, -Musician) %>%
  spread(key=Musician, value=Score)

chartJSRadar(scores = radarDF_4, scaleStartValue = -1, maxScale = 1, showToolTipLabel = TRUE)

# Fifth Batch of Musicians
sample5 <- mean_features[mean_features$Musician %in% c("JasonMraz", "JohnLegend", "Pentatonix", "AliciaKeys", "Usher", "SnoopDogg", "Macklemore", "ZaraLarsson", "JayZ", "Rihanna"),]

mean_features_norm_5 <- cbind(sample5[1], apply(sample5[-1],2,function(x){(x-min(x)) / diff(range(x))})) 

radarDF_5 <- gather(mean_features_norm_5, key=Attribute, value=Score, -Musician) %>%
  spread(key=Musician, value=Score)

chartJSRadar(scores = radarDF_5, scaleStartValue = -1, maxScale = 1, showToolTipLabel = TRUE)

# Cluster Analysis

# Rescale numeric variables
scaled.features <- scale(mean_features[-1])
rownames(scaled.features) <- mean_features$Musician

# K-Means Clustering
library(ggfortify)
library(ggthemes)
set.seed(5000)

k_means <- kmeans(scaled.features, 6)

kmeans_plot <- autoplot(k_means, 
                        main = "K-means Clustering", 
                        data = scaled.features,
                        loadings = TRUE, 
                        loadings.colour = "#CC0000",
                        loadings.label.colour = "#CC0000", 
                        loadings.label = TRUE, 
                        loadings.label.size = 2.2,  
                        loadings.label.repel = T,
                        label.size = 2.2, 
                        label.repel = T) + 
  scale_fill_manual(values = c("#000066", "#9999CC", "#66CC99", "#FB7201", "#21CDFF", "#FF219C")) + 
  scale_color_manual(values = c("#000066", "#9999CC", "#66CC99", "#FB7201", "#21CDFF", "#FF219C")) + 
  theme(plot.title=element_text(size=18, face="bold"))

kmeans_plot

# Cluster Radar Chart
mean_features_norm_50 <- cbind(mean_features[1], apply(mean_features[-1],2,scale))

cluster_centers <- as.data.frame(k_means$centers)
cluster <- c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6")
cluster_centers <- cbind(cluster, cluster_centers)

radarDF_6 <- gather(cluster_centers, key=Attribute, value=Score, -cluster) %>%
  spread(key=cluster, value=Score)
# Change the colours according to clusters
colMatrix = matrix(c(c(4,24,102), c(135,133,193), c(87,196,135), c(251,114,1), c(33,205,255), c(255,33,156)), nrow = 3)
# Chart
chartJSRadar(scores = radarDF_6, scaleStartValue = -4, maxScale =1.5, showToolTipLabel = TRUE, colMatrix = colMatrix)

# Analysis by Features

library(stringr)
# Converting cluster to vector
clusters <- as.vector(k_means$cluster)
clusters <- str_replace_all(clusters, "1", "Cluster 1")
clusters <- str_replace_all(clusters, "2", "Cluster 2")
clusters <- str_replace_all(clusters, "3", "Cluster 3")
clusters <- str_replace_all(clusters, "4", "Cluster 4")
clusters <- str_replace_all(clusters, "5", "Cluster 5")
clusters <- str_replace_all(clusters, "6", "Cluster 6")
mean_features_norm_50 <- cbind(mean_features_norm_50, cluster = clusters)

# Danceability feature
library(ggplot2)
danceability_subset <- mean_features_norm_50[,c("Musician","danceability", "cluster")]
danceability_subset <- danceability_subset[order(danceability_subset$danceability, decreasing = TRUE), ]

danceability_plot <- ggplot(danceability_subset, 
                            aes(x = reorder(Musician, danceability), 
                                y = danceability, label = danceability)) + 
  xlab("Musician") + ylab("Danceability") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Danceability Feature") + coord_flip()

danceability_plot

# Energy feature
energy_subset <- mean_features_norm_50[,c("Musician","energy", "cluster")]
energy_subset <- energy_subset[order(energy_subset$energy, decreasing = TRUE), ]

energy_plot <- ggplot(energy_subset, 
                      aes(x = reorder(Musician, energy), 
                          y = energy, label = energy)) + 
  xlab("Musician") + ylab("energy") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Energy Feature") + coord_flip()

energy_plot

# Loudness feature
loudness_subset <- mean_features_norm_50[,c("Musician","loudness", "cluster")]
loudness_subset <- loudness_subset[order(loudness_subset$loudness, decreasing = TRUE), ]

loudness_plot <- ggplot(loudness_subset, 
                        aes(x = reorder(Musician, loudness), 
                            y = loudness, label = loudness)) + 
  xlab("Musician") + ylab("loudness") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Loudness Feature") + coord_flip()

loudness_plot

# Speechiness feature
speechiness_subset <- mean_features_norm_50[,c("Musician","speechiness", "cluster")]
speechiness_subset <- speechiness_subset[order(speechiness_subset$speechiness, decreasing = TRUE), ]

speechiness_plot <- ggplot(speechiness_subset, 
                           aes(x = reorder(Musician, speechiness), 
                               y = speechiness, label = speechiness)) + 
  xlab("Musician") + ylab("speechiness") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Speechiness Feature") + coord_flip()

speechiness_plot

# Acousticness feature
acousticness_subset <- mean_features_norm_50[,c("Musician","acousticness", "cluster")]
acousticness_subset <- acousticness_subset[order(acousticness_subset$acousticness, decreasing = TRUE), ]

acousticness_plot <- ggplot(acousticness_subset, 
                            aes(x = reorder(Musician, acousticness), 
                                y = acousticness, label = acousticness)) + 
  xlab("Musician") + ylab("acousticness") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Acousticness Feature") + coord_flip()

acousticness_plot

# Instrumentalness feature
instrumentalness_subset <- mean_features_norm_50[,c("Musician","instrumentalness", "cluster")]
instrumentalness_subset <- instrumentalness_subset[order(instrumentalness_subset$instrumentalness, decreasing = TRUE), ]

instrumentalness_plot <- ggplot(instrumentalness_subset, 
                                aes(x = reorder(Musician, instrumentalness), 
                                    y = instrumentalness, label = instrumentalness)) + 
  xlab("Musician") + ylab("instrumentalness") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Instrumentalness Feature") + coord_flip()

instrumentalness_plot

# Liveness feature
liveness_subset <- mean_features_norm_50[,c("Musician","liveness", "cluster")]
liveness_subset <- liveness_subset[order(liveness_subset$liveness, decreasing = TRUE), ]

liveness_plot <- ggplot(liveness_subset, 
                        aes(x = reorder(Musician, liveness), 
                            y = liveness, label = liveness)) + 
  xlab("Musician") + ylab("liveness") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Liveness Feature") + coord_flip()

liveness_plot

# Valence feature
valence_subset <- mean_features_norm_50[,c("Musician","valence", "cluster")]
valence_subset <- valence_subset[order(valence_subset$valence, decreasing = TRUE), ]

valence_plot <- ggplot(valence_subset, 
                       aes(x = reorder(Musician, valence), 
                           y = valence, label = valence)) + 
  xlab("Musician") + ylab("valence") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Valence Feature") + coord_flip()

valence_plot

# Tempo feature
tempo_subset <- mean_features_norm_50[,c("Musician","tempo", "cluster")]
tempo_subset <- tempo_subset[order(tempo_subset$tempo, decreasing = TRUE), ]

tempo_plot <- ggplot(tempo_subset, 
                     aes(x = reorder(Musician, tempo), 
                         y = tempo, label = tempo)) + 
  xlab("Musician") + ylab("tempo") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Tempo Feature") + coord_flip()

tempo_plot

# Duration feature
duration_subset <- mean_features_norm_50[,c("Musician","duration_ms", "cluster")]
duration_subset <- duration_subset[order(duration_subset$duration_ms, decreasing = TRUE), ]

duration_plot <- ggplot(duration_subset, 
                        aes(x = reorder(Musician, duration_ms), 
                            y = duration_ms, label = duration_ms)) + 
  xlab("Musician") + ylab("duration") + 
  geom_bar(stat = 'identity', aes(fill = cluster), width = .5) + 
  scale_fill_manual(name = "Cluster",
                    labels = c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5", "Cluster 6"), 
                    values = c("Cluster 1" = "#000066", 
                               "Cluster 2" = "#9999CC", 
                               "Cluster 3" = "#66CC99",
                               "Cluster 4" = "#FB7201",
                               "Cluster 5" = "#21CDFF",
                               "Cluster 6" = "#FF219C")) + 
  labs(title = "Duration Feature") + coord_flip()

duration_plot