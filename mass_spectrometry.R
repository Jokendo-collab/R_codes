#Setup
# The following packages should be installed as they will be used throughout this pipeline
#library("mzR")
#library("mzID")
#library("MSnID")
#library("MSnbase")
#library("rpx")
#library("MLInterfaces")
#library("pRoloc")
#library("pRolocdata")
#library("MSGFplus")
#library("rols")
#library("hpar")
install.packages("devtools")
library(devtools)

install_github("Bioconductor/BiocManager")

#The best way to install all these pakages is to use the following code
install.packages("BiocManager",dependencies = T)
library("BiocManager")
BiocManager::install("RforProteomics", dependencies = TRUE)

#Exploring the available infrustructure
library("RforProteomics")

setwd("M:/2018/TB/Javan/mzML_BAL_samples")
file_path <- "M:/2018/TB/Javan/mzML_BAL_samples/mzml_files/t75" # the full path to the MS files
files <- list.files(file_path, pattern = "mzML", recursive = TRUE,full.names = T) # Listing the ms files in the data
files
ms <- openMSfile(files) #Extract data
hd <- header(ms) #The header function returns the metadata of all available peaks
dim(hd) #shows the number of scans
names(hd) #Show the metadata names
#We can extract metadata and scan data for scan 1000 as follows
hd[1000, ]
# the number of scans are 58917
head(peaks(ms, 1000)) #shows the first 6 peaks information in the peak list
plot(peaks(ms, 59681), type = "h") #plot the spectrum peaks

#======================================================================================
file_path_2 <- "M:/2018/TB/Javan/mzML_BAL_samples/mzml_files/t49" # the full path to the MS files
files_2 <- list.files(file_path_2, pattern = "mzML", recursive = TRUE,full.names = T) # Listing the ms files in the data
files_2
ms_2 <- openMSfile(files_2) #Extract data
hd_2 <- header(ms_2) #The header function returns the metadata of all available peaks
dim(hd_2) #shows the number of scans
names(hd_2) #Show the metadata names
hd_2[1000, ]
# the number of scans are 58917
head(peaks(ms_2, 1000)) #shows the first 6 peaks information in the peak list
plot(peaks(ms_2, 60000), type = "h") #plot the spectrum peaks

id1 <- openIDfile(files_2)

id1 <- mzR::psms(ms_2)

#======================================================================================

ms1 <- which(hd$msLevel == 1)
rtsel <- hd$retentionTime[ms1] / 60 > 1 &
  hd$retentionTime[ms1] / 60 < 1.5

## the map
M <- MSmap(ms, ms1[rtsel], 521, 523, .005, hd)

plot(M, aspect = 1, allTicks = F)

plot3D(M)


i <- ms1[which(rtsel)][1]
j <- ms1[which(rtsel)][2]
M2 <- MSmap(ms, i:j, 100, 1000, 1, hd)
plot3D(M2)






























