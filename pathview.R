setwd("/home/javan/Desktop/pathfinder")

df = read.table("example_data.csv",sep = ',',header = T)

# remove duplicate interactions (if any)
df <- df[!duplicated(df),]

## feature 1: numeric vector
geneList <- df[,2]

## feature 2: named vector
names(geneList) <- as.character(df[,1])

## feature 3: decreasing order
geneList <- sort(geneList, decreasing = TRUE)

head(geneList,2)

gene <- names(geneList)[abs(geneList) > 2]
#WikiPathways analysis
wp2gene <- read.gmt("wikipathways-20190610-gmt-Rattus_norvegicus.gmt")
wp2gene <- wp2gene %>% tidyr::separate(ont, c("name","version","wpid","org"), "%")
wpid2gene <- wp2gene %>% dplyr::select(wpid, gene) #TERM2GENE
wpid2name <- wp2gene %>% dplyr::select(wpid, name) #TERM2NAME

ewp <- enricher(gene, TERM2GENE = wpid2gene, TERM2NAME = wpid2name)
head(ewp)

ewp2 <- GSEA(geneList, TERM2GENE = wpid2gene, TERM2NAME = wpid2name, verbose=T)
head(ewp2)

#MSigDb analysis
BiocManager::install("msigdbr")
library(msigdbr)
msigdbr_show_species()

#We can retrieve all rat gene sets:

m_df <- msigdbr(species = "Rattus norvegicus")
head(m_df, 2) %>% as.data.frame

em <- enricher(gene, TERM2GENE=m_df)
em2 <- GSEA(geneList, TERM2GENE = m_df)
head(em)

##=======================================================================================================
library(breastCancerMAINZ)
library( clusterProfiler)
library(DOSE)
data(geneList)
de <- names(geneList)[abs(geneList) > 2]

edo <- enrichDGN(de)
edo

##Bar Plot
library(enrichplot)
barplot(edo, showCategory=20)

##Dot plot;Dot plot is similar to bar plot with the capability to encode another score as dot size.
edo2 <- gseNCG(geneList, nPerm=10000)
p1 <- dotplot(edo, showCategory=30) + ggtitle("dotplot for ORA")
p2 <- dotplot(edo2, showCategory=30) + ggtitle("dotplot for GSEA")
plot_grid(p1, p2, ncol=2)

##Gene-Concept Network
## convert gene ID to Symbol
edox <- setReadable(edo, 'org.Hs.eg.db', 'ENTREZID')
cnetplot(edox, foldChange=geneList)

## categorySize can be scaled by 'pvalue' or 'geneNum'
cnetplot(edox, categorySize="pvalue", foldChange=geneList)

cnetplot(edox, foldChange=geneList, circular = TRUE, colorEdge = TRUE)

#Heatmap-like functional classification
heatplot(edox)

heatplot(edox, foldChange=geneList)

## Enrichment Map
emapplot(edo)

## UpSet Plot
upsetplot(edo)

##ridgeline plot for expression distribution of GSEA result
ridgeplot(edo2)

##running score and preranked list of GSEA result
gseaplot(edo2, geneSetID = 1, by = "runningScore", title = edo2$Description[1])

gseaplot(edo2, geneSetID = 1, by = "preranked", title = edo2$Description[1])

gseaplot(edo2, geneSetID = 1, title = edo2$Description[1])

##Another method to plot GSEA result is the gseaplot2 function
gseaplot2(edo2, geneSetID = 1, title = edo2$Description[1])

gseaplot2(edo2, geneSetID = 1:3)

##User can also displaying the pvalue table on the plot via pvalue_table parameter:

gseaplot2(edo2, geneSetID = 1:3, pvalue_table = TRUE,color = c("#E495A5", "#86B875", "#7DB0DD"), ES_geom = "dot")

##User can specify subplots to only display a subset of plots:
gseaplot2(edo2, geneSetID = 1:3, subplots = 1:2)

#The gsearank function plot the ranked list of genes belong to the specific gene set.
gsearank(edo2, 1, title = edo2[1, "Description"])

##Multiple gene sets can be aligned using cowplot:
library(ggplot2)
library(cowplot)

pp <- lapply(1:3, function(i) {
  anno <- edo2[i, c("NES", "pvalue", "p.adjust")]
  lab <- paste0(names(anno), "=",  round(anno, 3), collapse="\n")
  
  gsearank(edo2, i, edo2[i, 2]) + xlab(NULL) +ylab(NULL) +
    annotate("text", 0, edo2[i, "enrichmentScore"] * .9, label = lab, hjust=0, vjust=0)
})
plot_grid(plotlist=pp, ncol=1)

##pubmed trend of enriched terms

terms <- edo$Description[1:3]
p <- pmcplot(terms, 2010:2017)
p2 <- pmcplot(terms, 2010:2017, proportion=FALSE)
plot_grid(p, p2, ncol=2)


##goplot;goplot can accept output of enrichGO and visualized the enriched GO induced graph.
goplot(edo)































































