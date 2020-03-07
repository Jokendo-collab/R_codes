
setwd("/home/javan/Desktop/zandi_javan/full_lfqcluster/result")
install.packages("ggbiplot")
library(ggfortify)
library(ggbiplot)
library(devtools)

install_github("vqv/ggbiplot")

features <- read.table("features_msgf.txt", header = T, sep = "\t", row.names = 1, fill = T)
features
features[is.na(features)] <- 0
features
fit <- prcomp(features)
fit

autoplot(prcomp(features))
spectral_PCA<-princomp(features)

plot(spectral_PCA,col="red",las=1.5)

plot(fit$rotation[, "PC1"], fit$rotation[, "PC2"])


plot(fit,col="red",las=1.5)
patient.groups <- c(rep("LTBI", 9), rep("RecTB",9),rep("PrevTB",9))
ggbiplot(spectral_PCA,ellipse=TRUE, groups=patient.groups )
ggbiplot(spectral_PCA)















