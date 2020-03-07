
setwd("/home/javan/Desktop/pathfinder")

library(KEGGREST)
library(pathfindR)
# Obtain list of M.musculus pathways

pathways_list <- KEGGREST::keggList("pathway", "rat")

head(pathways_list,20)

# Turn the identifiers of KEGGREST into KEGG-style pathway identifiers
pathway_codes <- sub("path:", "", names(pathways_list))
pathway_codes
# Obtain and parse genes per each pathway
genes_by_pathway <- sapply(pathway_codes, function(pwid){
  pw <- KEGGREST::keggGet(pwid)
  pw <- pw[[1]]$GENE[c(FALSE, TRUE)] ## get gene symbols, not descriptions
  pw <- sub(";.+", "", pw) ## discard any remaining description
  pw <- pw[grepl("^[a-zA-Z0-9_-]*$", pw)] ## remove mistaken lines that cannot be gene symbols
  pw
})

## Form the custom genes object
mmu_kegg_genes <- genes_by_pathway
mmu_kegg_genes <- mmu_kegg_genes[sapply(mmu_kegg_genes, length) != 0]
mmu_kegg_genes <- sapply(mmu_kegg_genes, toupper)
saveRDS(mmu_kegg_genes, "rat_kegg_genes.RDS")

## Form the custom pathways object
mmu_kegg_pathways <- KEGGREST::keggList("pathway", "rat")
names(mmu_kegg_pathways) <- sub("path:", "", names(mmu_kegg_pathways))
mmu_kegg_pathways <- sub(" - Rattus norvegicus\\(rat\\)", "", mmu_kegg_pathways)
mmu_kegg_pathways <- mmu_kegg_pathways[names(mmu_kegg_pathways) %in% names(mmu_kegg_genes)]
saveRDS(mmu_kegg_pathways, "rat_kegg_pathways.RDS")

# Enrichment Analysis with pathfindR --------------------------------------
library(pathfindR)

df <- read.table("pathway_analysis.txt",sep = '\t',header = T)

df <- df[,-1]
df
input_df <- df #readRDS("enrichment_input.RDS")
sif_path <- "/home/javan/Desktop/pathfinder/official_sif_file.sif"
mmu_kegg_genes <- readRDS("mmu_kegg_genes.RDS")
mmu_kegg_pathways <- readRDS("rat_kegg_pathways.RDS")

output_df <- run_pathfindR(input_df, human_genes = FALSE, pin_name_path = sif_path,
                           gene_sets = "Custom", 
                           custom_genes = mmu_kegg_genes, custom_pathways = mmu_kegg_pathways,
                           output_dir = "rat_enrichment_analysis")

# to change the output directory
RA_output <- run_pathfindR(df, output = "human_dir")

# to use an external PIN of user's choice
RA_output <- run_pathfindR(df, pin_name = "/home/javan/Desktop/pathfinder/official_sif_file.sif",custom_genes = mmu_kegg_genes, custom_pathways = mmu_kegg_pathways, gene_sets = "Custom")















