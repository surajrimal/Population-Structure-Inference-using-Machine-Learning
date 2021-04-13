install.packages('svcR', dependencies = TRUE, repos='https://cran.r-project.org/')
require("svcR")
data("iris")
retA <- findSvcModel(iris, MetOpt = "optimStoch", MetLab = "gridLabeling",
                     +     KernChoice = "KernGaussian", Nu = 0.5, q = 40, K = 1, G = 5,
                     +     Cx = 0, Cy = 0)

plot(retA)
ExportClusters(retA, "iris")
findSvcModel.summary(retA)

