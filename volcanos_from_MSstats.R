###############################################################################
####### R script for volcano plots from MSstats output from Skyline plugin
###############################################################################


###########################################
########   format data          ###########
###########################################

#### read MSstats output
setwd("P:/JGM_MDPI_protocol/")
read.csv(file="MSstats_output_equalize_medians.csv", head=T, stringsAsFactors = F)->m
#head(m)

#### make subset plotting dataframe
plot.m.p<-cbind(m[,"log2FC"],-log(m[,"pvalue"],base=10))
plot.m.ap<-cbind(m[,"log2FC"],-log(m[,"adj.pvalue"],base=10))

#### rename columns and rows
colnames(plot.m.p)<-c("log2FC","p-value")
colnames(plot.m.ap)<-c("log2FC","adj. p-value")
rownames(plot.m.p)<-substr(m$Protein, start=4, stop=9)
rownames(plot.m.ap)<-substr(m$Protein, start=4, stop=9)

#rownames(plot.m.ap)


# set cutoffs for differential coloring of points
p.cutoff  <- -log(0.05, base=10)
fc.cutoff <- log(1.5, base=2)


#### get subsets of points that are significant = red (up) or blue (down)
m.p.blue<-which(plot.m.p[,1]<(-fc.cutoff) & plot.m.p[,2]>p.cutoff)
m.p.red<-which(plot.m.p[,1]>fc.cutoff & plot.m.p[,2]>p.cutoff)
m.ap.blue<-which(plot.m.ap[,1]<(-fc.cutoff) & plot.m.ap[,2]>p.cutoff)
m.ap.red<-which(plot.m.ap[,1]>fc.cutoff & plot.m.ap[,2]>p.cutoff)



###########################################
########    plot                ###########
###########################################

dev.off()
par(mfcol=c(1,2), cex.axis=1.5)

# with p-value
plot(plot.m.p[,"log2FC"],
     plot.m.p[,"p-value"],
     pch=20,
     ylim=c(0,6),
     bty="n",
     xlab="log2FC",
     ylab="-log10(p-value)",
     main="using p-value")

# color significant points
points(plot.m.p[m.p.red,],col="red",pch=20)
points(plot.m.p[m.p.blue,],col="blue",pch=20)

# with adjusted p-value
plot(plot.m.ap[,"log2FC"],
     plot.m.ap[,"adj. p-value"],
     pch=20,
     ylim=c(0,6),
     bty="n",
     xlab="log2FC",
     ylab="-log10(adjusted p-value)",
     main="using adjusted p-value")


# color significant points
points(plot.m.ap[m.ap.red,],col="red",pch=20)
points(plot.m.ap[m.ap.blue,],col="blue",pch=20)





### add labels?
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("UniProt.ws", version = "3.8")
library(UniProt.ws)
availableUniprotSpecies("cerevisiae")
split_sp <- function(x)unlist(strsplit(x, " "))[1]
up <- UniProt.ws(taxId=4932) ### taxonomy ID for Saccharomyces cerevisiae
taxId(up) <- 4932
??taxId
### genes
uniprot<-rownames(plot.m.p)
#length(unique(uniprot))
#length(uniprot)
keytypes(up)
uniprot
?select
genemap <- select(up,uniprot, "GENE")
typeof(genemap)
length(genemap)
genes <- unlist(lapply(genemap[,2], split_sp))
geneid <- genes[match(uniprot, genemap[,"UNIPROTKB"])]

#####
