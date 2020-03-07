setwd("~/Desktop/norvatis/Tx")

library(fgsea)

df=read.table("human_rat_hcop_six_column.txt",header = T,sep = '\t')

save(df,file = "pathway_data.Rdata")
tx=read.delim("intact_versus_injured_paired_efit_out.unpiv.txt")

head(tx)

day3=tx[tx$contrasts=="InjuredVsIntact_3days", ] #subset data on day three

#Create ranks

ranks <- day3$logFC
names(ranks) <- day3$ENTREZID
head(ranks)

#Plot the ranked fold changes
barplot(sort(ranks, decreasing = T))

listDatasets(mart = mart) #List the availabe genes

library(biomaRt)
mart <- useDataset("rnorvegicus_gene_ensembl", mart=useMart("ensembl"))
bm <- getBM(attributes=c("ensembl_gene_id", "hsapiens_homolog_associated_gene_name"), mart=mart) %>% distinct() %>%
  as_tibble() %>% na_if("") %>% na.omit()
bm















