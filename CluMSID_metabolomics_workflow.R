# Installing the packages
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("tdepke/CluMSIDdata", ref = "pkg")
devtools::install_github("tdepke/CluMSID", ref = "pkg")
install.packages("tidyverse",dependencies =T) 
#====================================================================================================

#Load the packages
library(CluMSID)
library(CluMSIDdata)
library(tidyverse)
#============================================================================================
setwd("/home/javan/Desktop/clumMSID") #Set working directory
?extractMS2spectra

ms2list <- extractMS2spectra("181005_WASH_181019192813.mzXML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25)) # Load MS2 list
length(ms2list) # Exract the spectrum list
head(ms2list,5)
showDefault(ms2list[[2]]) #show the molecules
#=================================================================================================

#Merge MS 2 spectra that derive from the same peak/feature
#To reduce the amount of redundant MS 2 spectra, the mergeMS2spectra() function is used to generate consensus
#spectra from the MS 2 spectra that derive from the same precursor. CluMSID offers two possibilities to do so:
#=========================================================================================================================
#MERGE THE SPECTRA WITHOUT EXTERNAL PEAKTABLE
featlist <- mergeMS2spectra(ms2list)

length(featlist)

head(featlist,4)
#At this stage the neutral loss has been generated as shown below
accessNeutralLosses(featlist[[1]])

writeFeaturelist(featlist, "pre_anno.csv")


annotatedSpeclist <- addAnnotations(featlist,"pre_anno.csv")

distmat <- distanceMatrix(annotatedSpeclist) #Generate the cluster matrix

nlmat <- distanceMatrix(annotatedSpeclist, type = "neutral_losses") #generates the cluster matrix with neutral loss information
#=======================================================================================================================================
library(CluMSID)
library(CluMSIDdata)
library(tidyverse)

setwd("/home/javan/Desktop/metabolomics/mzml_files/bal_complete_data")
dir()
T_1 <- extractMS2spectra("T006.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_3 <- extractMS2spectra("T009.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_24 <- extractMS2spectra("T075.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_2 <- extractMS2spectra("T007.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_4 <- extractMS2spectra("T010.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_5 <- extractMS2spectra("T011.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_6 <- extractMS2spectra("T013.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_7 <- extractMS2spectra("T014.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_8 <- extractMS2spectra("T015.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_9 <- extractMS2spectra("T025.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_10 <- extractMS2spectra("T026.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_11 <- extractMS2spectra("T027.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_12 <- extractMS2spectra("T037.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_13 <- extractMS2spectra("T042.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_14 <- extractMS2spectra("T049.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_15 <- extractMS2spectra("T051.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_16 <- extractMS2spectra("T052.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_17 <- extractMS2spectra("T053.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_18 <- extractMS2spectra("T054.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_19 <- extractMS2spectra("T061.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_20 <- extractMS2spectra("T062.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_21 <- extractMS2spectra("T064.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_22 <- extractMS2spectra("T069.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_23 <- extractMS2spectra("T073.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_25 <- extractMS2spectra("T077.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_26 <- extractMS2spectra("T080.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))
T_27 <- extractMS2spectra("T084.mzML",min_peaks = 2,recalibrate_precursor = F,RTlims = c(0,25))

raw_BALlist <- c(T_1,T_2,T_3,T_4,T_5,T_6,T_7,T_8,T_9,T_10,T_11,T_12,T_13,T_14,T_15,T_16,T_17,T_18,T_19,T_20,T_21,T_22,T_23,T_24,T_26,T_27)

length(raw_BALlist)
head(raw_BALlist,2)
showDefault(raw_BALlist[[2]])

featlist <- mergeMS2spectra(raw_BALlist) #merge the spectra with the same pick information
length(featlist)
head(featlist,4)

accessNeutralLosses(featlist[[1]])


writeFeaturelist(featlist, "pre_anno.csv")
annotatedSpeclist <- addAnnotations(featlist, "post_anno.csv")
annotatedSpeclist

distmat <- distanceMatrix(annotatedSpeclist)















