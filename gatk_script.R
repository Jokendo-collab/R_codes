
install.packages('vcfR',dependencies = T)
library(vcfR)
library(adegenet)
library(adegraphics)
library(pegas)
library(StAMPP)
library(lattice)
library(gplots)
library(ape)
library(ggmap)
library(devtools)

setwd("/home/javan/Desktop/freebayes")

vcf <- read.vcfR("results.vcf")
vcf

#Converting data
x <- vcfR2genlight(vcf)
x

# vcfR
gt <- extract.gt(vcf, element = "GT")
gt[c(2,6,18), 1:1]
gt

chrom <- create.chromR(name='RAD_data', vcf=vcf)
plot(chrom)


#quick check read depth distribution per individual
dp <- extract.gt(vcf, element='DP', as.numeric=TRUE)
pdf("DP_RAD_data.pdf", width = 10, height=3) # boxplot
par(mar=c(8,4,1,1))
boxplot(dp, las=3, col=c("#C0C0C0", "#808080"), ylab="Read Depth (DP)",
        las=2, cex=0.4, cex.axis=0.5)
dev.off()

#============================================================================================
#zoom to smaller values
pdf("DP_RAD_data_zoom.pdf", width = 10, height=3) # boxplot
par(mar=c(8,4,1,1))
boxplot(dp, las=3, col=c("#C0C0C0", "#808080"), ylab="Read Depth (DP)",
        las=2, cex=0.4, cex.axis=0.5, ylim=c(0,50))
abline(h=8, col="red")
dev.off()

#========================================================================================
### convert to genlight
aa.genlight <- vcfR2genlight(vcf, n.cores=1)
locNames(aa.genlight) <- paste(vcf@fix[,1],vcf@fix[,2],sep="_") # add real SNP.names

plot(chrom)
chromoqc(chrom, dp.alpha = 66)

chrom <- proc.chromR(chrom, verbose = TRUE)

plot(chrom)

chromoqc(chrom, dp.alpha = 66)

vcf
dna <- ape::read.dna("GRCh38_latest_genomic.fasta", format = "fasta")

gff <- read.table("GRCh38_latest_genomic.gtf", sep="\t", quote="")

# Create a chromR object.
chrom <- create.chromR(name="Supercontig", vcf=vcf, seq=dna, ann=gff, verbose=TRUE)

chrom
plot(chrom)

chromoqc(chrom, dp.alpha = 66)

chrom <- proc.chromR(chrom, verbose = TRUE)
plot(chrom)

chromoqc(chrom, dp.alpha = 66)

head(chrom@var.info)

head(chrom@win.info)

chrom <- masker(chrom, min_QUAL=0, min_DP=350, max_DP=650, min_MQ=59.5, max_MQ=60.5)
chrom <- proc.chromR(chrom, verbose = TRUE)

chromoqc(chrom, dp.alpha = 22)
chrom <- proc.chromR(chrom, verbose=FALSE, win.size=1e4)
chromoqc(chrom, dp.alpha = 22)

chrom <- proc.chromR(chrom, verbose=FALSE, win.size=1e3)
head(chrom)
plot(chrom)


dp <- extract.gt(chrom, element="DP", as.numeric=TRUE)

rownames(dp) <- 1:nrow(dp)
head(dp)
heatmap.bp(dp[100:150,])

dp <- extract.gt(vcf, element = "DP", as.numeric=TRUE)
dp

par(mar=c(12,4,4,2))
boxplot(dp, col=2:8, las=3)
title(ylab = "Depth (DP)")








































