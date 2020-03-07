#Before creation

install.packages(c("devtools", "roxygen2", "usethis"))
install.packages("available",dependencies = T)
library(devtools)
library(roxygen2)
library(usethis)
library(available)

setwd("/home/javan/Desktop/PxGxIntegrate")
#Check if the package is already available in CRAN


available("PxGxIntegrate")


#Creating minimal functional package

create_package("~/Desktop/PxGx")

create_package("PxGx")


#================================================================================
library("RforProteomics")
# load libraries
library("tidyverse")
library("psych")
library("gridExtra")
library("scales")
library("limma") 
library("edgeR") 

install.packages("tibble",dependencies = T)

BiocManager::install("IlluminaHumanMethylationEPICmanifest")
BiocManager::install("IlluminaHumanMethylationEPICanno.ilm10b4.hg19")





























