suppressMessages(suppressWarnings(library(lattice)))
suppressMessages(suppressWarnings(library(latticeExtra)))

set.seed(1)
df = read.delim("example1.evec", header = TRUE, sep = "\t")
df
newdf <- df
newdf$Origin <- NULL
newdf$X.eigvals.<- NULL
names(df)
results <- 
  kmeans(newdf, 3, iter.max = 100, nstart = 1, algorithm = "Hartigan-Wong")
results
cluster <- data.frame(unlist(results[1]))
newdf$cluster <- cluster[, 1]
A <- xyplot(X6.366 ~ X4.844, group = cluster, data = newdf, auto.key 
            = list(space = "right"), par.settings = list(superpose.symbol = 
                                                           list(pch = 0, cex = 1)))
B <- xyplot(X6.366 ~ X4.844, group = Origin, data = df, auto.key = 
              list(space = "rigth"), par.settings = list(superpose.symbol = 
                                                           list(pch = 1, cex = 2)), xlab 
            = "Sepal Length", ylab = "Sepal Width", main = "KMeans clustering on Iris")
C <- xyplot(results$centers[,c("X6.366")] ~ results$centers[,c("X4.844")], 
            pch = "@", cex = 2, auto.key = list(space = "right"))
D <- B + as.layer(A + C)
df$cluster <- cluster[, 1]
df


require(dplyr)
df2 <- select(df, X.eigvals., Origin, cluster)
df2
write.table(df2, file = "newfile.txt",  sep = "\t",
            row.names = FALSE, col.names = TRUE)
