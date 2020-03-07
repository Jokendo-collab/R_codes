
#Enhanced volcano:https://bioconductor.org/packages/release/bioc/vignettes/EnhancedVolcano/inst/doc/EnhancedVolcano.html

#We shall start with proteomics data
setwd("/home/javan/Desktop/norvatis/pathfindR_analysis_folder")
library(EnhancedVolcano)
library(magrittr)
day3=read.delim("PXP0708_05_qprot_melt_quan.txt")
myvars=c("GeneName","MasterAccession" ,"pval","L2FC")

day3=day3[myvars]
EnhancedVolcano(day3,lab = day3$MasterAccession,x = 'L2FC',y = 'pval',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Day three protein expression profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)
#======================================================================================

week1=read.delim("PXP0723_04_qprot_melt_quan_wk1.txt")
myvars=c("GeneName","MasterAccession" ,"pval","L2FC")

week1=week1[myvars]
EnhancedVolcano(week1,lab = week1$MasterAccession,x = 'L2FC',y = 'pval',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Week one protein expression profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)
#==================================================================================

week2=read.delim("PXP0735_04_qprot_melt_quan_wk2.txt")
myvars=c("GeneName","MasterAccession" ,"pval","L2FC")

week2=week2[myvars]
EnhancedVolcano(week2,lab = week2$MasterAccession,x = 'L2FC',y = 'pval',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Week Two protein expression profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)

#==============================================================

month1=read.delim("PXP0736_04_qprot_melt_quan_month1.txt")
myvars=c("GeneName","MasterAccession" ,"pval","L2FC")

month1=month1[myvars]
EnhancedVolcano(month1,lab = month1$MasterAccession,x = 'L2FC',y = 'pval',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Month One protein expression profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)

#========================================================
month2=read.delim("PXP0737_02_qprot_melt_quan_month2.txt")
myvars=c("GeneName","MasterAccession" ,"pval","L2FC")

month2=month2[myvars]
EnhancedVolcano(month2,lab = month2$MasterAccession,x = 'L2FC',y = 'pval',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Month Two protein expression profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)

#=======================================================
month3=read.delim("PXP0737_02_qprot_melt_quan_month2.txt")
myvars=c("GeneName","MasterAccession" ,"pval","L2FC")

month3=month3[myvars]
EnhancedVolcano(month3,lab = month3$MasterAccession,x = 'L2FC',y = 'pval',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Month three protein expression profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)
#========================================================================
#Now we are going to lok at the differentially expressed genes in Tx data

tx=read.table("intact_versus_injured_paired_efit_out.unpiv.txt",header = TRUE, sep = '\t')

tx_d3=tx[tx$contrasts=="InjuredVsIntact_3days", ] #extract different time point contrast

tx_wk1=tx[tx$contrasts=="InjuredVsIntact_1week", ] 

tx_wk2=tx[tx$contrasts=="InjuredVsIntact_2weeks", ] 

tx_mon1=tx[tx$contrasts=="InjuredVsIntact_1months", ] 

tx_mon2=tx[tx$contrasts=="InjuredVsIntact_2months", ] 

tx_mon3=tx[tx$contrasts=="InjuredVsIntact_3months", ] 

#========================================================================

tx_vars=c("SYMBOL","logFC","P.Value")

tx_d3=tx_d3[tx_vars]
EnhancedVolcano(tx_d3,lab = tx_d3$SYMBOL,x = 'logFC',y = 'P.Value',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Day three transcript profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)

#======================================================================
tx_wk1=tx_wk1[tx_vars]
EnhancedVolcano(tx_wk1,lab = tx_wk1$SYMBOL,x = 'logFC',y = 'P.Value',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Week one transcript profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)

#===============================================================
tx_wk2=tx_wk2[tx_vars]
EnhancedVolcano(tx_wk2,lab = tx_wk2$SYMBOL,x = 'logFC',y = 'P.Value',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Week Two transcript profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)

#============================================================
tx_mon1=tx_mon1[tx_vars]
EnhancedVolcano(tx_mon1,lab = tx_mon1$SYMBOL,x = 'logFC',y = 'P.Value',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Month one transcript profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)


#=====================================================
tx_mon2=tx_mon2[tx_vars]
EnhancedVolcano(tx_mon2,lab = tx_mon2$SYMBOL,x = 'logFC',y = 'P.Value',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Month Two transcript profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)

#===============================================
tx_mon3=tx_mon3[tx_vars]
EnhancedVolcano(tx_mon3,lab = tx_mon3$SYMBOL,x = 'logFC',y = 'P.Value',
                xlim = c(-5, 8),
                pCutoff = 0.05,
                title = "Month Two transcript profile",
                FCcutoff = 1.5,
                transcriptPointSize = 1.5,
                transcriptLabSize = 3.0,
                gridlines.major = FALSE,
                gridlines.minor = FALSE)


#=============================================










