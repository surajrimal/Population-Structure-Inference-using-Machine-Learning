df = read.delim("example1.evec", header = TRUE, sep = "\t")
class <- df$Origin
table(class)

X <- df[2:16]
head(X)

clPairs(X, class)

BIC <- mclustBIC(X)
plot(BIC)
summary(BIC)
mod1 <- Mclust(X, x = BIC)
summary(mod1, parameters = TRUE)
plot(mod1, what = "classification")

table(class, mod1$classification)
