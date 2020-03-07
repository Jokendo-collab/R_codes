## GitHub installation from the source code
#if (!require(devtools, quietly = TRUE)) install.packages("devtools")

## use build_vignettes = FALSE if you did not install pandoc or if you encounter errors when building vignettes (e.g. PRIDE ftp unavailable)!
#install_github("cbielow/PTXQC", build_vignettes = TRUE, dependencies = TRUE)

#install.packages("PTXQC",dependencies = TRUE)
library("devtools")             ## this might give a warning like 'WARNING: Rtools is required ...'. Ignore it.
library(PTXQC) # load the PTXQC library
require(PTXQC)
require(yaml)
require(methods)
#setwd("M:/2018/TB/Clemens/QE/20180807_Reprocessing_BAL/combined_Human_Metanova/")
# Generating the default report
text_folder <- "/home/javan/Desktop/dell/Database_search_results/Crux_filteredUniprot_database" #if you have local MaxQuant output, just use it, loading txt folder in the combined folder

r = createReport(text_folder) #Create the report in *.xml format

cat(paste0("\nReport generated as '", r$report_file, "'\n\n"))
r

#trace("createReport",edit = T) ; this is a special code used to edit a function that was written by someone else












