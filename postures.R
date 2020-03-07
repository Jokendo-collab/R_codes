# devtools::install_github("bartongroup/proteusLabelFree")
# devtools::install_github("bartongroup/proteusTMT")
# devtools::install_github("bartongroup/proteusSILAC")
devtools::install_github("bartongroup/Proteus", build_opts= c("--no-resave-data", "--no-manual"), build_vignettes=TRUE,force = T)

library(devtools)
library(limma)
library(proteus)

vignette("proteus", package="proteus")
