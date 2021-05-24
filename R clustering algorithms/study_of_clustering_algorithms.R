#study of clustering algorithms 
#link https://www.datanovia.com/en/blog/types-of-clustering-methods-overview-and-quick-start-r-code/
#TYPES OF CLUSTERING METHODS: OVERVIEW AND QUICK START R CODE
#install.packages("factoextra")
#install.packages("cluster")
#install.packages("magrittr")

library("cluster")
library("factoextra")
library("magrittr")
setwd("~/R clustering algorithms")
df1 = read.delim("close/close.evec", header = TRUE, sep = "\t")
df2 = read.delim("close/closeinfofile.txt", header = TRUE, sep = "\t")
df <- merge(df1,df2,by="hgdp_id")
df
class <- df$Geographic.origin
table(class)
my_data <- df[2:4]
res.dist <- get_dist(my_data, stand = TRUE, method = "pearson")

fviz_dist(res.dist, 
          gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
#Partitioning clustering
#Partitioning algorithms are clustering techniques that subdivide the data sets into a set of k groups,
#where k is the number of groups pre-specified by the analyst.
#popular one K -means
#alternative: k-medioid or PAM ==> which is less sensitive to outliers compared to k-means.
#Determining the optimal number of clusters: use factoextra::fviz_nbclust()

#library("factoextra")
fviz_nbclust(my_data, kmeans, method = "gap_stat")
#suggested number of cluster 4 in our hgdp distant dataset usign 3 PCs

#Compute and visualize k-means clustering

set.seed(123)
km.res <- kmeans(my_data, 5, nstart = 25)
# Visualize
#library("factoextra")
fviz_cluster(km.res, data = my_data,
             ellipse.type = "convex",
             palette = "jco",
             ggtheme = theme_minimal())


#Similarly, the k-medoids/pam clustering can be computed as follow:

# Compute PAM
#library("cluster")
pam.res <- pam(my_data, 2)
# Visualize
fviz_cluster(pam.res)
results <- pam.res
results
cluster <- data.frame(unlist(results[3]))
cluster
df$cluster <- 1
df$cluster <- cluster[, 1]
df
table(class, df$cluster)


require(dplyr)
df3 <- select(df, hgdp_id, Origin, Geographic.origin, cluster)
df3
write.table(df3, file = "C:/Users/suraj/OneDrive/Documents/Thesis/distruct1.1/close/pam_2_clus_result.txt",  sep = "\t",
            row.names = FALSE, col.names = TRUE)



#Hierarchical clustering
#Hierarchical clustering is an alternative approach to partitioning clustering for identifying groups in the dataset. 
#It does not require to pre-specify the number of clusters to be generated.

# Compute hierarchical clustering
# HERE %>%(pipe)is The infix operator %>%, is not part of base R, but is in fact defined by the package magrittr (CRAN).
res.hc <- my_data %>%
  scale() %>%                    # Scale the data
  dist(method = "euclidean") %>% # Compute dissimilarity matrix
  hclust(method = "ward.D2")     # Compute hierachical clustering
#https://www.datacamp.com/community/tutorials/hierarchical-clustering-R for better understanding of hclust
# Visualize using factoextra
# Cut in 4 groups and color by groups
fviz_dend(res.hc, k = 2, # Cut in four groups
          cex = 0.5, # label size
          k_colors = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
          color_labels_by_k = TRUE, # color labels by groups
          rect = TRUE # Add rectangle around groups
)

#working properly on my computer but takes time to display
cut_avg <- cutree(res.hc, k = 2) 
#now finding out respective cluster in our dataset
library(dplyr)
df_cl <- mutate(df, cluster1 = cut_avg)
count(df_cl,cluster1)
head(my_data)
df_cl
cluster1
table(class, df_cl$cluster1)

df4 <- select(df_cl, hgdp_id, Origin, Geographic.origin, cluster1)
df4
write.table(df4, file = "C:/Users/suraj/OneDrive/Documents/Thesis/distruct1.1/close/hclust_2_clus_result.txt",  sep = "\t",
            row.names = FALSE, col.names = TRUE)

#Clustering validation and evaluation
#Assessing clustering tendency
#Hopkins statistic: If the value of Hopkins statistic is close to 1 (far above 0.5), 
#then we can conclude that the dataset is significantly clusterable.
#Visual approach: The visual approach detects the clustering tendency by counting 
#the number of square shaped dark (or colored) blocks along the diagonal in the ordered dissimilarity image.

gradient.color <- list(low = "steelblue",  high = "white")

df[2:4] %>%    # data
  scale() %>%     # Scale variables
  get_clust_tendency(n = 50, gradient = gradient.color)
#Determining the optimal number of clusters
#in the R code below, we'll use the NbClust R package, which provides 30 indices for determining the
#best number of clusters. First, install it using 
#install.packages("NbClust")
#, then type this:
set.seed(123)

# Compute
#https://www.rdocumentation.org/packages/NbClust/versions/3.0/topics/NbClust for more details
library("NbClust")
res.nbclust <- df[2:4] %>%
  scale() %>%
  NbClust(distance = "euclidean",
          min.nc = 2, max.nc = 15, 
          method = "ward.D2", index ="all") 
# Visualize
library(factoextra)
fviz_nbclust(res.nbclust, ggtheme = theme_minimal())

#Clustering validation statistics
# variety of measures has been proposed in the literature for evaluating clustering results.
#The term clustering validation is used to design the procedure of evaluating the results of a clustering algorithm.
#n the following R code, we'll compute and evaluate the result of hierarchical clustering methods.
#Compute and visualize hierarchical clustering:
set.seed(123)
# Enhanced hierarchical clustering, cut in 3 groups
res.hc <- df[2:4]%>%
  scale() %>%
  eclust("hclust", k = 3, graph = FALSE)

# Visualize with factoextra
fviz_dend(res.hc, palette = "jco",
          rect = TRUE, show_labels = FALSE)

#Inspect the silhouette plot:
fviz_silhouette(res.hc)

#Which samples have negative silhouette? To what cluster are they closer?
# Silhouette width of observations
sil <- res.hc$silinfo$widths[, 1:3]

# Objects with negative silhouette
neg_sil_index <- which(sil[, 'sil_width'] < 0)
sil[neg_sil_index, , drop = FALSE]
