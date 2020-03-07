# How to install
setwd("C:/Users/oknjav001/Desktop/PhD_project_metadata/artMS_pipeline")
#getRversion() # checks the R version

#Installing artMS
#install.packages("BiocManager")
#BiocManager::install("artMS")
library(artMS)
#?artmsQualityControlEvidenceBasic

# Example of an inbuilt data for validating if the package is properly installed
suppressWarnings(
  artmsQualityControlEvidenceBasic(evidence_file = artms_data_ph_evidence,
                                   keys_file = artms_data_ph_keys, 
                                   prot_exp =  "PH", 
                                   plotINTDIST = FALSE,
                                   plotREPRO = TRUE,
                                   plotCORMAT = FALSE,
                                   plotINTMISC = FALSE,
                                   plotPTMSTATS = FALSE,
                                   printPDF = FALSE,
                                   verbose = FALSE))
evidence_file <- read.table("evidence.txt",header = T, sep = '\t')
keys <- read.table("keys.txt",header = T,sep = '\t')

head(keys)

#artmsWriteConfigYamlFile(config_file_name = "config.yaml", verbose = FALSE) # write the config file template in the working directory

#artMS quality score
artmsQualityControlEvidenceBasic(evidence_file = evidence_file,
                                 keys_file = keys,
                                 prot_exp = "PH",
                                 plotINTDIST = TRUE,
                                 plotREPRO = F,
                                 plotCORMAT = F,
                                 plotINTMISC = F,
                                 plotPTMSTATS = F,
                                 printPDF = T,
                                 verbose = T)
# Give the full PDF package of these QC metrices
artmsQualityControlEvidenceBasic(evidence_file = evidence_file,
                                                               keys_file = keys,
                                                                 prot_exp = "PH")

# Extended quality score
artmsQualityControlEvidenceExtended(evidence_file = evidence_file,keys_file = keys)

#Extended QC (summary.txt based)
artmsQualityControlSummaryExtended(summary_file = "summary.txt", keys_file = keys)
                                  
# Quantification of change of protein abundance
artmsQuantification(yaml_config_file = 'C:/Users/oknjav001/Desktop/PhD_project_metadata/artMS_pipeline/config.yaml')

#Quantification of Changes in Global Phosphorylation / Ubiquitination
# This step can only be used if the phosporylation enrichment analysis was done
artmsQuantification(yaml_config_file = 'C:/Users/oknjav001/Desktop/PhD_project_metadata/artMS_pipeline/default_config.yaml')

?normalizePath


#Site-specific Quantification of Changes in Phosphorylation / Ubiquitination (PTM identification)
# 1. For phosphrylation
artmsProtein2SiteConversion(evidence_file = "C:/Users/oknjav001/Desktop/PhD_project_metadata/artMS_pipeline/evidence.txt", 
  ref_proteome_file = "C:/Users/oknjav001/Desktop/PhD_project_metadata/artMS_pipeline/uniprot_human_2018.fasta", 
  output_file = "C:/Users/oknjav001/Desktop/PhD_project_metadata/artMS_pipeline/results/ph-sites-evidence.txt", 
  mod_type = "UB")

# 1. For ubiquitination



















