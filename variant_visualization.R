#======This script is used to visualize the vcf file

library(vcfR)
setwd("/home/javan/Desktop/rna_analysis_scripts/variant_calling")


#Read VCV, annotation file and genome fasta file

vcf <- read.vcfR("final_filtered.vcf") #Load the vcf file
gff <- read.table("GRCh37_latest_genomic.gtf", sep="\t", quote="")
dna <- ape::read.dna("GRCh38_latest_genomic.fasta", format = "fasta")

#Creating chromR object

chrom <- create.chromR(name='BALF_polymorphisms', vcf=vcf, seq=dna, ann=gff)

#Processing chromR objects
plot(chrom)

chrom <- proc.chromR(chrom, verbose=TRUE)

plot(chrom)

#Visualizing data
chromoqc(chrom, dp.alpha=20)

#we can zoom in further
chromoqc(chrom, xlim=c(2e+05, 2e+05))
#=========================================================================
#==============Variant annotation workflow ===============================

BiocManager::install("SNPlocs.Hsapiens.dbSNP.20101109")
BiocManager::install("rnaseqcomp")

library("VariantAnnotation")
library(SNPlocs.Hsapiens.dbSNP.20101109)
library(vcfR)

vcf <- read.vcfR("final_filtered.vcf") #Load the vcf file

vcf <- readVcf("final_filtered.vcf","hg19")

df <- snpSummary(vcf)
df

rowRanges(vcf) #Granges with 5 metadata columns

info(header(vcf)) #gives the information about the data (vcf)

geno(vcf)

#Genomic positions
head(rowRanges(vcf),10)

#Looking at the reference alleles and alternative SNPs

ref(vcf)[1:10]

alt(vcf)[1:10]

#Info data
info(vcf)[1:4, 1:5]

BiocManager::install("RareVariantVis")

browseVignettes("RareVariantVis")



















