
#Set the working directory
setwd("/home/javan/Desktop/cybersort_source_code")


#Load the source file
source("CIBERSORT.R")

#Run the individual signature matrix file from each patient groups
ltbi_result <- CIBERSORT("LTBI_count_matrix.txt","LM22.txt",perm = 100,QN = TRUE,absolute = FALSE,abs_method = 'sig.score')

write.csv(ltbi_result, file="deconvoluted_LTBI_results.csv,sep=',')

recTB_result <- CIBERSORT("recTB_gene_counts.txt","LM22.txt",perm = 1000, QN = TRUE,absolute = FALSE,abs_method = 'sig.score')

write.csv(recTB_result, file="deconvoluted_recTB_results.csv",sep=',')

prevTB_result <- CIBERSORT("prevTB_gene_counts.txt","LM22.txt",perm = 1000,QN = TRUE,absolute = FALSE,abs_method = 'sig.score')

write.csv(prevTB_result, file="deconvoluted_prevTB_results.csv,sep=',')

