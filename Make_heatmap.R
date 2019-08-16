#This script will generate a heatmap for metabolite features showing differences among treatment groups
#Use the associated Filtered_Heatmap as input for the script
#if "made4" is not available, install it from bioconductor

data<-read.table("Filtered_Heatmap.txt",row.names=1,header=TRUE,sep="\t")
library("made4")
heatplot(t(data[,2:96]),dualScale=TRUE,classvec=data[,1],classvecCol=c("#ffb851","#e4791c","#ffffe5","#662506"))
