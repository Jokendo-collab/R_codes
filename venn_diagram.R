install.packages('VennDiagram')
setwd("/home/javan/Downloads")
dir()

# Libraries
BiocManager::install("limma")
install.packages("tidyverse")
install.packages("hrbrthemes")
install.packages("tm")
install.packages("proustr")
library(tidyverse)
library(hrbrthemes)
library(tm)
library(proustr)
library(limma)



data <- read.table("venn_diagram.txt",header = T,sep = '\t')
View(data)

#cMake the plot
venn.diagram(
  x = list(
    data %>% filter(artist=="booba") %>% select(word) %>% unlist() , 
    data %>% filter(artist=="nekfeu") %>% select(word) %>% unlist() , 
    data %>% filter(artist=="georges-brassens") %>% select(word) %>% unlist()
  ),
  category.names = c("Booba (1995)" , "Nekfeu (663)" , "Brassens (471)"),
  filename = 'IMG/venn.png',
  output = TRUE ,
  imagetype="png" ,
  height = 480 , 
  width = 480 , 
  resolution = 300,
  compression = "lzw",
  lwd = 1,
  col=c("#440154ff", '#21908dff', '#fde725ff'),
  fill = c(alpha("#440154ff",0.3), alpha('#21908dff',0.3), alpha('#fde725ff',0.3)),
  cex = 0.5,
  fontfamily = "sans",
  cat.cex = 0.3,
  cat.default.pos = "outer",
  cat.pos = c(-27, 27, 135),
  cat.dist = c(0.055, 0.055, 0.085),
  cat.fontfamily = "sans",
  cat.col = c("#440154ff", '#21908dff', '#fde725ff'),
  rotation = 1
)

attach(data)
colnames(data)

Early_log <- data$Early.log
Mid_log <- data$Mid.log
early_stationary <- data$early.stationary
Stationary <- data$Stationary
Late_stationary <- data$Late.stationary
#Single_Colony <- data$Single.Colony

bind_data <- cbind(Early_log,Mid_log,early_stationary,Stationary,Late_stationary)#,Single_Colony)

a <- vennCounts(bind_data)
a
vennDiagram(a)




