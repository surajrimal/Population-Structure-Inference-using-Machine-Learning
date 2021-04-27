#https://www.statmethods.net/advstats/cluster.html
setwd("~/R clustering algorithms")
df = read.delim("dataset4.evec", header = TRUE, sep = "\t")
df
class <- df$Origin
table(class)
X <- df[2:16]
head(X)
mydata <- X
#partitioning k means
# Determine number of clusters
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")


# K-Means Cluster Analysis
fit <- kmeans(mydata, 4) # 5 cluster solution
# get cluster means
aggregate(mydata,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(mydata, fit$cluster)

#A robust version of K-means based on mediods can be invoked by using pam( ) instead of kmeans( ).
#The function pamk( ) in the fpc package is a wrapper for pam that also prints the suggested number of clusters 
#based on optimum average silhouette width.
library(fpc)
options(digits=3)
set.seed(20000)
pk1 <- pamk(mydata,krange=1:15,criterion="asw",critout=TRUE)
pk2 <- pamk(mydata,krange=1:15,criterion="multiasw",ns=2, usepam=FALSE, critout=TRUE)
# "multiasw" is better for larger data sets, use larger ns then.
pk3 <- pamk(mydata,krange=1:15,criterion="ch",critout=TRUE)


#Hierarchical Agglomerative

# Ward Hierarchical Clustering
d <- dist(mydata, method = "euclidean") # distance matrix
fit <- hclust(d, method="ward")
plot(fit) # display dendogram
groups <- cutree(fit, k=5) # cut tree into 5 clusters
# draw dendogram with red borders around the 5 clusters
rect.hclust(fit, k=5, border="red")

# Ward Hierarchical Clustering with Bootstrapped p values
library(pvclust)
fit <- pvclust(mydata, method.hclust="ward",
               method.dist="euclidean")
plot(fit) # dendogram with p values
#Clusters that are highly supported by the data will have large p values. 
# add rectangles around groups highly supported by the data
pvrect(fit, alpha=.95)


# Model Based Clustering
#Model based approaches assume a variety of data models and apply maximum likelihood 
#estimation and Bayes criteria to identify the most likely model and number of clusters.
library(mclust)
fit <- Mclust(mydata)
plot(fit) # plot results
summary(fit) # display the best model



#Plotting Cluster Solutions
# K-Means Clustering with 5 clusters
fit <- kmeans(mydata, 3)

# Cluster Plot against 1st 2 principal components

# vary parameters for most readable graph
library(cluster)
clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE,
         labels=2, lines=0)

# Centroid Plot against 1st 2 discriminant functions
library(fpc)
plotcluster(mydata, fit$cluster)

#Validating cluster solutions
# comparing 2 cluster solutions
library(fpc)
fit1 <- kmeans(mydata, 3)
fit2 <- kmeans(mydata, 4)
cluster.stats(d, fit1$cluster, fit2$cluster)
