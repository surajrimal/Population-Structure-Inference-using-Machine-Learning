data(diabetes)
class <- diabetes$class
table(class)

X <- diabetes[,-1]
head(X)

clPairs(X, class)
#Pairwise Scatter Plots showing Classification

BIC <- mclustBIC(X)
plot(BIC)
summary(BIC)
mod1 <- Mclust(X, x = BIC)
summary(mod1, parameters = TRUE)
plot(mod1, what = "classification")

table(class, mod1$classification)
