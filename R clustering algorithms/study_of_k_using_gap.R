# A study on number of K using Gap statistic and hartigan rule

#https://blog.dominodatalab.com/clustering-in-r/
setwd("~/R clustering algorithms")
df = read.delim("dataset/example1.evec", header = TRUE, sep = "\t")
df
class <- df$Origin
table(class)
X <- df[2:4]
head(X)
mydata <- X

set.seed(278613)
dataK4 <- kmeans(X, centers=3)
dataK4

#Plotting the result of K-means clustering can be difficult because of the high dimensional nature of the data.
#To overcome this, the plot.kmeans function in useful performs multidimensional scaling to project the data into
#two dimensions and then color codes the points according to cluster membership.
library(useful)
plot(dataK4, data=X)


plot(dataK4, data=df, class="Origin")


#K-means can be subject to random starting conditions,
#so it is considered good practice to run it with a number of random starts. This is accomplished with the nstart argument.
set.seed(278613)
datak4N25 <- kmeans(X, iter.max = 14, centers=3, nstart=25) 
# see the cluster sizes with 1 start
dataK4$size
# see the cluster sizes with 25 starts 
datak4N25$size


#choosing the right number of K
#It essentially compares the ratio of the within-cluster sum of squares for a clustering with k clusters
#and one with k + 1 clusters, accounting for the number of rows and clusters. If that number is greater than 10, 
#then it is worth using k + 1 clusters.

dataBest <- FitKMeans(X, max.clusters=20, nstart=25, seed=278613) 
dataBest
PlotHartigan(dataBest)

table(df$Origin, datak4N25$cluster)
plot(table(df$Origin, datak4N25$cluster),
          main="Confusion Matrix for data Clustering",
          xlab="Origin", ylab="Cluster")